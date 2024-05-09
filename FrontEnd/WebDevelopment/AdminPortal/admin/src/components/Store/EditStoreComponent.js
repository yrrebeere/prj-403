import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const EditStoreComponent = () => {
    const { store_id } = useParams();
    const [storeName, setStoreName] = useState('');
    const [storeAddress, setStoreAddress] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        fetchData();
    }, [store_id]);

    const fetchData = async () => {
        try {
            const response = await StoreService.getStoreById(store_id);
            const { store_name, store_address } = response.data; // Updated to use store_address
            setStoreName(store_name); // No need to convert to string, assuming it's already a string
            setStoreAddress(store_address); // Set the store address
        } catch (error) {
            console.error('Error fetching store details:', error);
        }
    };


    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await StoreService.updateStore(store_id, {
                store_name: storeName,
                store_address: storeAddress // Update store address in the request
            });
            console.log('Store updated successfully');
            navigate('/content-management');
        } catch (error) {
            console.error('Error updating store:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Edit Store</h1>
            <form onSubmit={handleSubmit}>
                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Store Name</td>
                        <td>
                            <input
                                type="text"
                                value={storeName}
                                onChange={(e) => setStoreName(e.target.value)}
                            />
                        </td>
                    </tr>
                    <tr>
                        <td>Store Address</td>
                        <td>
                            <input
                                type="text"
                                value={storeAddress}
                                onChange={(e) => setStoreAddress(e.target.value)}
                            />
                        </td>
                    </tr>
                    </tbody>
                </table>
                <br />
                <div align="left" style={{ margin: '20px' }}>
                    <button className="btn btn-primary" type="submit">Save</button>
                </div>
            </form>
        </div>
    );
};

export default EditStoreComponent;
