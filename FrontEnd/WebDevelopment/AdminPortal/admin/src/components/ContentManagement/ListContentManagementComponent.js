import React, { useEffect, useState } from 'react';
import ContentManagementService from '../../services/ContentManagementService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';
import { Layout, Menu, Input, Button } from 'antd'; // Import Input and Button components from antd
import {
    UserOutlined,
    VideoCameraOutlined,
    UploadOutlined,
    BarChartOutlined,
    CloudOutlined,
    AppstoreOutlined,
} from '@ant-design/icons';

const { Sider } = Layout;
const { Search } = Input; // Destructure Search component from antd

const ListContentManagementComponent = () => {
    const [categories, setCategories] = useState([]);
    const [products, setProducts] = useState([]);
    const [showProducts, setShowProducts] = useState(false);
    const [searchTerm, setSearchTerm] = useState(''); // State for search term
    const location = useLocation();

    useEffect(() => {
        const fetchData = async () => {
            try {
                const categoriesResponse = await ContentManagementService.getAllProductCategories();
                setCategories(categoriesResponse.data);

                const productsResponse = await ContentManagementService.getAllProducts();
                setProducts(productsResponse.data);
            } catch (error) {
                console.error("Error fetching data:", error);
            }
        };

        fetchData();
    }, []);

    const isAdminActive = () => {
        return location.pathname.startsWith('/admin');
    };

    const deleteCategory = async (categoryId) => {
        try {
            await ContentManagementService.deleteProductCategory(categoryId);
            const updatedCategories = categories.filter(category => category.product_category_id !== categoryId);
            setCategories(updatedCategories);
        } catch (error) {
            console.error("Error deleting category:", error);
        }
    };

    const deleteProduct = async (productId) => {
        try {
            await ContentManagementService.deleteProduct(productId);
            const updatedProducts = products.filter(product => product.product_id !== productId);
            setProducts(updatedProducts);
        } catch (error) {
            console.error("Error deleting product:", error);
        }
    };

    const handleSearch = (value) => {
        setSearchTerm(value.toLowerCase());
    };

    const filteredCategories = categories.filter(category =>
        category.category_name.toLowerCase().includes(searchTerm)
    );

    const filteredProducts = products.filter(product =>
        product.product_name.toLowerCase().includes(searchTerm)
    );

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'User Management', url: '/' },
        { icon: <UploadOutlined />, label: 'Grocery Management', url: '/stores' },
        { icon: <VideoCameraOutlined />, label: 'Vendor Management', url: '/vendors' },
        { icon: <CloudOutlined />, label: 'ML Configuration', url: '/ml' },
        { icon: <BarChartOutlined />, label: 'Analytics', url: '/analytics' },
        { icon: <AppstoreOutlined />, label: 'Content Management', url: '/content-management' },
    ];

    return (
        <Layout style={{ minHeight: '100vh' }}>
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
                    selectedKeys={isAdminActive() ? [] : [location.pathname]}
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
                    <div style={{display: 'flex', justifyContent: 'space-between', marginBottom: '20px'}}>
                        <div style={{
                            paddingTop: '25px',
                            paddingBottom: '25px',
                            paddingLeft: '25px',
                            color: 'black', // Changed to blue color
                            fontSize: '20px',
                            fontWeight: 'bold'
                        }}>
                            List Category

                        </div>


                        <div style={{marginRight: '25px', paddingTop: '180px', paddingRight: '33px'}}>
                            <Search
                                placeholder={`Search ${showProducts ? 'product' : 'category'}`}
                                allowClear
                                enterButton="Search"
                                size="middle"
                                onSearch={handleSearch}
                                onChange={e => handleSearch(e.target.value)}

                            />
                        </div>
                    </div>
                    {!showProducts ? (
                        <div>
                            <div style={{textAlign: 'center', marginBottom: '20px'}}>
                                <Link to="/add-category" className="btn btn-primary">Add Category</Link>
                            </div>
                            <div className="table-container" style={{display: 'flex', justifyContent: 'center'}}>
                                <table className="table table-striped" style={{backgroundColor:'white'}}>
                                    <thead>
                                    <tr>
                                        <th style={{backgroundColor:'white'}}>Image</th>
                                        <th style={{backgroundColor:'white'}}>Category Name</th>
                                        <th style={{backgroundColor:'white'}}>Options</th>
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
                                                      style={{marginLeft: '5px'}}>Edit</Link>
                                                <button onClick={() => deleteCategory(category.product_category_id)}
                                                        className="btn btn-danger" style={{marginLeft: '5px'}}>Delete
                                                </button>
                                                <Link to={`/`} className="btn btn-primary"
                                                      style={{marginLeft: '5px'}}>View</Link>
                                            </td>
                                        </tr>
                                    ))}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    ) : (
                        <div>
                            <div style={{textAlign: 'center', marginBottom: '20px'}}>
                                <Link to="/add-product" className="btn btn-primary">Add Product</Link>
                            </div>
                            <div className="table-container" style={{ display: 'flex', justifyContent: 'center' }}>
                                <table className="table table-striped"  style={{backgroundColor:'white'}}>
                                    <thead>
                                    <tr>
                                        <th  style={{backgroundColor:'white'}}>Image</th>
                                        <th  style={{backgroundColor:'white'}}>Product Name</th>
                                        <th  style={{backgroundColor:'white'}}>Options</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {filteredProducts.map(product => (
                                        <tr key={product.product_id}>
                                            <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${product.image}`} alt={product.product_name} style={{ width: '50px', height: '50px' }} /></td>
                                            <td>{product.product_name}</td>
                                            <td align="center">
                                                <Link to={`/edit-product/${product.product_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link>
                                                <button onClick={() => deleteProduct(product.product_id)} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</button>
                                                <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link>
                                            </td>
                                        </tr>
                                    ))}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    )}

                    <div style={{textAlign: 'center', marginTop: '20px', paddingBottom: '20px'}}>
                        <Button className="btn btn-primary" onClick={() => setShowProducts(!showProducts)} style={{
                            fontSize: '16px',
                            padding: '12px 24px',
                            paddingBottom:'30px',
                            textAlign: 'center',
                            lineHeight: '1'
                        }}>{showProducts ? "Show Categories" : "Show Products"}</Button>
                    </div>

                </div>
            </Layout>
        </Layout>
    );
};

export default ListContentManagementComponent;
