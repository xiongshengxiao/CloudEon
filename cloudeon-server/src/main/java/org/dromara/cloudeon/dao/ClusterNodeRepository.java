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
package org.dromara.cloudeon.dao;

import org.dromara.cloudeon.entity.ClusterNodeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import java.util.List;

public interface ClusterNodeRepository extends JpaRepository<ClusterNodeEntity, Integer> {
    Integer countByIp(String ip);

    @Modifying
    void deleteByClusterId(Integer clusterId);

    Integer countByClusterId(Integer clusterId);

    ClusterNodeEntity findByHostname(String hostname);

    ClusterNodeEntity findByHostnameOrIp(String hostname, String ip);

    List<ClusterNodeEntity> findByClusterId(Integer clusterId);
}