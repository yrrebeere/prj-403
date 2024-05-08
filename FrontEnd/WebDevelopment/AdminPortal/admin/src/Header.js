import React from 'react';
import * as icons from '@ant-design/icons';
import { Layout, Menu, theme } from 'antd';
import { Link } from 'react-router-dom'; // Import Link from react-router-dom

const { Sider } = Layout;
const { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined, TeamOutlined, ShopOutlined } = icons;

const items = [
    { icon: UserOutlined, label: 'Users', url: '/' },
    { icon: VideoCameraOutlined, label: 'Vendors', url: '/vendors' },
    { icon: UploadOutlined, label: 'Groceries', url: '/groceries' },
    { icon: BarChartOutlined, label: 'Analytics', url: '/analytics' },
    { icon: CloudOutlined, label: 'Machine Learning', url: '/ml' },
    { icon: AppstoreOutlined, label: 'Content Management', url: '/content-management' },
].map((item, index) => ({
    key: String(index + 1),
    icon: React.createElement(item.icon),
    label: item.label,
    url: item.url,
}));

const AppHeader = () => {
    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();

    return (
        <Sider
            width={210} // Set the width of the sidebar
            style={{
                background: colorBgContainer,
                overflow: 'auto',
                height: '100vh', // Set the height of the sidebar to the full viewport height
                position: 'fixed',
                left: 0,
                top: 0,
            }}
        >
            <Menu theme="dark" mode="inline" defaultSelectedKeys={['4']} items={items.map(item => ({ ...item, name: item.label }))}>
                {items.map(item => (
                    <Menu.Item key={item.key} icon={item.icon}>
                        <Link to={item.url}>{item.label}</Link>
                    </Menu.Item>
                ))}
            </Menu>
        </Sider>
    );
};

export default AppHeader;
