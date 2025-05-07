/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package org.dromara.cloudeon.processor;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.IoUtil;
import com.google.common.collect.Maps;
import io.fabric8.kubernetes.api.model.HasMetadata;
import io.fabric8.kubernetes.client.dsl.ParameterNamespaceListVisitFromServerGetDeleteRecreateWaitApplicable;
import lombok.NoArgsConstructor;
import org.dromara.cloudeon.entity.ServiceInstanceConfigEntity;
import org.dromara.cloudeon.entity.ServiceInstanceEntity;
import org.dromara.cloudeon.entity.StackServiceEntity;
import org.dromara.cloudeon.utils.Constant;
import org.dromara.cloudeon.utils.FreemarkerUtil;
import org.dromara.cloudeon.utils.K8sUtil;

import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@NoArgsConstructor
public abstract class MonitorConfigTask extends BaseCloudeonTask implements ApplyOrDeleteTask {

    @Override
    public void internalExecute() {
        Integer serviceInstanceId = taskParam.getServiceInstanceId();
        ServiceInstanceEntity serviceInstanceEntity = serviceInstanceRepository.findById(serviceInstanceId).get();
        StackServiceEntity stackServiceEntity = stackServiceRepository.findById(serviceInstanceEntity.getStackServiceId()).get();
        Integer clusterId = serviceInstanceEntity.getClusterId();
        Integer globalServiceInstanceId = serviceInstanceRepository.findByClusterIdAndStackServiceName(serviceInstanceEntity.getClusterId(), "GLOBAL");
        List<ServiceInstanceConfigEntity> globalConfigEntityList = configRepository.findByServiceInstanceId(globalServiceInstanceId);

        Map<String, String> globalConfigMap = globalConfigEntityList.stream().collect(Collectors.toMap(ServiceInstanceConfigEntity::getName, ServiceInstanceConfigEntity::getValue));

        String stackCode = stackServiceEntity.getStackCode();
        String stackServiceName = K8sUtil.formatK8sNameStr(stackServiceEntity.getName());

        Map<String, Object> dataModel = serviceService.getDataModel(serviceInstanceId, taskParam.getRoleName());
        Map<String, String> labels = Maps.newHashMap();
        labels.put("name", K8sUtil.formatK8sNameStr(stackServiceEntity.getName()));

        // 设置加载的目录
        String serviceBaseDir = cloudeonConfigProp.getStackLoadPath() + File.separator + stackCode + File.separator + stackServiceName;
        Map<String, String> fileStrMap = Maps.newHashMap();

        // 加载kube-prometheus-render目录
        // 目录下的每一个文件都将视为k8s模板文件进行渲染后操作
        if (!"NONE".equals(globalConfigMap.get("global.monitor.type"))) {
            String kubePrometheusRenderDir = serviceBaseDir + File.separator + Constant.KUBE_PROMETHEUS_RENDER_DIR;
            File kubePrometheusRenderDirFile = new File(kubePrometheusRenderDir);
            if (!FileUtil.isEmpty(kubePrometheusRenderDirFile)) {
                log.info("加载kube-prometheus-render目录：" + kubePrometheusRenderDirFile);
                for (File file : Objects.requireNonNull(kubePrometheusRenderDirFile.listFiles())) {
                    if (file.isDirectory()) {
                        continue;
                    }
                    String renderStr = FreemarkerUtil.templateEval(FileUtil.readUtf8String(file), dataModel);
                    kubeService.executeWithKubeClient(clusterId, client -> {
                        try (InputStream in = IoUtil.toUtf8Stream(renderStr)) {
                            ParameterNamespaceListVisitFromServerGetDeleteRecreateWaitApplicable<HasMetadata> resource = client.load(in);
                            if (isApplyTask()) {
                                resource.forceConflicts().serverSideApply();
                            } else {
                                resource.delete();
                            }
                        } catch (Exception e) {
                            log.error("处理资源失败，资源内容如下：\n" + renderStr);
                            ExceptionUtil.wrapAndThrow(e);
                        }
                    });
                }
            } else {
                log.info("kube-prometheus-render目录为空");
            }
        }
    }

}
