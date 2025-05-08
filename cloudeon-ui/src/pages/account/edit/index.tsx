import { PageContainer } from '@ant-design/pro-components';
import { Form, Input, Button, message } from 'antd';
import { history } from 'umi';
import styles from './index.less';
import { updatePasswordAPI } from '@/services/ant-design-pro/colonyLogin';

const EditUser: React.FC = () => {
  const [form] = Form.useForm();
  const currentUser = JSON.parse(sessionStorage.getItem('currentUser') || '{}');

  const onFinish = async (values: any) => {
    try {
      const result = await updatePasswordAPI({
        username: currentUser.name,
        oldPassword: values.oldPassword,
        newPassword: values.newPassword,
      });
      
      if (result && result.success) {
        message.success('密码修改成功');
        history.push('/');
      } else {
        message.error(result?.message || '密码修改失败');
      }
    } catch (error) {
      message.error('密码修改失败');
    }
  };

  const handleBack = () => {
    history.goBack();
  };

  return (
    <PageContainer>
      <div className={styles.editUserContainer}>
        <Form
          form={form}
          name="editUser"
          onFinish={onFinish}
          layout="vertical"
          autoComplete="off"
          initialValues={{
            username: currentUser.name
          }}
        >
          <Form.Item
            name="username"
            label="用户名"
            rules={[{ required: true, message: '请输入用户名' }]}
          >
            <Input disabled autoComplete="off" />
          </Form.Item>

          <Form.Item
            name="oldPassword"
            label="当前密码"
            rules={[{ required: true, message: '请输入当前密码' }]}
          >
            <Input.Password autoComplete="off" />
          </Form.Item>

          <Form.Item
            name="newPassword"
            label="新密码"
            rules={[
              { required: true, message: '请输入新密码' },
              { min: 5, message: '密码长度不能小于6位' }
            ]}
          >
            <Input.Password autoComplete="new-password" />
          </Form.Item>

          <Form.Item
            name="confirmPassword"
            label="确认新密码"
            dependencies={['newPassword']}
            rules={[
              { required: true, message: '请确认新密码' },
              ({ getFieldValue }) => ({
                validator(_, value) {
                  if (!value || getFieldValue('newPassword') === value) {
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
              保存修改
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

export default EditUser; 