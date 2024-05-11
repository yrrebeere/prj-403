import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Layout, Menu } from 'antd';
import {
    UserOutlined,
    VideoCameraOutlined,
    UploadOutlined,
    BarChartOutlined,
    CloudOutlined,
    AppstoreOutlined,
} from '@ant-design/icons';
import ContentManagementService from "../../services/ContentManagementService";

const { Sider } = Layout;

const AddProductComponent = () => {
    const [productName, setProductName] = useState('');
    const [image, setImage] = useState('');
    const location = useLocation();

    const isAdminActive = () => location.pathname.startsWith('/admin');

    const handleSave = () => {
        if (productName.trim() !== '' && image.trim() !== '') {
            console.log("Product Name:", productName);
            console.log("Image File:", image);
            ContentManagementService.addProduct(productName, image); // Pass product name and image to your addProduct function
            setProductName('');
            setImage('');
        } else {
            alert('Please enter both product name and upload an image.');
        }
    };

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setImage(file);
        }
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
                    selectedKeys={isAdminActive() ? [] : [location.pathname]}
                >
                    {sidebarItems.map((item, index) => (
                        <Menu.Item key={index + 1} icon={item.icon}style={{ marginBottom: '20px' }}>
                            <Link to={item.url}>{item.label}</Link>
                        </Menu.Item>
                    ))}
                </Menu>
            </Sider>
            <Layout>
                <div style={{ marginTop: '50px', textAlign: 'center' }}>
                    <h2>Add Product</h2>
                    <div className="container" style={{ border: '2px solid black', padding: '20px', width: '60%', margin: 'auto' }}>
                        <input
                            type="text"
                            value={productName}
                            onChange={(e) => setProductName(e.target.value)}
                            placeholder="Enter Product Name"
                            style={{ marginBottom: '20px', width: '100%', padding: '10px' }}
                        />
                        <br />
                        <input
                            type="file"
                            onChange={handleImageChange}
                            accept="image/*"
                            style={{ marginBottom: '20px' }}
                        />
                        <br />
                        <button className="btn btn-primary" onClick={handleSave}>Save</button>
                        <Link to="/content-management" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default AddProductComponent;
