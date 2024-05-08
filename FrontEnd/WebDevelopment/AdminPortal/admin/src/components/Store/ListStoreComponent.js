import React, { useEffect, useState } from 'react';
import StoreService from '../../services/StoreService'; // Assuming this fetches store data
import styles from '../../styles/ComponentStyles.css'; // Assuming this defines button styles
import { Link, useLocation } from 'react-router-dom';

const ListStoreComponent = () => {
    const [stores, setStores] = useState([]); // State for store data
    const location = useLocation(); // Get current location

    const isStoreActive = () => location.pathname === '/stores'; // Check if current path is '/stores'

    useEffect(() => {
        const refreshStores = async () => {
            console.log("Get All Stores");
            try {
                const response = await StoreService.getAllStores();
                setStores(response.data);
            } catch (error) {
                console.error("Error fetching stores:", error);
            }
        };

        refreshStores();
    }, []); // Empty dependency array to run effect only once

    return (
        <div className={styles.body}>
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="container-fluid">
                    <div className="navbar-nav" style={{ display: 'flex', justifyContent: 'space-around' }}>
                        <Link to="/" className="nav-item nav-link">Users</Link>
                        <Link to="/vendors" className="nav-item nav-link">Vendors</Link>
                        <Link to="/stores" className={`nav-item nav-link ${isStoreActive() ? 'active' : ''}`}>Stores</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/content-management" className="nav-item nav-link">Content Management</Link>
                    </div>
                </div>
            </nav>

            <h2 style={{ marginLeft: '5px' }}>Stores</h2>

            <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                <Link to="/add-store" className="btn btn-primary">Add Store</Link> {/* Add Store button */}
            </div>

            <table className="table table-striped" style={{ margin: '0 auto' }}>
                <thead>
                <tr>
                    <th>Icon</th>
                    <th>Store Name</th>
                    <th>Address</th>
                    <th>Options</th>
                </tr>
                </thead>
                <tbody>
                {stores.map(store => (
                    <tr key={store.store_id}>
                        <td><img src={`https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/${store.image}`} alt="Store Icon" style={{ width: '50px', height: '50px' }} /></td>
                        <td>{store.store_name}</td>
                        <td>{store.store_address}</td> {/* Display store address here */}
                        <td align="center">
                            <Link to={`/edit-store/${store.store_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link>
                            <Link to={`/delete-store/${store.store_id}`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link>
                            <Link to={`/view-store/${store.store_id}`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link>
                        </td>
                    </tr>
                ))}
                </tbody>

            </table>
        </div>
    );
};

export default ListStoreComponent;
