import React, { useState, useEffect } from 'react';
import ProductService from '../../services/ProductService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';
import axios from "axios";

const EditProductComponent = () => {
    const { product_id } = useParams();
    const [productName, setProductName] = useState('');
    const [imageFile, setImageFile] = useState(null);
    const navigate = useNavigate();

    const handleFileChange = (e) => {
        setImageFile(e.target.files[0]);
    };

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
            const extension = imageFile ? imageFile.name.split('.').pop() : '';

            const imagePath = `products/${productName}.${extension}`;

            await ProductService.editProduct(product_id,{
                product_name: productName,
                image: imagePath,
            });

            console.log('Product added successfully');

            if (imageFile) {
                const formData = new FormData();
                formData.append('file', imageFile);

                const apiUrl = `https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/uploadproduct?product_name=${productName}`;
                await axios.post(apiUrl, formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data',
                    },
                });

                console.log('Image uploaded successfully');
            }

            navigate('/products');
        } catch (error) {
            console.error('Error adding Product:', error);
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
                    <tr>
                        <td>Product Image</td>
                        <td>
                            <input type="file" onChange={handleFileChange} />
                        </td>
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
