import React, { useState } from 'react';
import ProductService from '../../services/ProductService';
import styles from '../../styles/ComponentStyles.css';
import { useNavigate } from 'react-router-dom';

const AddProductForm = () => {
    const [productName, setProductName] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {

        e.preventDefault();

        try {
            await ProductService.addProduct({
                product_name: productName,
            });

            console.log('Product added successfully');
            navigate('/products');
        } catch (error) {
            console.error('Error adding Product:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Company Name</h1>

            <form onSubmit={handleSubmit}>

                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Product</td>
                        <td><input type="text" value={productName} onChange={(e) => setProductName(e.target.value)}/></td>
                    </tr>
                    </tbody>
                </table>
                <br/>

                <div align="left" style={{margin: '20px'}}>
                    <a href="/" className="btn btn-primary" style={{textAlign: 'left'}}>Back</a>
                    <button style={{marginLeft: '5px'}} className="btn btn-primary" type="submit">Add Product</button>
                </div>

            </form>
        </div>
    );
};

export default AddProductForm;
