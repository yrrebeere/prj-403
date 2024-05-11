import React from 'react';
import AdminService from '../../services/AdminService'; // Assuming this fetches admin data
import { Layout, Menu, Input, Button } from 'antd'; // Import Input and Button from Ant Design
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
const { Search } = Input; // Destructure Search component from Input

const ListAdminComponent = () => {
    const [admins, setAdmins] = React.useState([]); // State for admin data
    const [searchTerm, setSearchTerm] = React.useState(''); // State for search term
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

    const handleSearch = (value) => {
        // Update search term
        setSearchTerm(value.toLowerCase());

        if (value.trim() === '') { // Check if the search term is empty or whitespace
            // Reset highlighting for all admins
            const resetAdmins = admins.map(admin => ({ ...admin, highlighted: false }));
            setAdmins(resetAdmins); // Update admins state with reset highlighting
            return; // Exit early
        }

        // Highlight matching admins based on new search term
        const updatedAdmins = admins.map(admin => {
            const emailMatch = admin.email.toLowerCase().includes(value.toLowerCase());
            const roleMatch = admin.admin_role.toLowerCase().includes(value.toLowerCase());
            return {
                ...admin,
                highlighted: emailMatch || roleMatch,
            };
        });

        // Update admins state with the newly highlighted rows
        setAdmins(updatedAdmins);
    };

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'User Management', url: '/' },
        { icon: <UploadOutlined />, label: 'Grocery Management', url: '/stores' },
        { icon: <VideoCameraOutlined />, label: 'Vendor Management', url: '/vendors' },
        { icon: <CloudOutlined />, label: 'ML Configuration', url: '/ml' },
        { icon: <BarChartOutlined />, label: 'Analytics', url: '/analytics' },
        { icon: <AppstoreOutlined />, label: 'Content Management', url: '/content-management' },
    ];

    return (
        <Layout>
            <Sider
                width={220}
                style={{
                    background: '#fff', // White background color
                    overflow: 'auto',
                    height: '100vh',
                }}
            >
                <div style={{display: 'flex', alignItems: 'center'}}>
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
                    theme="light" // Light theme for the menu
                    mode="inline"
                    defaultSelectedKeys={['2']}
                    selectedKeys={isAdminActive() ? [] : [location.pathname]}
                >
                    {sidebarItems.map((item, index) => (
                        <Menu.Item key={index + 1} icon={item.icon} style={{ marginBottom: '20px' }}> {/* Added marginBottom */}
                            <Link to={item.url}>{item.label}</Link>
                        </Menu.Item>
                    ))}
                </Menu>
            </Sider>
            <Layout>
                <div style={{padding: '1px'}}>
                    <div style={{display: 'flex', alignItems: 'center', justifyContent: 'space-between'}}> {/* Added justifyContent for spacing */}
                        <div style={{
                            paddingTop: '28px',
                            paddingBottom: '25px',
                            paddingLeft: '25px',
                            color: 'black', // Changed to blue color
                            fontSize: '20px',
                            fontWeight: 'bold'
                        }}>
                            Users
                        </div>
                        <div style={{ marginRight: '25px', paddingTop: '70px', paddingRight: '33px' }}> {/* Added style for padding */}
                            <Search
                                placeholder="Search user"
                                allowClear
                                enterButton="Search"
                                size="middle"
                                onSearch={handleSearch}
                                onChange={e => handleSearch(e.target.value)}
                            />
                        </div>
                    </div>
                    <div style={{overflowX: 'auto', marginTop: '100px',}}> {/* Added marginTop for spacing */}
                        <table className="table table-striped" style={{
                            margin: '0 auto',
                            minWidth: '600px',
                            backgroundColor: 'white'
                        }}> {/* Removed paddingTop */}
                            <thead style={{
                                color: 'deepskyblue',
                                backgroundColor: 'white'
                            }}> {/* Changed heading color to blue and background color to white */}
                            <tr>
                                <th style={{backgroundColor: 'white'}}>Email</th>
                                {/* Added background color to th */}
                                <th style={{backgroundColor: 'white'}}>Role</th>
                                {/* Added background color to th */}
                                <th style={{backgroundColor: 'white'}}>Options</th>
                                {/* Added background color to th */}
                            </tr>
                            </thead>

                            <tbody>
                            {admins.map(admin => (
                                <tr key={admin.admin_id}
                                    style={{backgroundColor: admin.highlighted ? 'yellow' : 'transparent'}}> {/* Highlight based on 'highlighted' flag */}
                                    <td>{admin.email}</td>
                                    <td>{admin.admin_role}</td>
                                    <td align="center">
                                        <Link to={`/`} className="btn btn-primary"
                                              style={{marginLeft: '5px'}}>Edit</Link> &nbsp;
                                        <Link to={`/`} className="btn btn-danger"
                                              style={{marginLeft: '5px'}}>Delete</Link> &nbsp;
                                        <Link to={`/`} className="btn btn-primary"
                                              style={{marginLeft: '5px'}}>View</Link> &nbsp;
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListAdminComponent;
