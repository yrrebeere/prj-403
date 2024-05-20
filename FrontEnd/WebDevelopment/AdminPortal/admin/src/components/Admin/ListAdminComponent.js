import React, { useState, useEffect } from 'react';
import AdminService from '../../services/AdminService';
import UserService from '../../services/UserService';  // Import UserService
import { Link, useLocation } from 'react-router-dom';
import { Menu, Layout, Input } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input;

const ListAdminComponent = () => {
    const [admins, setAdmins] = useState([]);
    const [users, setUsers] = useState({});
    const [searchTerm, setSearchTerm] = useState('');
    const location = useLocation();

    useEffect(() => {
        refreshAdmins();
    }, []);

    const refreshAdmins = () => {
        AdminService.getAllAdmins()
            .then((response) => {
                const adminData = response.data;
                setAdmins(adminData);
                fetchUserDetails(adminData);
            })
            .catch(error => {
                console.error("Error fetching admins:", error);
            });
    };

    const fetchUserDetails = (admins) => {
        admins.forEach(admin => {
            UserService.getUserById(admin.user_table_user_id)
                .then((response) => {
                    setUsers(prevUsers => ({
                        ...prevUsers,
                        [admin.user_table_user_id]: response.data
                    }));
                })
                .catch(error => {
                    console.error(`Error fetching user details for user ID ${admin.user_table_user_id}:`, error);
                });
        });
    };

    const deleteAdmin = (adminId, userId) => {
        // Delete admin record first
        AdminService.deleteAdmin(adminId)
            .then(() => {
                // Then delete user record
                return UserService.deleteUser(userId);
            })
            .then(() => {
                refreshAdmins();
            })
            .catch(error => {
                console.error("Error deleting admin or user:", error);
            });
    };

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const filteredAdmins = admins.filter(admin => {
        const emailMatch = admin.email.toLowerCase().includes(searchTerm);
        const roleMatch = admin.admin_role.toLowerCase().includes(searchTerm);
        const user = users[admin.user_table_user_id];
        return emailMatch || roleMatch;
    });

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'Admin Management', url: '/' },
        { icon: <UploadOutlined />, label: 'Grocery Management', url: '/stores' },
        { icon: <VideoCameraOutlined />, label: 'Vendor Management', url: '/vendors' },
        { icon: <BarChartOutlined />, label: 'Analytics', url: '/analytics' },
        { icon: <AppstoreOutlined />, label: 'Product Management', url: '/products' },
        { icon: <AppstoreOutlined />, label: 'Category Management', url: '/categories' },
    ];

    return (
        <Layout>
            <Sider
                width={220}
                style={{
                    background: '#fff',
                    overflow: 'auto',
                    height: '100vh',
                }}
            >
                <div style={{ display: 'flex', alignItems: 'center' }}>
                    <div style={{
                        paddingTop: '30px',
                        paddingBottom: '25px',
                        paddingLeft: '25px',
                        color: 'green',
                        fontSize: '18px',
                        fontWeight: 'bold'
                    }}>
                        WASAIL
                    </div>
                </div>

                <Menu
                    theme="light"
                    mode="inline"
                    defaultSelectedKeys={['2']}
                    selectedKeys={[location.pathname]}
                >
                    {sidebarItems.map((item, index) => (
                        <Menu.Item key={index + 1} icon={item.icon} style={{ marginBottom: '20px' }}>
                            <Link to={item.url}>{item.label}</Link>
                        </Menu.Item>
                    ))}
                </Menu>
            </Sider>
            <Layout>
                <div style={{ padding: '1px' }}>
                    <div style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        marginBottom: '20px'
                    }}>
                        <div style={{
                            paddingTop: '25px',
                            paddingBottom: '25px',
                            paddingLeft: '25px',
                            color: 'black',
                            fontSize: '20px',
                            fontWeight: 'bold'
                        }}>
                            Admin Management
                            <div style={{
                                paddingTop: '25px',
                                paddingBottom: '25px',
                                color: 'black',
                                fontSize: '15px',
                                margin: 'auto'
                            }}>
                                <Link to="/add-admin" className="btn btn-primary" style={{ textAlign: 'left' }}>Add Admins</Link>
                            </div>
                        </div>
                        <div style={{ marginRight: '25px', paddingTop: '130px', paddingRight: '33px' }}>
                            <Search
                                placeholder="Search users"
                                allowClear
                                enterButton="Search"
                                size="middle"
                                onSearch={handleSearch}
                                onChange={e => handleSearch(e.target.value)}
                            />
                        </div>
                    </div>

                    <table className="table table-striped" style={{
                        margin: '0 auto',
                        minWidth: '600px',
                        backgroundColor: 'white'
                    }}>
                        <thead>
                        <tr>
                            <th style={{backgroundColor: 'white'}}>Name</th>
                            <th style={{backgroundColor: 'white'}}>Username</th>
                            <th style={{backgroundColor: 'white'}}>Role</th>
                            <th style={{backgroundColor: 'white'}}>Email</th>
                            <th style={{backgroundColor: 'white'}}>Phone Number</th>
                            <th style={{backgroundColor: 'white'}}>Options</th>
                        </tr>
                        </thead>
                        <tbody>
                        {filteredAdmins.map(admin => {
                            const user = users[admin.user_table_user_id] || {};
                            return (
                                <tr key={admin.admin_id}>
                                    <td>{user.name}</td>
                                    <td>{user.username}</td>
                                    <td>{admin.admin_role}</td>
                                    <td>{admin.email}</td>
                                    <td>{user.phone_number}</td>
                                    <td align="center">
                                        <button onClick={() => window.location.href = `/edit-admin/${admin.admin_id}`}
                                                className="btn btn-primary">Update
                                        </button>
                                        &nbsp;
                                        <button onClick={() => deleteAdmin(admin.admin_id, admin.user_table_user_id)}
                                                className="btn btn-danger">Delete
                                        </button>
                                    </td>
                                </tr>
                            );
                        })}
                        </tbody>
                    </table>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListAdminComponent;
