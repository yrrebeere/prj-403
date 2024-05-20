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
            <h1>Add Product</h1>

            <form onSubmit={handleSubmit}>

                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Product Name</td>
                        <td><input type="text" value={productName} onChange={(e) => setProductName(e.target.value)}/></td>
                    </tr>
                    </tbody>
                </table>
                <br/>

                <div align="left" style={{margin: '20px'}}>
                    <button onClick={() => window.location.href = `/products`}
                            className="btn btn-primary">Back
                    </button>
                    &nbsp;
                    <button className="btn btn-primary" type="submit">Add Product</button>
                </div>

            </form>
        </div>
    );
};

export default AddProductForm;
