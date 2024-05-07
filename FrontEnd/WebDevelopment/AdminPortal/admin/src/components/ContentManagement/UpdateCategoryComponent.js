import React, { useState, useEffect } from 'react';
import ContentManagementService from '../../services/ContentManagementService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const UpdateCategoryComponent = () => {
    const { product_category_id } = useParams();
    const [categoryName, setCategoryName] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        fetchData();
    }, []);

    const fetchData = async () => {
        try {
            const response = await ContentManagementService.getProductCategoryById(product_category_id);
            const { category_name } = response.data;
            setCategoryName(category_name);
        } catch (error) {
            console.error('Error fetching category details:', error);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await ContentManagementService.updateProductCategory(product_category_id, {
                category_name: categoryName
            });
            console.log('Category updated successfully');
            navigate('/content-management');
        } catch (error) {
            console.error('Error updating category:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Edit Category</h1>
            <form onSubmit={handleSubmit}>
                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Category Name</td>
                        <td><input type="text" value={categoryName} onChange={(e) => setCategoryName(e.target.value)} /></td>
                    </tr>
                    </tbody>
                </table>
                <br />
                <div align="left" style={{ margin: '20px' }}>
                    <button className="btn btn-primary" type="submit">Update Category</button>
                </div>
            </form>
        </div>
    );
};

export default UpdateCategoryComponent;
