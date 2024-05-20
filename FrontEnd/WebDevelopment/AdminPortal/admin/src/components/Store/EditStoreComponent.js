import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const EditStoreComponent = () => {
    const { store_id } = useParams();
    const [storeName, setStoreName] = useState('');
    const [storeAddress, setStoreAddress] = useState('');
    const [model, setModel] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        async function fetchData() {
            try {
                const response = await StoreService.getStoreById(store_id);
                const { store_name, store_address, model } = response.data;
                setStoreName(store_name);
                setStoreAddress(store_address);
                setModel(model);
            } catch (error) {
                console.error('Error fetching store details:', error);
            }
        }
        fetchData();
    }, [store_id]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await StoreService.editStore(store_id, {
                store_name: storeName,
                store_address: storeAddress,
                model: model,
            });
            console.log('Store updated successfully');
            navigate('/stores');
        } catch (error) {
            console.error('Error updating store:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Update Store</h1>
            <form onSubmit={handleSubmit}>
                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Model</td>
                        <td>
                            <select value={model} onChange={(e) => setModel(e.target.value)}>
                                <option value="">Select Model</option>
                                <option value="xgb">XGB</option>
                                <option value="prophet">Prophet</option>
                                <option value="lightgbm">LightGBM</option>
                            </select>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <br />
                <div align="left" style={{ margin: '20px' }}>
                    <button className="btn btn-primary" type="submit">Update Store</button>
                </div>
            </form>
        </div>
    );
};

export default EditStoreComponent;
