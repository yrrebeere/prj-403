import React, { useEffect, useState } from 'react';
import ContentManagementService from '../../services/ContentManagementService';
import styles from '../../styles/ComponentStyles.css';
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

const { Sider } = Layout;

const ListContentManagementComponent = () => {
    const [categories, setCategories] = useState([]);
    const [products, setProducts] = useState([]);
    const [showProducts, setShowProducts] = useState(false);
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

    const isActive = (path) => location.pathname === path;

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

    const sidebarItems = [
        { icon: <UserOutlined />, label: 'Users', url: '/' },
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
                    <h2>{showProducts ? "List Products" : "List Categories"}</h2>
                    {!showProducts ? (
                        <div>
                            <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                                <Link to="/add-category" className="btn btn-primary">Add Category</Link>
                            </div>
                            <div className="table-container" style={{ textAlign: 'center' }}>
                                <table className="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Category Name</th>
                                        <th>Options</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {categories.map(category => (
                                        <tr key={category.product_category_id}>
                                            <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${category.image}`} alt={category.category_name} style={{ width: '50px', height: '50px' }} /></td>
                                            <td>{category.category_name}</td>
                                            <td align="center">
                                                <Link to={`/edit-category/${category.product_category_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link>
                                                <button onClick={() => deleteCategory(category.product_category_id)} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</button>
                                                <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link>
                                            </td>
                                        </tr>
                                    ))}
                                    </tbody>

                                </table>
                            </div>
                        </div>
                    ) : (
                        <div>
                            <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                                <Link to="/add-product" className="btn btn-primary">Add Product</Link>
                            </div>
                            <div className="table-container" style={{ textAlign: 'center' }}>
                                <table className="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Product Name</th>
                                        <th>Options</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {products.map(product => (
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

                    <div style={{ textAlign: 'center', marginTop: '20px' }}>
                        <button className="btn btn-primary" onClick={() => setShowProducts(!showProducts)}>{showProducts ? "Show Categories" : "Show Products"}</button>
                    </div>
                </div>
            </Layout>
        </Layout>
    );
};

export default ListContentManagementComponent;
