import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import styles from "../../styles/ComponentStyles.css";

const AddCategory = ({ addCategory }) => {
    const [categoryName, setCategoryName] = useState('');
    const location = useLocation();

    // Function to check if the current path is '/contentManagement'
    const isActive = () => location.pathname === '/contentManagement';

    const handleSave = () => {
        if (categoryName.trim() !== '') {
            addCategory(categoryName);
            setCategoryName('');
        } else {
            alert('Please enter a category name.');
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
                        <Link to="/contentManagement" className={`nav-item nav-link ${isActive() ? 'active' : ''}`}>Content
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
                <button className="btn btn-primary" onClick={handleSave}>Save</button>
                <Link to="/contentManagement" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
            </div>
        </div>
    );
};

export default AddCategory;
