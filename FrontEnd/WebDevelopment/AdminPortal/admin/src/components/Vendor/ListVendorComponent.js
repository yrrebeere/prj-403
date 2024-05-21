import React, { useState, useEffect } from 'react';
import VendorService from '../../services/VendorService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Menu, Layout, Input } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';
const { Sider } = Layout;
const { Search } = Input;

const ListVendorComponent = () => {
    const [vendors, setVendors] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const location = useLocation();

    useEffect(() => {
        refreshVendors();
    }, []);

    const refreshVendors = () => {
        VendorService.getAllVendors()
            .then((response) => {
                setVendors(response.data);
            })
            .catch(error => {
                console.error("Error fetching stock counts:", error);
            });
    };

    const deleteVendor = (vendorId) => {
        VendorService.deleteVendor(vendorId)
            .then(() => {
                refreshVendors();
            })
            .catch(error => {
                console.error("Error deleting stock count:", error);
            });
    };

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const filteredVendors = vendors.filter(vendor => {
        const nameMatch = vendor.vendor_name && vendor.vendor_name.toLowerCase().includes(searchTerm);
        const addressMatch = vendor.vendor_address && vendor.vendor_address.toLowerCase().includes(searchTerm);
        return nameMatch || addressMatch;

    });

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'Admins', url: '/' },
        { icon: <UploadOutlined />, label: 'Grocery Stores', url: '/stores' },
        { icon: <VideoCameraOutlined />, label: 'Vendors', url: '/vendors' },
        { icon: <BarChartOutlined />, label: 'Analytics', url: '/analytics' },
        { icon: <AppstoreOutlined />, label: 'Categories', url: '/categories' },
        { icon: <AppstoreOutlined />, label: 'Products', url: '/products' },
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

                <div style={{padding: '1px'}}>
                    <div style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        marginBottom: '20px'
                    }}> {/* Added justifyContent for spacing */}
                        <div style={{
                            paddingTop: '25px',
                            paddingBottom: '25px',
                            paddingLeft: '25px',
                            color: 'black', // Changed to blue color
                            fontSize: '20px',
                            fontWeight: 'bold'
                        }}>
                            Vendor Management
                        </div>
                        <div style={{marginRight: '25px', paddingTop: '130px', paddingRight: '33px'}}>
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

                    <table className="table" style={{
                        margin: '0 auto',
                        minWidth: '600px',
                        backgroundColor: 'white'
                    }}>
                        <thead>
                        <tr>
                            <th style={{backgroundColor: 'white'}}>Image</th>
                            <th style={{backgroundColor: 'white'}}>Vendor Name</th>
                            <th style={{backgroundColor: 'white'}}>Delivery Locations</th>
                            <th style={{backgroundColor: 'white'}}>Options</th>
                        </tr>
                        </thead>
                        <tbody>
                        {filteredVendors.map(vendor => (
                            <tr key={vendor.vendor_id}>
                                <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${vendor.image}`}
                                         alt="Vendor Icon" style={{width: '50px', height: '50px'}}/></td>
                                <td>{vendor.vendor_name}</td>
                                <td>{vendor.delivery_locations}</td>

                                <td align="center">
                                    <button onClick={() => deleteVendor(vendor.vendor_id)}
                                            className="btn btn-danger">Delete
                                    </button>
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

export default ListVendorComponent;
