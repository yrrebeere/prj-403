import React from 'react';
import AdminService from '../../services/AdminService'; // Assuming this fetches admin data
import styles from '../../styles/ComponentStyles.css'; // Assuming this defines button styles
import { Link, useLocation } from 'react-router-dom';

// Convert ListAdminComponent to a functional component
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

    return (
        <div className={styles.body}>
            <br />
            <h1 style={{ marginLeft: '5px' }}>Admin Portal</h1>

            <table className="table table-striped" style={{ margin: '0 auto', width: '80%' }}> {/* Center and reduce width */}
                <thead>
                <tr>
                    {/*<th>Username</th>*/}
                    {/*<th>Name</th>*/}
                    <th>Email</th>
                    <th>Role</th>
                    <th>Options</th>
                </tr>
                </thead>
                <tbody>
                {admins.map(admin => (
                    <tr key={admin.admin_id}>
                        {/*<td>{admin.username}</td>*/}
                        {/*<td>{admin.name}</td>*/}
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
