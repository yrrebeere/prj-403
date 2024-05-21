import React, { useState } from 'react';
import ProductService from '../../services/ProductService';
import { useNavigate } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from 'axios';

const AddProductForm = () => {
    const [productName, setProductName] = useState('');
    const [imageFile, setImageFile] = useState(null);
    const navigate = useNavigate();

    const handleFileChange = (e) => {
        setImageFile(e.target.files[0]);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            const extension = imageFile ? imageFile.name.split('.').pop() : '';
            const imagePath = `products/${productName}.${extension}`;

            await ProductService.addProduct({
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
        <div className="container mt-5">
            <h1>Add Product</h1>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label htmlFor="productName"><b>Product Name</b></label>
                    <br/>
                    <input
                        type="text"
                        className="form-control"
                        id="productName"
                        value={productName}
                        onChange={(e) => setProductName(e.target.value)}
                    />
                </div>
                <br/>
                <div className="form-group">
                    <label htmlFor="productImage"><b>Product Image:</b></label>
                    &nbsp;&nbsp;
                    <input
                        type="file"
                        className="form-control-file"
                        id="productImage"
                        onChange={handleFileChange}
                    />
                </div>
                <br/>
                <div className="form-group">
                    <button
                        onClick={() => navigate('/products')}
                        className="btn btn-secondary mr-2"
                        type="button"
                    >
                        Back
                    </button>
                    &nbsp;&nbsp;
                    <button className="btn btn-primary" type="submit">
                        Add Product
                    </button>
                </div>
            </form>
        </div>
    );
};

export default AddProductForm;
