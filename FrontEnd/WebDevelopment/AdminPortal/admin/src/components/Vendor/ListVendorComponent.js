import React, { useEffect, useState } from 'react';
import VendorService from '../../services/VendorService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Layout, Menu, Input } from 'antd'; // Import Input component from antd
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input; // Destructure Search component from antd

const ListVendorComponent = () => {
    const [vendors, setVendors] = useState([]);
    const [searchTerm, setSearchTerm] = useState(''); // State for search term
    const location = useLocation();

    const isActive = () => location.pathname === '/vendors';

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
    }, []);

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const filteredVendors = vendors.filter(vendor =>
        vendor.vendor_name.toLowerCase().includes(searchTerm) ||
        vendor.delivery_locations.toLowerCase().includes(searchTerm)
    );

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'User Management', url: '/' },
        { icon: <UploadOutlined />, label: 'Grocery Management', url: '/stores' },
        { icon: <VideoCameraOutlined />, label: 'Vendor Management', url: '/vendors' },
        { icon: <CloudOutlined />, label: 'ML Configuration', url: '/ml' },
        { icon: <BarChartOutlined />, label: 'Analytics', url: '/analytics' },
        { icon: <AppstoreOutlined />, label: 'Content Management', url: '/content-management' },
    ];

    return (
        <Layout style={{ minHeight: '100vh' }}>
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
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '20px' }}>
                        <div style={{  paddingTop: '25px',
                            paddingBottom: '25px',
                            paddingLeft: '25px',
                            color: 'black', // Changed to blue color
                            fontSize: '20px',
                            fontWeight: 'bold'}}>
                            Vendor Management
                        </div>
                        <div style={{ marginRight: '25px', paddingTop: '180px', paddingRight: '33px' }}>
                            <Search
                                placeholder="Search vendor"
                                allowClear
                                enterButton="Search"
                                size="middle"
                                onSearch={handleSearch}
                                onChange={e => handleSearch(e.target.value)}
                            />
                        </div>
                    </div>
                    <div className="table-container" style={{ display: 'flex', justifyContent: 'center' }}>
                        <table className="table table-striped"  style={{backgroundColor:'white'}}>
                            <thead>
                            <tr>
                                <th  style={{backgroundColor:'white'}}>Icon</th>
                                <th  style={{backgroundColor:'white'}}>Vendor Name</th>
                                <th  style={{backgroundColor:'white'}}>Location</th>
                                <th  style={{backgroundColor:'white'}}>Options</th>
                            </tr>
                            </thead>
                            <tbody>
                            {filteredVendors.map(vendor => (
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
            </Layout>
        </Layout>
    );
};

export default ListVendorComponent;
