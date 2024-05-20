import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import VendorService from '../../services/VendorService';
import ProductService from '../../services/ProductService';
import { Link, useLocation } from 'react-router-dom';
import { Menu, Layout, Input } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input;

const ListAnalyticsComponent = () => {
    const [storeCount, setStoreCount] = useState(0);
    const [vendorCount, setVendorCount] = useState(0);
    const [productCount, setProductCount] = useState(0);
    const [searchTerm, setSearchTerm] = useState('');
    const location = useLocation();

    useEffect(() => {
        refreshData();
    }, []);

    const refreshData = () => {
        StoreService.getStoreCount()
            .then((response) => {
                console.log('Response from getStoreCount:', response.data);
                setStoreCount(response.data.totalGroceryStores || 0);
            })
            .catch(error => {
                console.error("Error fetching store count:", error);
            });

        VendorService.getVendorCount()
            .then((response) => {
                console.log('Response from getVendorCount:', response.data);
                setVendorCount(response.data.totalVendors || 0);
            })
            .catch(error => {
                console.error("Error fetching vendor count:", error);
            });

        ProductService.getProductCount()
            .then((response) => {
                console.log('Response from getProductCount:', response.data);
                setProductCount(response.data.totalProducts || 0);
            })
            .catch(error => {
                console.error("Error fetching product count:", error);
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
                            <th style={{ backgroundColor: 'white' }}>Product Count</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>{storeCount}</td>
                            <td>{vendorCount}</td>
                            <td>{productCount}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListAnalyticsComponent;
