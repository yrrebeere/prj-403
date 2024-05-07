import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import styles from "../../styles/ComponentStyles.css";

const AddCategory = ({ addCategory }) => {
    const [categoryName, setCategoryName] = useState('');
    const [image, setImage] = useState(null); // New state for image
    const location = useLocation();

    // Function to check if the current path is '/contentManagement'
    const isActive = () => location.pathname === '/content-management';

    const handleSave = () => {
        if (categoryName.trim() !== '' && image !== null) { // Check if both category name and image are provided
            console.log("Category Name:", categoryName);
            console.log("Image File:", image);
            addCategory(categoryName, image); // Pass category name and image to your addCategory function
            setCategoryName('');
            setImage(null);
        } else {
            alert('Please enter both category name and upload an image.');
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
                    <div className="navbar-nav" style={{display: 'flex', justifyContent: 'space-around'}}>
                        <Link to="/users" className="nav-item nav-link">Users</Link>
                        <Link to="/vendors" className="nav-item nav-link">Vendors</Link>
                        <Link to="/groceries" className="nav-item nav-link">Groceries</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/content-management" className={`nav-item nav-link ${isActive() ? 'active' : ''}`}>Content
                            Management</Link>
                    </div>
                </div>
            </nav>

            <div className="container" style={{ marginTop: '50px', border: '2px solid black', padding: '20px', width: '50%', textAlign: 'center', margin: 'auto' }}>
                <h2>Create Category</h2>

                <input
                    type="text"
                    value={categoryName}
                    onChange={(e) => setCategoryName(e.target.value)}
                    placeholder="Enter category name"
                    style={{ marginBottom: '10px' }}
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
                <button className="btn btn-primary" onClick={handleSave}>Save</button>
                <Link to="/content-management" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
            </div>
        </div>
    );
};

export default AddCategory;
