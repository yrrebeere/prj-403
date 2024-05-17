import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Menu, Layout, Input } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input;

const ListStoreComponent = () => {
    const [stores, setStores] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const location = useLocation();

    useEffect(() => {
        refreshStores();
    }, []);

    const refreshStores = () => {
        StoreService.getAllStores()
            .then((response) => {
                setStores(response.data);
            })
            .catch(error => {
                console.error("Error fetching stock counts:", error);
            });
    };

    const deleteStore = (storeId) => {
        StoreService.deleteStore(storeId)
            .then(() => {
                refreshStores();
            })
            .catch(error => {
                console.error("Error deleting stock count:", error);
            });
    };

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const filteredStores = stores.filter(store => {
        const nameMatch = store.store_name && store.store_name.toLowerCase().includes(searchTerm);
        const addressMatch = store.store_address && store.store_address.toLowerCase().includes(searchTerm);
        return nameMatch || addressMatch;

    });

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'User Management', url: '/' },
        { icon: <UploadOutlined />, label: 'Grocery Management', url: '/stores' },
        { icon: <VideoCameraOutlined />, label: 'Vendor Management', url: '/vendors' },
        { icon: <CloudOutlined />, label: 'ML Configuration', url: '/ml' },
        { icon: <BarChartOutlined />, label: 'Analytics', url: '/analytics' },
        { icon: <AppstoreOutlined />, label: 'Product Management', url: '/products' },
        { icon: <AppstoreOutlined />, label: 'Category Management', url: '/categories' },
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

                <div style={{padding: '1px'}}>
                    <div style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        marginBottom: '20px'
                    }}> {/* Added justifyContent for spacing */}
                        <div style={{
                            paddingTop: '25px',
                            paddingBottom: '25px',
                            paddingLeft: '25px',
                            color: 'black', // Changed to blue color
                            fontSize: '20px',
                            fontWeight: 'bold'
                        }}>
                            Store Management
                        </div>
                        <div style={{marginRight: '25px', paddingTop: '130px', paddingRight: '33px'}}>
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

                    <table className="table table-striped" style={{
                        margin: '0 auto',
                        minWidth: '600px',
                        backgroundColor: 'white'
                    }}>
                        <thead>
                        <tr>
                            <th style={{backgroundColor: 'white'}}>Image</th>
                            <th style={{backgroundColor: 'white'}}>Store Name</th>
                            <th style={{backgroundColor: 'white'}}>Store Address</th>
                            <th style={{backgroundColor: 'white'}}>Options</th>
                        </tr>
                        </thead>
                        <tbody>
                        {filteredStores.map(store => (
                            <tr key={store.product_store_id}>
                                <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${store.image}`}
                                         alt="Store Icon" style={{width: '50px', height: '50px'}}/></td>

                                <td>{store.store_name}</td>
                                <td>{store.store_address}</td>

                                <td align="center">
                                    <button onClick={() => deleteStore(store.product_store_id)}
                                            className="btn btn-danger">Delete
                                    </button>
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListStoreComponent;
