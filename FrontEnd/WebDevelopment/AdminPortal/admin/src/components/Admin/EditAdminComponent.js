import React, { useState, useEffect } from 'react';
import AdminService from '../../services/AdminService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const EditAdminComponent = () => {
    const { product_admin_id } = useParams();
    const [adminRole, setAdminRole] = useState('');
    const [adminEmail, setAdminEmail] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        async function fetchData() {
            try {
                const response = await AdminService.getAdminById(product_admin_id);
                const { admin_role } = response.data;
                setAdminRole(admin_role);
                const {email} = response.data;
                setAdminEmail(email);
            } catch (error) {
                console.error('Error fetching admin details:', error);
            }
        }
        fetchData();
    }, [product_admin_id]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await AdminService.editAdmin(product_admin_id, {
                admin_role: adminRole,
                email: adminEmail,
            });
            console.log('Admin updated successfully');
            navigate('/admins');
        } catch (error) {
            console.error('Error updating admin:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Update Admin</h1>
            <form onSubmit={handleSubmit}>
                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Admin Role</td>
                        <td><input type="text" value={adminRole} onChange={(e) => setAdminRole(e.target.value)}/></td>
                    </tr>
                    <tr>
                        <td>Admin Email</td>
                        <td><input type="text" value={adminEmail} onChange={(e) => setAdminEmail(e.target.value)}/></td>
                    </tr>
                    </tbody>
                </table>
                <br/>
                <div align="left" style={{margin: '20px'}}>
                    <button className="btn btn-primary" type="submit">Update Admin</button>
                </div>
            </form>
        </div>
    );
};

export default EditAdminComponent;
