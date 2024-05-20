import React, { useState, useEffect } from 'react';
import ProductService from '../../services/ProductService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const EditProductComponent = () => {
    const { product_id } = useParams();
    const [productName, setProductName] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        async function fetchData() {
            try {
                const response = await ProductService.getProductById(product_id);
                const { product_name } = response.data;
                setProductName(product_name);
            } catch (error) {
                console.error('Error fetching product details:', error);
            }
        }
        fetchData();
    }, [product_id]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            console.log(product_id)
            console.log(productName)
            await ProductService.editProduct(product_id, {
                product_name: productName,
            });
            console.log('Product updated successfully');
            navigate('/products');
        } catch (error) {
            console.error('Error updating product:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Update Product</h1>
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
                    <button className="btn btn-primary" type="submit">Update Product</button>
                </div>
            </form>
        </div>
    );
};

export default EditProductComponent;
