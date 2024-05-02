import React from 'react';
import AdminService from '../../services/AdminService'; // Assuming this fetches admin data
import styles from '../../styles/ComponentStyles.css'; // Assuming this defines button styles
import { Link, useLocation } from 'react-router-dom';

const ListAdminComponent = () => {
    const [admins, setAdmins] = React.useState([]); // State for admin data
    const location = useLocation(); // Get current location

    const isAdminActive = () => location.pathname === '/ListAdminComponent'; // Check if current path is '/users'

    React.useEffect(() => {
        const refreshAdmins = async () => {
            console.log("Get All Admins");
            try {
                const response = await AdminService.getAllAdmins();
                setAdmins(response.data);
            } catch (error) {
                console.error("Error fetching admins:", error);
            }
        };

        refreshAdmins();
    }, []); // Empty dependency array to run effect only once

    return (
        <div className={styles.body}>
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <div className="container-fluid">
                    <div className="navbar-nav" style={{ display: 'flex', justifyContent: 'space-around' }}>
                        <Link to="/ListAdminComponent" className={`nav-item nav-link ${isAdminActive() ? 'active' : ''}`}>Users</Link>
                        <Link to="/vendors" className="nav-item nav-link">Vendors</Link>
                        <Link to="/groceries" className="nav-item nav-link">Groceries</Link>
                        <Link to="/analytics" className="nav-item nav-link">Analytics</Link>
                        <Link to="/ml" className="nav-item nav-link">Machine Learning</Link>
                        <Link to="/contentManagement" className="nav-item nav-link">Content</Link>
                    </div>
                </div>
            </nav>

            <h2 style={{ marginLeft: '5px' }}>Users</h2>

            <table className="table table-striped" style={{ margin: '0 auto' }}>
                <thead>
                <tr>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Options</th>
                </tr>
                </thead>
                <tbody>
                {admins.map(admin => (
                    <tr key={admin.admin_id}>
                        <td>{admin.email}</td>
                        <td>{admin.admin_role}</td>
                        <td align="center">
                            <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>Edit</Link> &nbsp;
                            <Link to={`/`} className="btn btn-danger" style={{ marginLeft: '5px' }}>Delete</Link> &nbsp;
                            <Link to={`/`} className="btn btn-primary" style={{ marginLeft: '5px' }}>View</Link> &nbsp;
                        </td>
                    </tr>
                ))}
                </tbody>
            </table>
        </div>
    );
};

export default ListAdminComponent;
