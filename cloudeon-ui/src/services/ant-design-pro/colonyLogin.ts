import { request } from 'umi';

export async function loginAPI(options?: { [key: string]: any }) {
    return request<API.stringResult>('/apiPre/acc/doLogin', {
        method: 'GET',
        params: {
            ...options,
        },
        headers: {
            'Content-Type': 'application/json',
        }
    });
}

export async function logoutAPI(options?: { [key: string]: any }) {
    return request<API.stringResult>('/apiPre/acc/logout', {
        method: 'GET',
        params: {
            ...options,
        },
        headers: {
            'Content-Type': 'application/json',
        }
    });
}

export async function updatePasswordAPI(params: {
    username: string;
    oldPassword: string;
    newPassword: string;
}) {
    return request<API.stringResult>('/apiPre/acc/updatePassword', {
        method: 'POST',
        params: params,
    });
}

export async function registerAPI(params: {
    username: string;
    password: string;
}) {
    return request<API.stringResult>('/apiPre/acc/register', {
        method: 'POST',
        params: params,
    });
}