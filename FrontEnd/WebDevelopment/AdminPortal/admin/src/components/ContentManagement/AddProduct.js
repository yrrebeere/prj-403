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

const { Sider } = Layout;

const AddProduct = ({ addProduct }) => {
    const [productName, setProductName] = useState('');
    const [image, setImage] = useState(null);
    const location = useLocation();

    const isActive = () => location.pathname === '/listProducts';

    const handleSave = () => {
        if (productName.trim() !== '' && image !== null) {
            console.log("Product Name:", productName);
            console.log("Image File:", image);
            setProductName('');
            setImage(null);
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
        { icon: <UploadOutlined />, label: 'Groceries', url: '/groceries' },
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
                        <label htmlFor="imageUpload" style={{ border: '1px solid #ccc', padding: '6px 12px', cursor: 'pointer', backgroundColor: '#f0f0f0', borderRadius: '4px', marginBottom: '20px', display: 'block', width: '100%' }}>
                            Upload Image
                            <input
                                id="imageUpload"
                                type="file"
                                accept="image/*"
                                onChange={handleImageChange}
                                style={{ display: 'none' }}
                            />
                        </label>
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
