import { PageContainer } from '@ant-design/pro-components';
import { Card, Descriptions } from 'antd';
import styles from './index.less';

const UserCenter: React.FC = () => {
  const currentUser = JSON.parse(sessionStorage.getItem('currentUser') || '{}');

  return (
    <PageContainer>
      <div className={styles.userCenterContainer}>
        <Card title="个人信息">
          <Descriptions column={1}>
            <Descriptions.Item label="用户名">{currentUser.name}</Descriptions.Item>
            <Descriptions.Item label="上次登录时间">-</Descriptions.Item>
          </Descriptions>
        </Card>
      </div>
    </PageContainer>
  );
};

export default UserCenter; 