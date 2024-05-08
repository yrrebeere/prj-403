import React, { useEffect, useState } from 'react';
import VendorService from '../../services/VendorService'; // Assuming this fetches vendor data
import styles from '../../styles/ComponentStyles.css'; // Assuming this defines button styles
import { Link, useLocation } from 'react-router-dom';

const ListVendorComponent = () => {
    const [vendors, setVendors] = useState([]); // State for vendor data
    const location = useLocation(); // Get current location

    const isVendorActive = () => location.pathname === '/vendors'; // Check if current path is '/vendors'

    useEffect(() => {
        const refreshVendors = async () => {
            console.log("Get All Vendors");
            try {
                const response = await VendorService.getAllVendors();
                setVendors(response.data);
            } catch (error) {
                console.error("Error fetching vendors:", error);
            }
        };

        refreshVendors();
    }, []); // Empty dependency array to run effect only once

    return (
        <div className={styles.body}>
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="container-fluid">
                    <div className="navbar-nav" style={{ display: 'flex', justifyContent: 'space-around' }}>
                        <Link to="/" className="nav-item nav-link">Users</Link>
                        <Link to="/vendors" className={`nav-item nav-link ${isVendorActive() ? 'active' : ''}`}>Vendors</Link>
                        <Link to="/stores" className="nav-item nav-link">Stores</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/content-management" className="nav-item nav-link">Content Management</Link>
                    </div>
                </div>
            </nav>

            <h2 style={{ marginLeft: '5px' }}>Vendors</h2>

            <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                <Link to="/add-vendor" className="btn btn-primary">Add Vendor</Link> {/* Add Vendor button */}
            </div>

            <table className="table table-striped" style={{ margin: '0 auto' }}>
                <thead>
                <tr>
                    <th>Icon</th>
                    <th>Vendor Name</th>
                    <th>Location</th>
                    <th>Options</th>
                </tr>
                </thead>
                <tbody>
                {vendors.map(vendor => (
                    <tr key={vendor.vendor_id}>
                        <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${vendor.image}`} alt="Vendor Icon" style={{ width: '50px', height: '50px' }} /></td>
                        <td>{vendor.vendor_name}</td>
                        <td>{vendor.delivery_locations}</td>
                        <td align="center">
                            <Link to={`/edit-vendor/${vendor.vendor_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link>
                            <Link to={`/delete-vendor/${vendor.vendor_id}`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link>
                            <Link to={`/view-vendor/${vendor.vendor_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link>
                        </td>
                    </tr>
                ))}
                </tbody>
            </table>
        </div>
    );
};

export default ListVendorComponent;
