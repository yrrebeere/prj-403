import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import styles from "../../styles/ComponentStyles.css";
import VendorService from "../../services/VendorService";

const AddVendorComponent = () => {
    const [vendorName, setVendorName] = useState('');
    const [deliveryLocation, setDeliveryLocation] = useState('');
    const [image, setImage] = useState('');
    const location = useLocation();

    const isActive = () => location.pathname === '/content-management';

    const handleSave = () => {
        if (vendorName.trim() !== '' && deliveryLocation.trim() !== '' && image.trim() !== '') {
            VendorService.addVendor({ name: vendorName, deliveryLocation: deliveryLocation, image: image });
            setVendorName('');
            setDeliveryLocation('');
            setImage(null);
        } else {
            alert('Please enter both vendor name, delivery location, and upload an image.');
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
                        <Link to="/stores" className="nav-item nav-link">Stores</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/content-management" className={`nav-item nav-link ${isActive() ? 'active' : ''}`}>Content Management</Link>
                    </div>
                </div>
            </nav>

            <div className="container" style={{ marginTop: '50px', border: '2px solid black', padding: '20px', width: '50%', textAlign: 'center', margin: 'auto' }}>
                <h2>Add Vendor</h2>

                <input
                    type="text"
                    value={vendorName}
                    onChange={(e) => setVendorName(e.target.value)}
                    placeholder="Enter vendor name"
                    style={{ marginBottom: '10px' }}
                />
                <br />
                <input
                    type="text"
                    value={deliveryLocation}
                    onChange={(e) => setDeliveryLocation(e.target.value)}
                    placeholder="Enter Store Address"
                    style={{ marginBottom: '10px' }}
                />
                <br />
                <input
                    type="text"
                    value={image}
                    onChange={(e) => setImage(e.target.value)}
                    placeholder="Enter Image"
                    style={{ marginBottom: '10px' }}
                />
                <br />
                <button className="btn btn-primary" onClick={handleSave}>Save</button>
                <Link to="/vendors" className="btn btn-primary" style={{ marginLeft: '10px' }}>Back</Link>
            </div>
        </div>
    );
};

export default AddVendorComponent;
