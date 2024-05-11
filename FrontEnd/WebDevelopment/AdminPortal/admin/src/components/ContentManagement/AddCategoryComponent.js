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

const AddCategoryComponent = () => {
    const [categoryName, setCategoryName] = useState('');
    const [image, setImage] = useState(null); // Updated to null for image state
    const location = useLocation();

    const isActive = () => location.pathname === '/content-management'; // Function to check if the current path is '/content-management'

    const handleSave = () => {
        if (categoryName.trim() !== '' && image !== null) { // Check if category name and image are provided
            console.log("Category Name:", categoryName);
            console.log("Image File:", image);
            // ContentManagementService.addCategory(categoryName, image); // Call your addCategory function here
            setCategoryName('');
            setImage(null); // Reset image state after saving
        } else {
            alert('Please enter both category name and upload an image.');
        }
    };

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setImage(URL.createObjectURL(file)); // Update image state with object URL
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
                <div className="container" style={{ marginTop: '50px', border: '2px solid black', padding: '20px', width: '50%', textAlign: 'center', margin: 'auto' }}>
                    <h2>Add Category</h2>

                    <input
                        type="text"
                        value={categoryName}
                        onChange={(e) => setCategoryName(e.target.value)}
                        placeholder="Enter Category Name"
                        style={{ marginBottom: '10px' }}
                    />
                    <br />
                    <input
                        type="file" // Changed input type to file for image upload
                        onChange={handleImageChange}
                        style={{ marginBottom: '10px' }}
                    />
                    <br />
                    {image && <img src={image} alt="Category Image" style={{ maxWidth: '100%', marginBottom: '10px' }} />} {/* Display image preview if image is selected */}
                    <br />
                    <button className="btn btn-primary" onClick={handleSave}>Save</button>
                    <Link to="/content-management" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
                </div>
            </Layout>
        </Layout>
    );
};

export default AddCategoryComponent;
