import React from 'react';
import AdminService from '../../services/AdminService'; // Assuming this fetches admin data
import { Layout, Menu } from 'antd';
import {
    UserOutlined,
    VideoCameraOutlined,
    UploadOutlined,
    BarChartOutlined,
    CloudOutlined,
    AppstoreOutlined,
} from '@ant-design/icons';
import { Link, useLocation } from 'react-router-dom';

const { Sider } = Layout;

const ListAdminComponent = () => {
    const [admins, setAdmins] = React.useState([]); // State for admin data
    const location = useLocation(); // Get current location

    const isAdminActive = () => location.pathname === '/ListAdminComponent'; // Check if current path is '/users'

    React.useEffect(() => {
        const refreshAdmins = async () => {
            console.log("Get All Admins");
            try {
                const response = await AdminService.getAllAdmins();
                setAdmins(response.data);
            } catch (error) {
                console.error("Error fetching admins:", error);
            }
        };

        refreshAdmins();
    }, []); // Empty dependency array to run effect only once

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'Users', url: '/' },
        { icon: <VideoCameraOutlined />, label: 'Vendors', url: '/vendors' },
        { icon: <UploadOutlined />, label: 'Groceries', url: '/groceries' },
        { icon: <BarChartOutlined />, label: 'Analytics', url: '/analytics' },
        { icon: <CloudOutlined />, label: 'Machine Learning', url: '/ml' },
        { icon: <AppstoreOutlined />, label: 'Content Management', url: '/content-management' },
    ];

    return (
        <Layout>
            <Sider
                width={210}
                style={{
                    background: '#001529', // Dark blue background color
                    overflow: 'auto',
                    height: '100vh',
                }}
            >
                <Menu theme="dark" mode="inline" defaultSelectedKeys={['1']}>
                    {sidebarItems.map((item, index) => (
                        <Menu.Item key={index + 1} icon={item.icon}>
                            <Link to={item.url}>{item.label}</Link>
                        </Menu.Item>
                    ))}
                </Menu>
            </Sider>
            <Layout>
                <div style={{ padding: '24px' }}>
                    <h2 style={{ marginLeft: '5px' }}>Users</h2>

                    <table className="table table-striped" style={{ margin: '0 auto' }}>
                        <thead>
                        <tr>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Options</th>
                        </tr>
                        </thead>
                        <tbody>
                        {admins.map(admin => (
                            <tr key={admin.admin_id}>
                                <td>{admin.email}</td>
                                <td>{admin.admin_role}</td>
                                <td align="center">
                                    <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link> &nbsp;
                                    <Link to={`/`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link> &nbsp;
                                    <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link> &nbsp;
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListAdminComponent;
