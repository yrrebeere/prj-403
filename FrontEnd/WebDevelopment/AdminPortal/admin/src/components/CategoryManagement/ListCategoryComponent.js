import React from 'react';
import CategoryService from '../../services/CategoryService';
import styles from '../../styles/ComponentStyles.css';
import { Link } from 'react-router-dom';

class ListCategoryComponent extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            categories: []
        };
    }

    componentDidMount() {
        this.refreshCategories();
    }

    refreshCategories = () => {
        CategoryService.getAllCategories()
            .then((response) => {
                this.setState({ categories: response.data });
            })
            .catch(error => {
                console.error("Error fetching stock counts:", error);
            });
    };

    deleteCategory = (categoryId) => {
        CategoryService.deleteCategory(categoryId)
            .then(() => {
                this.refreshCategories();
            })
            .catch(error => {
                console.error("Error deleting stock count:", error);
            });
    };

    render() {
        return (
            <div className={styles.body}>
                <br />
                <h1 style={{ marginLeft: '5px' }}>Company Name</h1>

                <div align="left" style={{ margin: '20px' }}>
                    <Link to="/add-category" className="btn btn-primary" style={{ textAlign: 'left' }}>Add Category</Link>
                </div>

                <table className="table table-striped">
                    <thead>
                    <tr>
                        <th>Category Id</th>
                        <th>Category Name</th>
                        <th>Options</th>
                    </tr>
                    </thead>
                    <tbody>
                    {this.state.categories.map(category => (
                        <tr key={category.product_category_id}>
                            <td>{category.product_category_id}</td>
                            <td>{category.category_name}</td>
                            <td align="center">
                                <Link to={`/edit-category/${category.product_category_id}`} className="btn btn-primary"
                                      style={{marginLeft: '5px'}}>Update</Link> &nbsp;
                                <button onClick={() => this.deleteCategory(category.product_category_id)}
                                        className="btn btn-danger">Delete
                                </button>
                            </td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            </div>
        );
    }
}

export default ListCategoryComponent;