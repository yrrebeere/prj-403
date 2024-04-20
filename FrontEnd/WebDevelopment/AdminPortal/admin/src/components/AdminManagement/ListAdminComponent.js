import React from 'react';
import AdminService from '../../services/AdminService';
import styles from '../../styles/ComponentStyles.css';
import { Link } from 'react-router-dom';

class ListAdminComponent extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            admins: []
        };
    }

    componentDidMount() {
        this.refreshAdmins();
    }

    refreshAdmins = () => {
        console.log("Get All Admins");

        AdminService.getAllAdmins()
            .then((response) => {
                this.setState({ admins: response.data });
            })
            .catch(error => {
                console.error("Error fetching cash books:", error);
            });
    };

    deleteAdmin = (adminId) => {
        AdminService.deleteAdmin(adminId)
            .then(() => {
                this.refreshAdmins();
            })
            .catch(error => {
                console.error("Error deleting cash book:", error);
            });
    };

    render() {
        return (
            <div className={styles.body} align={'center'}>
                <br />
                <h1 style={{ marginLeft: '5px' }}>Admin Portal</h1>

                <div align="left" style={{ marginLeft: '72px', marginBottom: '20px' }}>
                    <Link to="/" className="btn btn-primary" style={{ textAlign: 'left' }}>Add Admin</Link>
                </div>

                <table className="table table-striped">
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
                    {this.state.admins.map(admin => (
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
    }
}

export default ListAdminComponent;
