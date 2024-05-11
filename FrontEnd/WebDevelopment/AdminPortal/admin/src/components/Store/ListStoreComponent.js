import React, { useEffect, useState } from 'react';
import StoreService from '../../services/StoreService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Layout, Menu } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;

const ListStoreComponent = () => {
    const [stores, setStores] = useState([]);
    const [showStores, setShowStores] = useState(true); // Initially show stores
    const location = useLocation();

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await StoreService.getAllStores();
                setStores(response.data);
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        };

        fetchData();
    }, []);

    const deleteStore = async (storeId) => {
        try {
            await StoreService.deleteStore(storeId);
            const updatedStores = stores.filter(store => store.store_id !== storeId);
            setStores(updatedStores);
        } catch (error) {
            console.error("Error deleting store:", error);
        }
    };

    const isActive = (path) => location.pathname === path;

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
                <div className={styles.body}>
                    <h2>Stores</h2>
                    <div>
                        <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                            <Link to="/add-store" className="btn btn-primary">Add Store</Link>
                        </div>
                        <div className="table-container" style={{ textAlign: 'center' }}>
                            <table className="table table-striped">
                                <thead>
                                <tr>
                                    <th>Icon</th>
                                    <th>Store Name</th>
                                    <th>Location</th>
                                    <th>Options</th>
                                </tr>
                                </thead>
                                <tbody>
                                {stores.map(store => (
                                    <tr key={store.store_id}>
                                        <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${store.image}`} alt="Store Icon" style={{ width: '50px', height: '50px' }} /></td>
                                        <td>{store.store_name}</td>
                                        <td>{store.store_address}</td>
                                        <td align="center">
                                            <Link to={`/edit-store/${store.store_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link>
                                            <button onClick={() => deleteStore(store.store_id)} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</button>
                                            <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link>
                                        </td>
                                    </tr>
                                ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListStoreComponent;
