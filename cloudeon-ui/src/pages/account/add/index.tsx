import { PageContainer } from '@ant-design/pro-components';
import { Form, Input, Button, message } from 'antd';
import { history } from 'umi';
import styles from './index.less';
import { registerAPI } from '@/services/ant-design-pro/colonyLogin';

const AddUser: React.FC = () => {
  const [form] = Form.useForm();

  const onFinish = async (values: any) => {
    try {
      const result = await registerAPI({
        username: values.username,
        password: values.password,
      });
      
      if (result && result.success) {
        message.success('添加账号成功');
        history.push('/');
      } else {
        message.error(result?.message || '添加账号失败');
      }
    } catch (error) {
      message.error('添加账号失败');
    }
  };

  const handleBack = () => {
    history.goBack();
  };

  return (
    <PageContainer>
      <div className={styles.addUserContainer}>
        <Form
          form={form}
          name="addUser"
          onFinish={onFinish}
          layout="vertical"
          autoComplete="off"
        >
          <Form.Item
            name="username"
            label="用户名"
            rules={[{ required: true, message: '请输入用户名' }]}
          >
            <Input autoComplete="off" />
          </Form.Item>

          <Form.Item
            name="password"
            label="密码"
            rules={[
              { required: true, message: '请输入密码' },
              { min: 5, message: '密码长度不能小于6位' }
            ]}
          >
            <Input.Password autoComplete="new-password" />
          </Form.Item>

          <Form.Item
            name="confirmPassword"
            label="确认密码"
            dependencies={['password']}
            rules={[
              { required: true, message: '请确认密码' },
              ({ getFieldValue }) => ({
                validator(_, value) {
                  if (!value || getFieldValue('password') === value) {
                    return Promise.resolve();
                  }
                  return Promise.reject(new Error('两次输入的密码不一致'));
                },
              }),
            ]}
          >
            <Input.Password autoComplete="new-password" />
          </Form.Item>

          <Form.Item>
            <Button type="primary" htmlType="submit" style={{ marginRight: 8 }}>
              添加
            </Button>
            <Button onClick={handleBack}>
              返回
            </Button>
          </Form.Item>
        </Form>
      </div>
    </PageContainer>
  );
};

export default AddUser; 