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
package org.dromara.cloudeon.entity;

import org.dromara.cloudeon.enums.CommandState;
import org.dromara.cloudeon.enums.CommandType;
import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * 指令表
 */
@Entity
@Table(name = "ce_command")
@Data
public class CommandEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private Integer id;

    /**
     * 指令名称
     */
    private String name;

    /**
     * 指令类型
     */
    @Convert(converter = CommandTypeConverter.class)
    private CommandType type;

    /**
     * 指令运行状态
     */
    @Enumerated(EnumType.STRING)
    private CommandState commandState;

    /**
     * 提交时间
     */
    private Date submitTime;

    /**
     * 开始时间
     */
    private Date startTime;

    /**
     * 结束时间
     */
    private Date endTime;

    /**
     * 总进度
     */
    private Integer currentProgress;





    /**
     * 操作人id
     */
    private Integer operateUserId;



    private Integer clusterId;
}
