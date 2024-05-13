import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Input, Layout, Menu, Button } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input;

const ListStoreComponent = () => {
    const [stores, setStores] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
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

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const deleteStore = async (storeId) => {
        try {
            await StoreService.deleteStore(storeId);
            setStores(stores.filter(store => store.store_id !== storeId));
        } catch (error) {
            console.error("Error deleting store:", error);
        }
    };

    const filteredStores = stores.filter(store =>
        store.store_name.toLowerCase().includes(searchTerm) ||
        store.store_address.toLowerCase().includes(searchTerm)
    );

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
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '20px' }}>
                        <div style={{
                            paddingTop: '25px',
                            paddingBottom: '25px',
                            paddingLeft: '25px',
                            color: 'black', // Changed to blue color
                            fontSize: '20px',
                            fontWeight: 'bold'
                        }}>
                            Grocery Management
                        </div>
                        <div style={{ marginRight: '25px', paddingTop: '70px', paddingRight: '33px' }}>
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
                    <div className="table-container" style={{ display: 'flex', justifyContent: 'center' }}>
                        <table className="table table-striped" style={{ width: '90%', borderCollapse: 'collapse', backgroundColor: 'white' }}>
                            <thead>
                            <tr>
                                <th style={{ backgroundColor: 'white' }}>Icon</th>
                                <th style={{ backgroundColor: 'white' }}>Store Name</th>
                                <th style={{ backgroundColor: 'white' }}>Location</th>
                                <th style={{ backgroundColor: 'white' }}>Options</th>
                            </tr>
                            </thead>
                            <tbody>
                            {filteredStores.map(store => (
                                <tr key={store.store_id}>
                                    <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${store.image}`} alt="Store Icon" style={{ width: '50px', height: '50px' }} /></td>
                                    <td>{store.store_name}</td>
                                    <td>{store.store_address}</td>
                                    <td align="center">
                                        <Link to={`/edit-store/${store.store_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link>
                                        <Button type="primary" danger onClick={() => deleteStore(store.store_id)} style={{ marginLeft: '5px' }}>Delete</Button>
                                        <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link>
                                    </td>
                                </tr>
                            ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListStoreComponent;
