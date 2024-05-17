import React, { useState } from 'react';
import AdminService from '../../services/AdminService';
import styles from '../../styles/ComponentStyles.css';
import { useNavigate } from 'react-router-dom';

const AddAdminForm = () => {
    const [adminRole, setAdminRole] = useState('');
    const [adminEmail, setAdminEmail] = useState('');
    const [userId, setUserId] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {

        e.preventDefault();

        try {
            await AdminService.addAdmin({
                admin_role: adminRole,
                email: adminEmail,
                user_table_user_id: userId,
            });

            console.log('Admin added successfully');
            navigate('/admins');
        } catch (error) {
            console.error('Error adding Admin:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Add New User</h1>

            <form onSubmit={handleSubmit}>

                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Role</td>
                        <td><input type="text" value={adminRole} onChange={(e) => setAdminRole(e.target.value)}/></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><input type="text" value={adminEmail} onChange={(e) => setAdminEmail(e.target.value)}/></td>
                    </tr>
                    <tr>
                        <td>User Id</td>
                        <td><input type="text" value={userId} onChange={(e) => setUserId(e.target.value)}/></td>
                    </tr>
                    </tbody>
                </table>
                <br/>

                <div align="left" style={{margin: '20px'}}>
                    <a href="/" className="btn btn-primary" style={{textAlign: 'left'}}>Back</a>
                    <button style={{marginLeft: '5px'}} className="btn btn-primary" type="submit">Add Admin</button>
                </div>

            </form>
        </div>
    );
};

export default AddAdminForm;
