import React, { useState } from 'react';
import AdminService from '../../services/AdminService';
import UserService from '../../services/UserService';
import styles from '../../styles/ComponentStyles.css';
import { useNavigate } from 'react-router-dom';

const AddAdminForm = () => {
    const [adminRole, setAdminRole] = useState('');
    const [adminEmail, setAdminEmail] = useState('');
    const [userId, setUserId] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [name, setName] = useState('');
    const [password, setPassword] = useState('');
    const [username, setUsername] = useState('');
    const [language, setLanguage] = useState('');
    const [userType, setuserType] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            // First save the user data to user_table
            const userResponse = await UserService.addUser({
                user_id: userId,
                phone_number: phoneNumber,
                name: name,
                password: password,
                username: username,
                language: language,
                user_type: userType,
            });

            // Then save the admin data to admin table, using the user ID returned from the user table
            await AdminService.addAdmin({
                admin_role: adminRole,
                email: adminEmail,
                user_table_user_id: userResponse.data.user_id,
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
                    {/* User Table Fields */}
                    <tr>
                        <td>User ID</td>
                        <td><input type="text" value={userId} onChange={(e) => setUserId(e.target.value)} /></td>
                    </tr>
                    <tr>
                        <td>Phone Number</td>
                        <td><input type="text" value={phoneNumber} onChange={(e) => setPhoneNumber(e.target.value)} /></td>
                    </tr>
                    <tr>
                        <td>Name</td>
                        <td><input type="text" value={name} onChange={(e) => setName(e.target.value)} /></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" value={password} onChange={(e) => setPassword(e.target.value)} /></td>
                    </tr>
                    <tr>
                        <td>Username</td>
                        <td><input type="text" value={username} onChange={(e) => setUsername(e.target.value)} /></td>
                    </tr>
                    <tr>
                        <td>Language</td>
                        <td><input type="text" value={language} onChange={(e) => setLanguage(e.target.value)} /></td>
                    </tr>
                    <tr>
                        <td>User Type</td>
                        <td><input type="text" value={userType} onChange={(e) => setuserType(e.target.value)} /></td>
                    </tr>
                    {/* Admin Table Fields */}
                    <tr>
                        <td>Role</td>
                        <td><input type="text" value={adminRole} onChange={(e) => setAdminRole(e.target.value)} /></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><input type="text" value={adminEmail} onChange={(e) => setAdminEmail(e.target.value)} /></td>
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
