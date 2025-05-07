import type {ProColumns} from '@ant-design/pro-components';
import {ProTable, ActionType, TableDropdown} from '@ant-design/pro-components';
import {Spin, Button, Popconfirm, message, Tooltip, Modal, Table, Tabs} from 'antd';
import {AlertFilled} from '@ant-design/icons';
import {useState, useEffect, useRef} from 'react';
import styles from './index.less'
import {
    startRoleAPI,
    stopRoleAPI,
    getServiceRolesAPI,
    getRoleNamesAPI,
    rolePodEventsAPI
} from '@/services/ant-design-pro/colony';

import SyntaxHighlighter from 'react-syntax-highlighter';
import {tomorrow} from 'react-syntax-highlighter/dist/esm/styles/hljs';
import {ColumnsType} from "antd/lib/table";

const roleTab:React.FC<{ serviceId: any}> = ({serviceId}) => {
    const [confirmLoading, setConfirmLoading] = useState(false);
    const [currentId, setCurrentId] = useState(0);
    const [currentType, setCurrentType] = useState('');
    const [apiLoading, setApiLoading] = useState(false);
    const [rolesInfo, setRolesInfo] = useState<API.rolesInfos[]>();
    const [podEventData, setPodEventData] = useState<PodEventDataType[]>();
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [isPodEventModalOpen, setIsPodEventModalOpen] = useState(false);
    const [roleNameTabs, setRoleNameTabs] = useState<any[]>();
    const [sessionId, setSessionId] = useState('');
    const [logInfo, setLogInfo] = useState('');
    const [socketRef, setSocketRef] = useState<WebSocket>();
    const logInfoRef = useRef(logInfo)
    logInfoRef.current = logInfo
    // const actionRef = useRef<ActionType>();

    interface PodEventDataType {
        type: string;
        count: number;
        lastTimestamp: string;
        reason: string;
        message:string;


    }

    const podEventColumns: ColumnsType<PodEventDataType> = [
        {
            title: '类型',
            dataIndex: 'type',
            key: 'type'
        }
        , {
            title: '触发次数',
            dataIndex: 'count',
            key: 'count'
        },
        {
            title: '最近触发时间',
            dataIndex: 'lastTimestamp',
            key: 'lastTimestamp'
        },
        {
            title: '原因',
            dataIndex: 'reason',
            key: 'reason'
        },
        {
            title: '信息',
            dataIndex: 'message',
            key: 'message'
        }
    ]

    // 获取角色数据
    const getRoles = async () =>{
        const params = {serviceInstanceId: serviceId}
        setApiLoading(true)
        const result = await getServiceRolesAPI(params)
        setApiLoading(false)
        if(result?.success){
            setRolesInfo(result?.data)
            fetchRoleData(result)

        }
    }

    const getLog = (id: any) => {
        try {
            let url = `ws://${process.env.UMI_ENV == 'dev' ? process.env.API_HOST.replace(/^https?:\/\//, '') : window.location.host}/log`  // 'ws://bsvksx.natappfree.cc/log'
            let socket = new window.WebSocket(url)
            setSocketRef(socket)
            socket.onopen = function(){ // socket已连接
                console.log("WebSocket连接成功！")
            };
            socket.onmessage = function(res){ // 接收信息
                // console.log('onmessage接收信息：', res.data, res.data.includes('##sessionId:'));
                if(res.data.includes('##sessionId:')){
                    setSessionId(res.data)
                    if (socket.readyState===1) {
                        socket.send("##roleId:"+id)
                    }
                }else{
                    setLogInfo(logInfoRef.current ? (logInfoRef.current + '\n' + res.data) : res.data)
                }
            };
            socket.onclose = function(evt) {
                console.log("Connection closed.");
            };

            socket.onerror = function(evt) {
                console.log("error!!!", evt);
            };
        } catch (error) {
            console.log(error);
        }
    }

    const handleOk = () => {
        setIsModalOpen(false);
        setLogInfo('')
        socketRef?.close()
    };

    const handleCancel = () => {
        setIsModalOpen(false);
        setLogInfo('')
        // console.log('socketRef: ', socketRef);
        // if (socketRef?.readyState===1) {
        //     socketRef?.send("##colose")
        // }
        socketRef?.close()
    };

    useEffect(()=>{
        getRoles()
        return ()=>{
            socketRef?.close();
        }
    },[])


    const handleConfirm = (type:string, id:number)=>{
        const params = { roleInstanceId: id}
        setCurrentId(id)
        setCurrentType(type)
        switch(type){
            case 'start':  startRole(params);break;
            case 'stop':  stopRole(params);break;
            default: break;
        }
        setCurrentId(0)
        setCurrentType('')
    }

    const startRole = async(params:any)=>{
        setConfirmLoading(true)
        const result = await startRoleAPI(params)
        setConfirmLoading(false)
        if(result?.success){
            message.success('启动成功！', 3)
            getRoles()
        }else{
            message.error('启动失败：'+result?.message, 3)
        }
    }

    const stopRole = async(params:any)=>{
        setConfirmLoading(true)
        const result = await stopRoleAPI(params)
        setConfirmLoading(false)
        if(result?.success){
            message.success('停止成功！', 3)
            getRoles()
        }else{
            message.error('停止失败：'+result?.message, 3)
        }
    }
    const getData = JSON.parse(sessionStorage.getItem('colonyData') || '{}')

    const getPodEvent = async (id: number | undefined) => {
        const result: API.normalResult =  await rolePodEventsAPI({ clusterId: getData.clusterId,roleId: id });
        setPodEventData(result?.data)
    };


    const columns: ProColumns<API.rolesInfos>[] = [
        {
            title: '名称',
            key:'name',
            dataIndex: 'name',
            hideInTable: true,
            render: (_, record) => <>
            <span>{record.name}</span>
            {
                record.alertMsgCnt ?
                <Tooltip
                    placement="top"
                    color="#fff"
                    title={
                    <div className={styles.alertText}>
                        {`告警：`}
                        {record.alertMsgName.map((msg:any,index:any)=>{
                        return <div key={index}>{`${index+1}. ${msg}`}</div>
                        })}
                    </div>
                    }
                >
                    <AlertFilled className={styles.alertIcon} />
                </Tooltip> :''
            }
            </>,
        },

        {
            title: '主机名称',
            key:'nodeHostname',
            dataIndex: 'nodeHostname',
        },
        {
            title: '主机ip',
            key:'nodeHostIp',
            dataIndex: 'nodeHostIp',
        },
        {
            title: '状态',
            key:'roleStatusValue',
            dataIndex: 'roleStatusValue',
            initialValue: 0,
            valueEnum: {
                0: { text: '新增角色部署中', status: 'Processing' },
                1: { text: '角色启动中', status: 'Processing' },
                2: { text: '角色已启动', status: 'Success' },
                3: { text: '角色已停止', status: 'Error' },
                4: { text: '角色停止中', status: 'Error' },
                // error: { text: '异常', status: 'Error' },
            },
        },
        {
            title: '操作',
            key: 'actionBtns',
            dataIndex: 'actionBtns',
            valueType: 'option',
            render: (_, record) => [
                <Popconfirm
                    key='startbtn'
                    title="确定要启动吗?"
                    onConfirm={()=>handleConfirm('start',record?.id || 0)}
                    okText="确定"
                    cancelText="取消"
                >
                    <Button  className={styles.roleBtn} loading={currentType=='start' && currentId == record.id} type="link" >启动</Button>
              </Popconfirm>,
              <Popconfirm
                    key='stopbtn'
                    title="确定要停止吗?"
                    onConfirm={()=>handleConfirm('stop',record?.id || 0)}
                    okText="确定"
                    cancelText="取消"
                >
                    <Button className={styles.roleBtn} loading={currentType=='stop' && currentId == record.id} type="link" >停止</Button>
                </Popconfirm>,
                <Button
                    key='logbtn'
                    onClick={()=>{
                        getLog(record.id)
                        setIsModalOpen(true);
                    }}
                    className={styles.roleBtn}
                    type="link"
                >实时日志</Button>,
                <Button
                    key='eventbtn'
                    onClick={() => {
                        getPodEvent(record.id)
                        setIsPodEventModalOpen(true);
                    }}
                    className={styles.roleBtn}
                    type="link"
                >pod事件</Button>

                // <a key="link">启动</a>,
                // <a key="link2">停止</a>,
                // <a key="link5">删除</a>,
                // <TableDropdown
                //     key="actionGroup"
                //     menus={[
                //         { key: 'copy', name: '复制' },
                //         { key: 'delete', name: '删除' },
                //     ]}
                // />,
            ],
        },
    ];
     function fetchRoleData(result: API.serviceRolesResult) {
        const roleNames = result.data?.map((value, index, array) => {
            return String(value.name)
        })

        // roleNames去重
        const roleTabs= Array.from(new Set(roleNames))?.map((name, i) => {
            return {
                label: `${name}`,
                key: name,
                children:  (
                    <Spin tip="Loading" size="small" spinning={!!apiLoading || !!confirmLoading}>
                        <ProTable
                            dataSource={result.data?.filter((item) => {
                                return item.name === name
                            })}

                            rowKey="id"
                            pagination={{
                                showQuickJumper: true,
                            }}
                            columns={columns}
                            search={false}
                            options={false}


                        />
                    </Spin>),
            };
        })

        setRoleNameTabs(roleTabs)
    }



    return (
        <div style={{minHeight:'200px'}} className={styles.roleTab}>
            <Tabs
                defaultActiveKey="1"
                tabPosition={'left'}
                // style={{ height: 220 }}
                items={roleNameTabs}
            />

            <Modal
                key="logmodal"
                title={<>日志信息 &nbsp;&nbsp;<Spin size="small"/></>}
                width="80%"
                style={{height:'80vh'}}
                forceRender={true}
                destroyOnClose={false}
                open={isModalOpen}
                onOk={handleOk}
                onCancel={handleCancel}
                footer={null}
            >
                <SyntaxHighlighter
                    language="yaml"
                    style={tomorrow}
                    showLineNumbers
                    customStyle={{height:'60vh',overflow:'auto'}}
                >
                    {logInfoRef.current}
                </SyntaxHighlighter>
            </Modal>
            <Modal
                key="eventmodal"
                title={<>pod事件信息 &nbsp;&nbsp;</>}
                width="80%"
                style={{height: '80vh'}}
                forceRender={true}
                destroyOnClose={false}
                open={isPodEventModalOpen}
                onOk={() => setIsPodEventModalOpen(false)}
                onCancel={() => setIsPodEventModalOpen(false)}
                footer={null}
            >
                <Table columns={podEventColumns} dataSource={podEventData}/>;
            </Modal>
        </div>
    )
}

export default roleTab
