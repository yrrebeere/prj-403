import React, { useState, useEffect } from 'react';
import StoreService from '../../services/StoreService';
import { useParams, useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';

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
        <div className="container mt-5">
            <h1 className="mb-4">Update Store</h1>
            <form onSubmit={handleSubmit} className="needs-validation" noValidate>
                <div className="form-group">
                    <label htmlFor="storeName">Store Name</label>
                    <input
                        type="text"
                        className="form-control"
                        id="storeName"
                        value={storeName}
                        onChange={(e) => setStoreName(e.target.value)}
                        required
                    />
                    <div className="invalid-feedback">
                        Please provide a store name.
                    </div>
                </div>
                <br/>
                <div className="form-group">
                    <label htmlFor="storeAddress">Store Address</label>
                    <input
                        type="text"
                        className="form-control"
                        id="storeAddress"
                        value={storeAddress}
                        onChange={(e) => setStoreAddress(e.target.value)}
                        required
                    />
                    <div className="invalid-feedback">
                        Please provide a store address.
                    </div>
                </div>
                <br/>
                <div className="form-group">
                    <label htmlFor="model">Model</label>
                    <select
                        className="form-control"
                        id="model"
                        value={model}
                        onChange={(e) => setModel(e.target.value)}
                        required
                    >
                        <option value="">Select Model</option>
                        <option value="xgb">XGB</option>
                        <option value="prophet">Prophet</option>
                        <option value="lgbm">LightGBM</option>
                    </select>
                    <div className="invalid-feedback">
                        Please select a model.
                    </div>
                </div>
                <br/>
                <div className="form-group">
                    <button
                        onClick={() => navigate('/stores')}
                        className="btn btn-secondary mr-2"
                        type="button"
                    >
                        Back
                    </button>
                    &nbsp;&nbsp;
                    <button className="btn btn-primary" type="submit">
                        Update Store
                    </button>
                </div>
            </form>
        </div>
    );
};

export default EditStoreComponent;
