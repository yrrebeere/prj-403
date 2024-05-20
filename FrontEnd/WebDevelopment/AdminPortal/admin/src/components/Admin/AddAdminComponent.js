import React, { useState } from 'react';
import AdminService from '../../services/AdminService';
import UserService from '../../services/UserService';
import styles from '../../styles/ComponentStyles.css';
import { useNavigate } from 'react-router-dom';

const AddAdminForm = () => {
    const [adminRole, setAdminRole] = useState('');
    const [adminEmail, setAdminEmail] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [name, setName] = useState('');
    const [password, setPassword] = useState('');
    const [username, setUsername] = useState('');
    const [language, setLanguage] = useState('');
    const [userType, setUserType] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            // First save the user data to user_table
            const userResponse = await UserService.addUser({
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
            <h1>Add New Admin</h1>

            <form onSubmit={handleSubmit}>

                <table className="table table-striped">
                    <tbody>
                    {/* User Table Fields */}
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
                        <td>
                            <select value={language} onChange={(e) => setLanguage(e.target.value)}>
                                <option value="">Select Language</option>
                                <option value="English">English</option>
                                <option value="Urdu">Urdu</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>User Type</td>
                        <td><input type="text" value={userType} onChange={(e) => setUserType(e.target.value)} /></td>
                    </tr>
                    {/* Admin Table Fields */}
                    <tr>
                        <td>Role</td>
                        <td>
                            <select value={adminRole} onChange={(e) => setAdminRole(e.target.value)}>
                                <option value="">Select Role</option>
                                <option value="Viewer">Viewer</option>
                                <option value="Editor">Editor</option>
                                <option value="Moderator">Moderator</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><input type="text" value={adminEmail} onChange={(e) => setAdminEmail(e.target.value)} /></td>
                    </tr>
                    </tbody>
                </table>
                <br/>

                <div align="left" style={{margin: '20px'}}>
                    <button onClick={() => window.location.href = `/admins`}
                            className="btn btn-primary">Back
                    </button>
                    &nbsp;
                    <button
                            className="btn btn-primary" type="submit">Add Admin
                    </button>
                </div>

            </form>
        </div>
    );
};

export default AddAdminForm;
