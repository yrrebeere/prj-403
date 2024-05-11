import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import styles from "../../styles/ComponentStyles.css";
import { Layout, Menu } from 'antd'; // Import Layout and Menu from Ant Design
import {
    UserOutlined,
    VideoCameraOutlined,
    UploadOutlined,
    BarChartOutlined,
    CloudOutlined,
    AppstoreOutlined,
} from '@ant-design/icons';
import StoreService from "../../services/StoreService";

const { Sider } = Layout; // Destructure Sider from Layout

const AddStoreComponent = () => {
    const [storeName, setStoreName] = useState('');
    const [storeAddress, setStoreAddress] = useState('');
    const [image, setImage] = useState('');
    const locationPath = useLocation().pathname;

    const isActive = () => locationPath === '/content-management';

    const handleSave = async () => {
        if (storeName.trim() !== '' && storeAddress.trim() !== '' && image.trim() !== '') {
            try {
                await StoreService.addStore({ store_name: storeName, store_address: storeAddress, image: image });
                setStoreName('');
                setStoreAddress('');
                setImage('');
                console.log('Store added successfully');
            } catch (error) {
                console.error('Error adding store:', error);
            }
        } else {
            alert('Please enter both store name, store address, and upload an image.');
        }
    };

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setImage(file);
        }
    };

    const sidebarItems = [
        { label: 'WASAIL'},
        { icon: <UserOutlined />, label: 'Users', url: '/' },
        { icon: <VideoCameraOutlined />, label: 'Vendors', url: '/vendors' },
        { icon: <UploadOutlined />, label: 'Stores', url: '/stores' }, // Fixed the url for Stores
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
                <Menu theme="dark" mode="inline" defaultSelectedKeys={['4']}>
                    {sidebarItems.map((item, index) => (
                        <Menu.Item key={index+1} icon={item.icon}>
                            <Link to={item.url}>{item.label}</Link>
                        </Menu.Item>
                    ))}
                </Menu>
            </Sider>
            <Layout>
                <div className={styles.body}>
                    <div className="container" style={{ marginTop: '50px', border: '2px solid black', padding: '20px', width: '50%', textAlign: 'center', margin: 'auto' }}>
                        <h2>Add Store</h2>

                        <input
                            type="text"
                            value={storeName}
                            onChange={(e) => setStoreName(e.target.value)}
                            placeholder="Enter Store Name"
                            style={{ marginBottom: '10px' }}
                        />
                        <br />
                        <input
                            type="text"
                            value={storeAddress}
                            onChange={(e) => setStoreAddress(e.target.value)}
                            placeholder="Enter Store Address"
                            style={{ marginBottom: '10px' }}
                        />
                        <br />
                        <input
                            type="text"
                            value={image}
                            onChange={(e) => setImage(e.target.value)}
                            placeholder="Enter Image URL"
                            style={{ marginBottom: '10px' }}
                        />
                        <br/>
                        <button className="btn btn-primary" onClick={handleSave}>Save</button>
                        <Link to="/stores" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default AddStoreComponent;
