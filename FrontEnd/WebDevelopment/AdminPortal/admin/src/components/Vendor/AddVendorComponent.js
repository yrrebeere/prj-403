import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import styles from "../../styles/ComponentStyles.css";
import VendorService from "../../services/VendorService";
import { Layout, Menu } from 'antd'; // Import Layout and Menu from Ant Design
import {
    UserOutlined,
    VideoCameraOutlined,
    UploadOutlined,
    BarChartOutlined,
    CloudOutlined,
    AppstoreOutlined,
} from '@ant-design/icons';

const { Sider } = Layout; // Destructure Sider from Layout

const AddVendorComponent = () => {
    const [vendorName, setVendorName] = useState('');
    const [deliveryLocation, setDeliveryLocation] = useState('');
    const [image, setImage] = useState('');
    const location = useLocation();

    const isActive = () => location.pathname === '/content-management';

    const handleSave = () => {
        if (vendorName.trim() !== '' && deliveryLocation.trim() !== '' && image.trim() !== '') {
            VendorService.addVendor({ name: vendorName, deliveryLocation: deliveryLocation, image: image });
            setVendorName('');
            setDeliveryLocation('');
            setImage(null);
        } else {
            alert('Please enter both vendor name, delivery location, and upload an image.');
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
                <Menu theme="dark" mode="inline" defaultSelectedKeys={['3']}>
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
                <h2>Add Vendor</h2>

                <input
                    type="text"
                    value={vendorName}
                    onChange={(e) => setVendorName(e.target.value)}
                    placeholder="Enter Vendor Name"
                    style={{ marginBottom: '10px' }}
                />
                <br />
                <input
                    type="text"
                    value={deliveryLocation}
                    onChange={(e) => setDeliveryLocation(e.target.value)}
                    placeholder="Enter Delivery Location"
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
                <Link to="/vendors" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
            </div>
        </div>
            </Layout>
        </Layout>
    );
};

export default AddVendorComponent;
