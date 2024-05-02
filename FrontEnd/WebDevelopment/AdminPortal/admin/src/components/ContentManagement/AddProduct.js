import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import styles from "../../styles/ComponentStyles.css";

const AddProduct = ({ addProduct }) => {
    const [productName, setProductName] = useState('');
    const [image, setImage] = useState(null);
    const location = useLocation();

    // Function to check if the current path is '/listProducts'
    const isActive = () => location.pathname === '/listProducts';

    const handleSave = () => {
        if (productName.trim() !== '' && image !== null) {
            // Perform upload image and product creation logic here
            console.log("Product Name:", productName);
            console.log("Image File:", image);
            // Reset form fields
            setProductName('');
            setImage(null);
        } else {
            alert('Please enter both product name and upload an image.');
        }
    };

    const handleImageChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setImage(file);
        }
    };

    return (
        <div className={styles.body}>
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="container-fluid">
                    <div className="navbar-nav" style={{ display: 'flex', justifyContent: 'space-around' }}>
                        <Link to="/users" className="nav-item nav-link">Users</Link>
                        <Link to="/vendors" className="nav-item nav-link">Vendors</Link>
                        <Link to="/groceries" className="nav-item nav-link">Groceries</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/contentManagement" className={`nav-item nav-link ${isActive() ? 'active' : ''}`}>Content
                            Management</Link>
                    </div>
                </div>
            </nav>

            <div className="container" style={{ marginTop: '50px', border: '2px solid black', padding: '20px', width: '60%', textAlign: 'center', margin: 'auto' }}>
                <h2>Add Product</h2>

                <input
                    type="text"
                    value={productName}
                    onChange={(e) => setProductName(e.target.value)}
                    placeholder="Enter product name"
                    style={{ marginBottom: '20px', width: '100%', padding: '10px' }}
                />
                <br />
                <label htmlFor="imageUpload" style={{ border: '1px solid #ccc', padding: '6px 12px', cursor: 'pointer', backgroundColor: '#f0f0f0', borderRadius: '4px', marginBottom: '20px', display: 'block', width: '100%' }}>
                    Upload Image
                    <input
                        id="imageUpload"
                        type="file"
                        accept="image/*"
                        onChange={handleImageChange}
                        style={{ display: 'none' }}
                    />
                </label>
                <br />
                <button className="btn btn-primary" onClick={handleSave} style={{ marginBottom: '20px' }}>Save</button>
                <Link to="/contentManagement" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
            </div>
        </div>
    );
};

export default AddProduct;
