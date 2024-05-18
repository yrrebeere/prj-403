import React, { useState, useEffect } from 'react';
import CategoryService from '../../services/CategoryService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Menu, Layout, Input } from 'antd';
import { UserOutlined, VideoCameraOutlined, UploadOutlined, BarChartOutlined, CloudOutlined, AppstoreOutlined } from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input;

const ListCategoryComponent = () => {
    const [categories, setCategories] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const location = useLocation();

    useEffect(() => {
        refreshCategories();
    }, []);

    const refreshCategories = () => {
        CategoryService.getAllCategories()
            .then((response) => {
                setCategories(response.data);
            })
            .catch(error => {
                console.error("Error fetching stock counts:", error);
            });
    };

    const deleteCategory = (categoryId) => {
        CategoryService.deleteCategory(categoryId)
            .then(() => {
                refreshCategories();
            })
            .catch(error => {
                console.error("Error deleting stock count:", error);
            });
    };

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const filteredCategories = categories.filter(category => {
        const nameMatch = category.category_name && category.category_name.toLowerCase().includes(searchTerm);
        return nameMatch;
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
                            Category Management
                            <div style={{
                                paddingTop: '25px',
                                paddingBottom: '25px',
                                color: 'black', // Changed to blue color
                                fontSize: '15px',
                                margin: 'auto'
                            }}>
                                <Link to="/add-category" className="btn btn-primary" style={{textAlign: 'left'}}>Add
                                    Category</Link>
                            </div>
                        </div>
                        <div style={{marginRight: '25px', paddingTop: '130px', paddingRight: '33px'}}>
                            <Search
                                placeholder="Search category"
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
                            <th style={{backgroundColor: 'white'}}>Category Name</th>
                            <th style={{backgroundColor: 'white'}}>Options</th>
                        </tr>
                        </thead>
                        <tbody>
                        {filteredCategories.map(category => (
                            <tr key={category.product_category_id}>
                                <td><img
                                    src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${category.image}`}
                                    alt={category.category_name} style={{width: '50px', height: '50px'}}/>
                                </td>
                                <td>{category.category_name}</td>
                                <td align="center">
                                    <Link to={`/edit-category/${category.product_category_id}`}
                                          className="btn btn-primary"
                                          style={{marginLeft: '5px'}}>Update</Link> &nbsp;
                                    <button onClick={() => deleteCategory(category.product_category_id)}
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

export default ListCategoryComponent;