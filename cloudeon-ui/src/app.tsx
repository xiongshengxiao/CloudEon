import Footer from '@/components/Footer';
import RightContent from '@/components/RightContent';
import { QuestionCircleFilled, GithubFilled } from '@ant-design/icons';
import type { Settings as LayoutSettings } from '@ant-design/pro-components';
import { PageLoading, SettingDrawer } from '@ant-design/pro-components';
import type { RunTimeLayoutConfig } from 'umi';
import { history, RequestConfig, useModel } from 'umi';
import { message, Image, notification } from 'antd';
import defaultSettings from '../config/defaultSettings';
// import { currentUser as queryCurrentUser } from './services/ant-design-pro/api';
import logoImg from '../src/assets/images/logo2.png';
import userImg from '../src/assets/images/user.png'
import React, { useEffect } from 'react';
import * as Icon from '@ant-design/icons';
import {
  RobotOutlined,
} from '@ant-design/icons';
import { getCountActiveAPI } from './services/ant-design-pro/colony';
import styles from './app.less'


const isDev = process.env.NODE_ENV === 'development';
const loginPath = '/user/login';


// const menuIcons = {
//   '节点':'RobotOutlined',
//   '服务':'CloudServerOutlined',
//   '指令':'AimOutlined',
//   '告警':'AlertOutlined'
// }
// // antd4中动态创建icon
// const createIcon = (key: any) => {
//   console.log('--key:', key);

//   const icon = React.createElement(
//     // Icon[menuIcons[key]||'RobotOutlined'],
//     key,
//     {
//       style:{ fontSize: '24px'}
//     }
//   )
//   return icon
// }


// 接口请求全局配置
export const request: RequestConfig = {
  timeout: 1000*60,
  errorHandler:(error: any)  => {
    if(error && error.name==="BizError"){
      const { response } = error;
      if ('success' in response && !response.success) {
        // 处理token过期或无效的情况
        if(('message' in response) &&
            (response?.message.includes('Token无效') ||
                response?.message.includes('Token已过期') ||
                response?.message.includes('未登录'))) {
          // 清除session并跳转到登录页
          sessionStorage.clear();
          history.push(loginPath);
          return;
        } else {
          notification.error({
            message: '请求错误',
            description: <>{`${('message' in response) ? response.message : '接口报错'}`}</>,
            duration: 3,
            style: {
              width: 500
            }
          });
          return {
            success: false,
            data: [],
            message: ''
          };
        }
      }
    }
    return error;
  },
  errorConfig: {
  },
  // 自定义端口规范
  // errorConfig: {
  //   adaptor: res => {
  //     return {
  //       success: res.code ==config.successCode,
  //       data:res.data,
  //       errorCode:res.code,
  //       errorMessage: res.msg,
  //     };
  //   },
  middlewares: [],
  requestInterceptors: [
    (url,options) => {
      let headers = { satoken:'' }

      // 如果是登录请求，不需要token
      if (url.includes('/acc/doLogin')) {
        return {
          url,
          options: { ...options, headers }
        };
      }

      // 获取token和用户信息
      const token = sessionStorage.getItem('token');
      const userInfo = JSON.parse(sessionStorage.getItem('currentUser') || '{}');

      // 如果没有token或用户信息，且不是登录相关的请求，重定向到登录页
      if ((!token || !userInfo.name) && !url.includes('/acc/')) {
        history.push(loginPath);
        return {
          url,
          options: { ...options, headers }
        };
      }

      headers.satoken = token || '';
      return {
        url,
        options: { ...options, headers }
      };
    }
  ],
  responseInterceptors: [
    (response: any) => {
      const codeMaps: Record<number, string> = {
        401: '未登录或登录已过期，请重新登录。',
        403: '没有权限访问。',
        502: '网关错误。',
        503: '服务不可用，服务器暂时过载或维护。',
        504: '网关超时。',
      };

      // 处理401未授权的情况
      if (response.status === 401) {
        sessionStorage.clear(); // 清除所有session数据
        history.push(loginPath);
        return response;
      }

      // 处理其他错误状态码
      const errorMessage = codeMaps[response.status];
      if (errorMessage) {
        message.error(errorMessage);
      }

      return response;
    }
  ],
};

/** 获取用户信息比较慢的时候会展示一个 loading */
export const initialStateConfig = {
  loading: <PageLoading />,
};

/**
 * @see  https://umijs.org/zh-CN/plugins/plugin-initial-state
 * */
export async function getInitialState(): Promise<{
  settings?: Partial<LayoutSettings>;
  currentUser?: API.CurrentUser;
  loading?: boolean;
  fetchUserInfo?: () => Promise<API.CurrentUser | undefined>;
}> {
  const fetchUserInfo = async () => {
    try {
      const token = sessionStorage.getItem('token');
      if (!token) {
        throw new Error('No token');
      }

      // 使用已配置的request拦截器来处理token
      const response = await fetch('/apiPre/acc/isLogin', {
        method: 'GET',
        headers: {
          'satoken': token
        }
      }).then(res => res.json());

      if (!response.success) {
        throw new Error('Token invalid');
      }

      const currentUser = JSON.parse(sessionStorage.getItem('currentUser') || '{}');
      return currentUser;
    } catch (error) {
      // 只有在明确token无效时才清除session
      if (error.message === 'Token invalid') {
        sessionStorage.clear();
        history.push(loginPath);
      }
      return undefined;
    }
  };

  // 如果不是登录页面，执行token验证
  if (history.location.pathname !== loginPath) {
    const currentUser = await fetchUserInfo();
    if (currentUser) {
      return {
        fetchUserInfo,
        currentUser,
        settings: defaultSettings,
      };
    }
  }

  return {
    fetchUserInfo,
    settings: defaultSettings,
  };
}

let timer:any = null

history.block((location, action) => {
  //每次路由变动都会走这里
  if(location.pathname.includes('user/login') && timer){
    console.log("location.pathname.includes('user/login'):", location.pathname.includes('user/login'));
    // 清除定时任务
    clearInterval(timer)
    timer = null
  }
})

// ProLayout 支持的api https://procomponents.ant.design/components/layout
export const layout: RunTimeLayoutConfig = ({ initialState, setInitialState }) => {

  return {
    rightContentRender: () => <RightContent />,
    disableContentMargin: false,
    waterMarkProps: {
      // 水印
      // content: initialState?.currentUser?.name,
    },
    footerRender: () => <Footer />,
    onPageChange: () => {
      const { location } = history;
      const token = sessionStorage.getItem('token');
      const isLoginPage = location.pathname === loginPath;

      // 如果是登录页面且有token，跳转到首页
      if (isLoginPage && token) {
        history.push('/');
        return;
      }

      // 如果不是登录页面且没有token，跳转到登录页
      if (!isLoginPage && !token) {
        sessionStorage.clear(); // 确保清除所有session数据
        history.push(loginPath);
      }
    },
    links: isDev
        ? [
          // <Link key="openapi" to="/umi/plugin/openapi" target="_blank">
          //   <LinkOutlined />
          //   <span>OpenAPI 文档</span>
          // </Link>,
          // <Link to="/~docs" key="docs">
          //   <BookOutlined />
          //   <span>业务组件文档</span>
          // </Link>,
        ]
        : [],
    menuHeaderRender: undefined,
    // 自定义 403 页面
    // unAccessible: <div>unAccessible</div>,
    // 增加一个 loading 的状态
    childrenRender: (children: any, props: { location: { pathname: string | string[]; }; }) => {
      if (initialState?.loading) return <PageLoading />;
      return (
          <>
            {children}
            {!props.location?.pathname?.includes('/login') && (
                <SettingDrawer
                    disableUrlParams
                    enableDarkTheme
                    settings={initialState?.settings}
                    onSettingChange={(settings) => {
                      setInitialState((preInitialState) => ({
                        ...preInitialState,
                        settings,
                      }));
                    }}
                />
            )}
          </>
      );
    },
    ...initialState?.settings,
    logo:<><Image preview={false} src={logoImg}/></>,
    // layout: 'side',
    breakpoint: true,
    fixedHeader:true,
    collapsed:false,
    collapsedButtonRender: false,
    menuFooterRender:()=><></>,
    menuItemRender: (itemProps: any, defaultDom: any, props: any) => {
      // console.log('--menuItemRender: ');
      const getData = JSON.parse(sessionStorage.getItem('colonyData') || '{}')
      const { actionCount, setActionCount } = useModel('colonyModel', model => ({ actionCount: model.actionCount, setActionCount: model.setActionCountModel }));

      useEffect(()=>{
        const getCount = async()=>{
          const result = await getCountActiveAPI({clusterId:getData.clusterId})
          setActionCount(result?.data || 0 )
        }
        if(getData && getData.clusterId && !timer && !location.href.includes('user/login') && !location.href.includes('colony/colonyMg')){
          getCount()
          timer = setInterval(getCount,3000)
        }
        return ()=>{
          timer && clearInterval(timer)
          timer = null
        }
      },[])

      return <div className={styles.menuList} style={{height:'100%',display:'flex',justifyContent: 'center',flexDirection:'column', alignItems:'center',width:'100%'}}
                  onClick={() => {
                    history.push(itemProps.path);
                  }}>
        <div style={{display:'inline-flex',lineHeight:'30px', fontSize: '24px',position:'relative'}}>
          {/* {itemProps.icon} */}

          {itemProps.name == '指令' ? (<>
            <div className={`${styles.countWrap} ${actionCount ? styles.countBoxshow:''}`}>
              <div className={styles.countBox}>
                {actionCount}
              </div>
            </div>
          </>):''}
          {/* {createIcon(itemProps.icon)} */}
          <div className={styles.menuIcon} >{itemProps.icon}</div>
        </div>
        <div className={styles.menuText} >{itemProps.name}</div>
      </div>
    }
  };
};
