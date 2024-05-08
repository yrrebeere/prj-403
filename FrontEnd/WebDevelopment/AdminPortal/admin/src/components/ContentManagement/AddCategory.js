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

const AddCategory = () => {
    const [categoryName, setCategoryName] = useState('');
    const [image, setImage] = useState(''); // New state for image
    const location = useLocation();

    // Function to check if the current path is '/content-management'
    const isActive = () => location.pathname === '/content-management';

    const handleSave = () => {
        if (categoryName.trim() !== '' && image.trim() !== '') { // Check if both category name and image are provided
            console.log("Category Name:", categoryName);
            console.log("Image File:", image);
            ContentManagementService.addCategory(categoryName, image); // Pass category name and image to your addCategory function
            setCategoryName('');
            setImage('');
        } else {
            alert('Please enter both category name and upload an image.');
        }
    };

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setImage(file);
        }
    };

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'Users', url: '/' },
        { icon: <VideoCameraOutlined />, label: 'Vendors', url: '/vendors' },
        { icon: <UploadOutlined />, label: 'Stores', url: 'stores' },
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
                    <div className="container" style={{ marginTop: '50px', border: '2px solid black', padding: '20px', width: '50%', textAlign: 'center', margin: 'auto' }}>
                        <h2>Add Category</h2>

                        <input
                            type="text"
                            value={categoryName}
                            onChange={(e) => setCategoryName(e.target.value)}
                            placeholder="Enter category name"
                            style={{ marginBottom: '10px' }}
                        />
                        <br />
                        <input
                            type="text"
                            value={image}
                            onChange={(e) => setImage(e.target.value)}
                            placeholder="Enter Image"
                            style={{ marginBottom: '10px' }}
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

export default AddCategory;
