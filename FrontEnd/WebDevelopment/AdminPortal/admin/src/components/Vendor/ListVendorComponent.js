import React, { useEffect, useState } from 'react';
import VendorService from '../../services/VendorService'; // Assuming this fetches vendor data
import styles from '../../styles/ComponentStyles.css'; // Assuming this defines button styles
import { Link, useLocation } from 'react-router-dom';
import { Layout, Menu } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;

const ListVendorComponent = () => {
    const [vendors, setVendors] = useState([]); // State for vendor data
    const location = useLocation(); // Get current location

    const isActive = () => location.pathname === '/vendors'; // Check if current path is '/vendors'

    useEffect(() => {
        const refreshVendors = async () => {
            console.log("Get All Vendors");
            try {
                const response = await VendorService.getAllVendors();
                setVendors(response.data);
            } catch (error) {
                console.error("Error fetching vendors:", error);
            }
        };

        refreshVendors();
    }, []); // Empty dependency array to run effect only once

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
                    theme="light" // Light theme for the menu
                    mode="inline"
                    defaultSelectedKeys={['2']}
                    selectedKeys={isActive() ? [] : [location.pathname]}
                >
                    {sidebarItems.map((item, index) => (
                        <Menu.Item key={index + 1} icon={item.icon} style={{ marginBottom: '20px' }}>
                            <Link to={item.url}>{item.label}</Link>
                        </Menu.Item>
                    ))}
                </Menu>
            </Sider>
            <Layout>
                <div className={styles.body}>
                    <h2>Vendors</h2>
                    <div>
                        <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                            <Link to="/add-vendor" className="btn btn-primary">Add Vendor</Link>
                        </div>
                        <div className="table-container" style={{ textAlign: 'center' }}>
                            <table className="table table-striped">
                                <thead>
                                <tr>
                                    <th>Icon</th>
                                    <th>Vendor Name</th>
                                    <th>Location</th>
                                    <th>Options</th>
                                </tr>
                                </thead>
                                <tbody>
                                {vendors.map(vendor => (
                                    <tr key={vendor.vendor_id}>
                                        <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${vendor.image}`} alt="Vendor Icon" style={{ width: '50px', height: '50px' }} /></td>
                                        <td>{vendor.vendor_name}</td>
                                        <td>{vendor.delivery_locations}</td>
                                        <td align="center">
                                            <Link to={`/edit-vendor/${vendor.vendor_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link>
                                            <Link to={`/delete-vendor/${vendor.vendor_id}`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link>
                                            <Link to={`/view-vendor/${vendor.vendor_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link>
                                        </td>
                                    </tr>
                                ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListVendorComponent;
