import { PageContainer } from '@ant-design/pro-components';
import { Card, Form, Input, Button, message } from 'antd';
import styles from './index.less';

const UserSettings: React.FC = () => {
  const [form] = Form.useForm();
  const currentUser = JSON.parse(sessionStorage.getItem('currentUser') || '{}');

  const onFinish = async (values: any) => {
    try {
      // TODO: 调用设置API
      message.success('设置已保存');
    } catch (error) {
      message.error('保存失败');
    }
  };

  return (
    <PageContainer>
      <div className={styles.settingsContainer}>
        <Card title="个人设置">
          <Form
            form={form}
            name="settings"
            onFinish={onFinish}
            initialValues={currentUser}
            layout="vertical"
          >
            <Form.Item
              name="email"
              label="邮箱"
              rules={[{ type: 'email', message: '请输入有效的邮箱地址' }]}
            >
              <Input />
            </Form.Item>

            <Form.Item>
              <Button type="primary" htmlType="submit">
                保存设置
              </Button>
            </Form.Item>
          </Form>
        </Card>
      </div>
    </PageContainer>
  );
};

export default UserSettings; 