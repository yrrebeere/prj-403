import React, { useState } from 'react';
import CategoryService from '../../services/CategoryService';
import styles from '../../styles/ComponentStyles.css';
import { useNavigate } from 'react-router-dom';

const AddCategoryForm = () => {
    const [categoryName, setCategoryName] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {

        e.preventDefault();

        try {
            await CategoryService.addCategory({
                category_name: categoryName,
            });

            console.log('Category added successfully');
            navigate('/categories');
        } catch (error) {
            console.error('Error adding Category:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Add Category</h1>

            <form onSubmit={handleSubmit}>

                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Category</td>
                        <td><input type="text" value={categoryName} onChange={(e) => setCategoryName(e.target.value)}/></td>
                    </tr>
                    </tbody>
                </table>
                <br/>

                <div align="left" style={{margin: '20px'}}>
                    <a href="/categories" className="btn btn-primary" style={{textAlign: 'left'}}>Back</a>
                    <button style={{marginLeft: '5px'}} className="btn btn-primary" type="submit">Add Category</button>
                </div>

            </form>
        </div>
    );
};

export default AddCategoryForm;
