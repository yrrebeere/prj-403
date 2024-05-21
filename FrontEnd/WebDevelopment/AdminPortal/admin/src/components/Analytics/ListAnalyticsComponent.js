import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import VendorService from '../../services/VendorService';
import ProductService from '../../services/ProductService';
import CategoryService from '../../services/CategoryService';
import { Link, useLocation } from 'react-router-dom';
import { Menu, Layout, Input } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input;

const ListAnalyticsComponent = () => {
    const [storeCount, setStoreCount] = useState(0);
    const [vendorCount, setVendorCount] = useState(0);
    const [productCount, setProductCount] = useState(0);
    const [categoryCount, setCategoryCount] = useState(0);
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

        CategoryService.getCategoryCount()
            .then((response) => {
                console.log('Response from getCategoryCount:', response.data);
                setCategoryCount(response.data.totalProductCategories || 0);
            })
            .catch(error => {
                console.error("Error fetching category count:", error);
            });
    };

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

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
                            fontSize: '24px',
                            fontWeight: 'bold'
                        }}>
                            Analytics
                        </div>
                    </div>

                    <table style={{
                        margin: '0 auto',
                        minWidth: '600px',
                        backgroundColor: 'white',
                        borderCollapse: 'collapse'
                    }}>
                        <thead>
                        <tr>
                            <th style={{ backgroundColor: 'white', fontSize: '18px', padding: '14px', fontWeight: "normal", color: "gray" }}>Grocery Store Count</th>
                            <th style={{ backgroundColor: 'white', fontSize: '18px', padding: '14px', fontWeight: "normal", color: "gray" }}>Vendor Count</th>
                            <th style={{ backgroundColor: 'white', fontSize: '18px', padding: '14px', fontWeight: "normal", color: "gray" }}>Product Count</th>
                            <th style={{ backgroundColor: 'white', fontSize: '18px', padding: '14px', fontWeight: "normal", color: "gray" }}>Category Count</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style={{ fontSize: '70px', textAlign: 'center', padding: '10px', border: 'none', fontFamily: "serif" }}>{storeCount}</td>
                            <td style={{ fontSize: '70px', textAlign: 'center', padding: '10px', border: 'none', fontFamily: "serif" }}>{vendorCount}</td>
                            <td style={{ fontSize: '70px', textAlign: 'center', padding: '10px', border: 'none', fontFamily: "serif" }}>{productCount}</td>
                            <td style={{ fontSize: '70px', textAlign: 'center', padding: '10px', border: 'none', fontFamily: "serif" }}>{categoryCount}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListAnalyticsComponent;
