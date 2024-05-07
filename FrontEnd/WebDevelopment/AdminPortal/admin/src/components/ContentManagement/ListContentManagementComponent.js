import React, { useEffect, useState } from 'react';
import ContentManagementService from '../../services/ContentManagementService';
import styles from '../../styles/ComponentStyles.css';
import { Link, useLocation } from 'react-router-dom';

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

    return (
        <div className={styles.body}>
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="container-fluid">
                    <div className="navbar-nav" style={{ display: 'flex', justifyContent: 'space-around' }}>
                        <Link to="/" className="nav-item nav-link">Users</Link>
                        <Link to="/vendors" className="nav-item nav-link">Vendors</Link>
                        <Link to="/groceries" className="nav-item nav-link">Groceries</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/content-management" className={`nav-item nav-link ${isActive('/content-management') ? 'active' : ''}`}>Content Management</Link>
                    </div>
                </div>
            </nav>

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
                                        <Link to={`/`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link> &nbsp;
                                        <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link> &nbsp;
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
                                        <Link to={`/`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link> &nbsp;
                                        <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link> &nbsp;
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
    );
};

export default ListContentManagementComponent;
