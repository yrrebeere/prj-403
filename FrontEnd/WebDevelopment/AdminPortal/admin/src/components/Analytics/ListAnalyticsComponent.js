import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Menu, Layout, Input } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';
import VendorService from "../../services/VendorService";

const { Sider } = Layout;
const { Search } = Input;

const ListAnalyticsComponent = () => {
    const [storeData, setStoreData] = useState({});
    const [vendorData, setVendorData] = useState({});
    const [searchTerm, setSearchTerm] = useState('');
    const location = useLocation();

    useEffect(() => {
        refreshStores();
    }, []);

    const refreshStores = () => {
        StoreService.getStoreCount()
            .then((response) => {
                console.log('Response from getStoreCount:', response.data);
                setStoreData(response.data);
            })
            .catch(error => {
                console.error("Error fetching store count:", error);
            });

        VendorService.getVendorCount()
            .then((response) => {
                console.log('Response from getVendorCount:', response.data);
                setVendorData(response.data);
            })
            .catch(error => {
                console.error("Error fetching store count:", error);
            });


    };

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'User Management', url: '/' },
        { icon: <UploadOutlined />, label: 'Grocery Management', url: '/stores' },
        { icon: <VideoCameraOutlined />, label: 'Vendor Management', url: '/vendors' },
        { icon: <CloudOutlined />, label: 'ML Configuration', url: '/ml' },
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
                            Store Management
                        </div>
                        <div style={{ marginRight: '25px', paddingTop: '130px', paddingRight: '33px' }}>
                            <Search
                                placeholder="Search store"
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
                            <th style={{ backgroundColor: 'white' }}>Grocery Store Count</th>
                            <th style={{ backgroundColor: 'white' }}>Vendor Count</th>
                        </tr>
                        </thead>
                        <tbody>
                        {Object.entries(storeData).map(([key, value]) => (
                            <tr key={key}>
                                <td>{value}</td>
                            </tr>
                        ))}
                        {Object.entries(vendorData).map(([key, value]) => (
                            <tr key={key}>
                                <td>{value}</td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListAnalyticsComponent;
