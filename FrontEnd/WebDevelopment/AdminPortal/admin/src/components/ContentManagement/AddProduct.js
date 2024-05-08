import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import styles from "../../styles/ComponentStyles.css";
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

const AddProduct = () => {
    const [productName, setProductName] = useState('');
    const [image, setImage] = useState('');
    const location = useLocation();

    const isActive = () => location.pathname === '/listProducts';

    const handleSave = () => {
        if (productName.trim() !== '' && image.trim() !== '') {
            console.log("Product Name:", productName);
            console.log("Image File:", image);
            ContentManagementService.addProduct(productName, image); // Pass category name and image to your addCategory function
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
        { icon: <UserOutlined />, label: 'Users', url: '/users' },
        { icon: <VideoCameraOutlined />, label: 'Vendors', url: '/vendors' },
        { icon: <UploadOutlined />, label: 'Stores', url: '/stores' },
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
                <Menu theme="dark" mode="inline" defaultSelectedKeys={['6']}>
                    {sidebarItems.map((item, index) => (
                        <Menu.Item key={index + 1} icon={item.icon}>
                            <Link to={item.url}>{item.label}</Link>
                        </Menu.Item>
                    ))}
                </Menu>
            </Sider>
            <Layout>
                <div className={styles.body}>
                    <div className="container" style={{ marginTop: '50px', border: '2px solid black', padding: '20px', width: '60%', textAlign: 'center', margin: 'auto' }}>
                        <h2>Add Product</h2>

                        <input
                            type="text"
                            value={productName}
                            onChange={(e) => setProductName(e.target.value)}
                            placeholder="Enter product name"
                            style={{ marginBottom: '20px', width: '100%', padding: '10px' }}
                        />
                        <br />
                        <input
                            type="text"
                            value={image}
                            onChange={(e) => setImage(e.target.value)}
                            placeholder="Enter Image"
                            style={{ marginBottom: '20px', width: '100%', padding: '10px' }}
                        />
                        <br />
                        <button className="btn btn-primary" onClick={handleSave} style={{ marginBottom: '20px' }}>Save</button>
                        <Link to="/content-management" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default AddProduct;
