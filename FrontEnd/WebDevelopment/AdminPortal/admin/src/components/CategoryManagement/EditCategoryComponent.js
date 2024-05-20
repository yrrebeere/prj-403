import React, { useState, useEffect } from 'react';
import CategoryService from '../../services/CategoryService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';
import axios from "axios";

const EditCategoryComponent = () => {
    const { product_category_id } = useParams();
    const [categoryName, setCategoryName] = useState('');
    const [imageFile, setImageFile] = useState(null);
    const navigate = useNavigate();

    const handleFileChange = (e) => {
        setImageFile(e.target.files[0]);
    };

    useEffect(() => {
        async function fetchData() {
            try {
                const response = await CategoryService.getCategoryById(product_category_id);
                const { category_name } = response.data;
                setCategoryName(category_name);
            } catch (error) {
                console.error('Error fetching category details:', error);
            }
        }
        fetchData();
    }, [product_category_id]);

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            const extension = imageFile ? imageFile.name.split('.').pop() : '';

            const imagePath = `categories/${categoryName}.${extension}`;

            await CategoryService.editCategory(product_category_id,{
                category_name: categoryName,
                image: imagePath,
            });

            console.log('Category added successfully');

            if (imageFile) {
                const formData = new FormData();
                formData.append('file', imageFile);

                const apiUrl = `https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/uploadcategory?category_name=${categoryName}`;
                await axios.post(apiUrl, formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data',
                    },
                });

                console.log('Image uploaded successfully');
            }

            navigate('/categories');
        } catch (error) {
            console.error('Error adding Product:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Update Category</h1>
            <form onSubmit={handleSubmit}>
                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Category Name</td>
                        <td><input type="text" value={categoryName} onChange={(e) => setCategoryName(e.target.value)}/></td>
                    </tr>
                    <tr>
                        <td>Category Image</td>
                        <td>
                            <input type="file" onChange={handleFileChange} />
                        </td>
                    </tr>
                    </tbody>
                </table>
                <br/>
                <div align="left" style={{margin: '20px'}}>
                    <button onClick={() => window.location.href = `/categories`}
                            className="btn btn-primary">Back
                    </button>
                    &nbsp;
                    <button className="btn btn-primary" type="submit">Update Category</button>
                </div>
            </form>
        </div>
    );
};

export default EditCategoryComponent;
