import React, { useState, useEffect } from 'react';
import CategoryService from '../../services/CategoryService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const EditCategoryComponent = () => {
    const { product_category_id } = useParams();
    const [categoryName, setCategoryName] = useState('');
    const navigate = useNavigate();

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
            await CategoryService.editCategory(product_category_id, {
                category_name: categoryName,
            });
            console.log('Category updated successfully');
            navigate('/categories');
        } catch (error) {
            console.error('Error updating category:', error);
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
                    </tbody>
                </table>
                <br/>
                <div align="left" style={{margin: '20px'}}>
                    <button className="btn btn-primary" type="submit">Update Category</button>
                </div>
            </form>
        </div>
    );
};

export default EditCategoryComponent;
