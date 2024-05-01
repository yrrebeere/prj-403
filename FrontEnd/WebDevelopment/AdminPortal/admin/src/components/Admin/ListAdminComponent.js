import React from 'react';
import AdminService from '../../services/AdminService'; // Assuming this fetches admin data
import styles from '../../styles/ComponentStyles.css'; // Assuming this defines button styles
import { Link, useLocation } from 'react-router-dom';
import Vendors from './vendors'; // Assuming this is the component for the vendors page

const ListAdminComponent = ({}) => {
    const [admins, setAdmins] = React.useState([]); // State for admin data
    const location = useLocation(); // Get current location

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

    // Function to conditionally add the "active" class for styling
    const isActive = () => location.pathname === '/users'; // Check if current path is '/users'

    return (
        <div className={styles.body}>
            <br />
            <h1 style={{ marginLeft: '5px' }}>Admin Portal</h1>

            <div className="admin-navigation" align="left" style={{ marginLeft: '20px', marginBottom: '20px', display: 'flex', justifyContent: 'center' }}> {/* Center buttons using flexbox */}
                <Link to="/users" className={`btn btn-primary ${isActive() ? 'active' : ''}`}>Users</Link>  {/* Highlight based on pathname */}
                <Link to="/vendors" className="btn btn-primary" style={{marginLeft: '10px'}}>Vendors</Link> {/* Link to the Vendors component */}
                <Link to="/groceries" className="btn btn-primary" style={{marginLeft: '10px'}}>Groceries</Link>
                <Link to="/analytics" className="btn btn-primary" style={{marginLeft: '10px'}}>Analytics</Link>
                <Link to="/ml" className="btn btn-primary" style={{marginLeft: '10px'}}>Machine Learning</Link>
                <Link to="/contentManagement " className="btn btn-primary" style={{marginLeft: '10px'}}>Content Management</Link>
            </div>

            <table className="table table-striped" style={{ margin: '0 auto' }}> {/* Center the table using margin: 0 auto */}
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
                            <Link to={`/`} className="btn btn-primary" style={{marginLeft: '5px'}}>Edit</Link> &nbsp;
                            <Link to={`/`} className="btn btn-danger" style={{marginLeft: '5px'}}>Delete</Link> &nbsp;
                            <Link to={`/`} className="btn btn-primary" style={{marginLeft: '5px'}}>View</Link> &nbsp;
                        </td>
                    </tr>
                ))}
                </tbody>
            </table>
        </div>
    );
};

export default ListAdminComponent;
