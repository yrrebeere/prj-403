import React, { useState } from 'react';
import StoreService from '../../services/StoreService';
import styles from '../../styles/ComponentStyles.css';
import { useNavigate } from 'react-router-dom';

const AddStoreForm = () => {
    const [StoreName, setStoreName] = useState('');
    const [StoreAddress, setStoreAddress] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {

        e.preventDefault();

        try {
            await StoreService.addStore({
                Store_name: StoreName,
                store_address: StoreAddress,
            });

            console.log('Store added successfully');
            navigate('/stores');
        } catch (error) {
            console.error('Error adding Store:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Add a Store</h1>

            <form onSubmit={handleSubmit}>

                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Store</td>
                        <td><input type="text" value={StoreName} onChange={(e) => setStoreName(e.target.value)}/></td>
                    </tr>
                    <tr>
                        <td>Address</td>
                        <td><input type="text" value={StoreAddress} onChange={(e) => setStoreAddress(e.target.value)}/>
                        </td>

                    </tr>
                    </tbody>
                </table>
                <br/>

                <div align="left" style={{margin: '20px'}}>
                    <a href="/" className="btn btn-primary" style={{textAlign: 'left'}}>Back</a>
                    <button style={{marginLeft: '5px'}} className="btn btn-primary" type="submit">Add Store</button>
                </div>

            </form>
        </div>
    );
};

export default AddStoreForm;
