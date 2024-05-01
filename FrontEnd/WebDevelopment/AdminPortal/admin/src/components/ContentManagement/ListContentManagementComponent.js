import React from 'react';
import ContentManagementService from '../../services/ContentManagementService'; // Assuming this fetches content management data
import styles from '../../styles/ComponentStyles.css'; // Assuming this defines button styles
import { Link, useLocation } from 'react-router-dom';

const ListContentManagementComponent = ({}) => {
    const [categories, setCategories] = React.useState([]); // State for content management data
    const location = useLocation(); // Get current location

    React.useEffect(() => {
        const refreshCategories = async () => {
            console.log("Get All Product Categories");
            try {
                const response = await ContentManagementService.getAllProductCategories();
                setCategories(response.data);
            } catch (error) {
                console.error("Error fetching product categories:", error);
            }
        };

        refreshCategories();
    }, []); // Empty dependency array to run effect only once

    // Function to conditionally add the "active" class for styling
    const isActive = () => location.pathname === '/contentManagement'; // Check if current path is '/contentManagement'

    return (
        <div className={styles.body}>
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="container-fluid">
                    <div className="navbar-nav" style={{ display: 'flex', justifyContent: 'space-around' }}>
                        <Link to="/users" className="nav-item nav-link">Users</Link>
                        <Link to="/vendors" className="nav-item nav-link">Vendors</Link>
                        <Link to="/groceries" className="nav-item nav-link">Groceries</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/contentManagement" className={`nav-item nav-link ${isActive() ? 'active' : ''}`}>Content Management</Link>
                    </div>
                </div>
            </nav>

            <h2 style={{ marginLeft: '5px' }}>List Category </h2>
            <div style={{ textAlign: 'center', marginBottom: '20px' }}>
                <Link to="/addCategory" className="btn btn-primary">Add Category</Link>
            </div>
            <table className="table table-striped" style={{ margin: '0 auto' }}>
                <thead>
                <tr>
                    <th>Category Name</th>
                    <th>Options</th>
                </tr>
                </thead>
                <tbody>
                {categories.map(category => (
                    <tr key={category.category_id}>
                        <td>{category.category_name}</td>
                        <td align="center">
                            <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link> &nbsp;
                            <Link to={`/`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link> &nbsp;
                            <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link> &nbsp;
                        </td>
                    </tr>
                ))}
                </tbody>
            </table>
            <div style={{ textAlign: 'center', marginTop: '20px' }}>
                <Link to="/listProducts" className="btn btn-primary">List Products</Link>
            </div>
        </div>
    );
};

export default ListContentManagementComponent;
