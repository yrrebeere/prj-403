import React, { useState, useEffect } from 'react';
import AdminService from '../../services/AdminService';
import UserService from '../../services/UserService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const EditAdminComponent = () => {
    const { admin_id } = useParams();
    const [adminRole, setAdminRole] = useState('');
    const [adminEmail, setAdminEmail] = useState('');
    const [userId, setUserId] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [name, setName] = useState('');
    const [password, setPassword] = useState('');
    const [username, setUsername] = useState('');
    const [language, setLanguage] = useState('');
    const [userType, setUserType] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        async function fetchData() {
            try {
                // Fetch admin details
                const adminResponse = await AdminService.getAdminById(admin_id);
                const { admin_role, email, user_table_user_id } = adminResponse.data;
                setAdminRole(admin_role);
                setAdminEmail(email);
                setUserId(user_table_user_id);

                // Fetch corresponding user details
                const userResponse = await UserService.getUserById(user_table_user_id);
                const { phone_number, name, password, username, language, user_type } = userResponse.data;
                setPhoneNumber(phone_number);
                setName(name);
                setPassword(password);
                setUsername(username);
                setLanguage(language);
                setUserType(user_type);
            } catch (error) {
                console.error('Error fetching admin details:', error);
            }
        }
        fetchData();
    }, [admin_id]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            // Update user details
            await UserService.editUser(userId, {
                phone_number: phoneNumber,
                name: name,
                password: password,
                username: username,
                language: language,
                user_type: userType,
            });

            // Update admin details
            await AdminService.editAdmin(admin_id, {
                admin_role: adminRole,
                email: adminEmail,
                user_table_user_id: userId,
            });

            console.log('Admin updated successfully');
            navigate('/');
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
                    {/* Admin Table Fields */}
                    <tr>
                        <td>Admin Role</td>
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
                        <td>Admin Email</td>
                        <td><input type="email" value={adminEmail} onChange={(e) => setAdminEmail(e.target.value)}/></td>
                    </tr>
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
                    </tbody>
                </table>
                <br/>
                <div align="left" style={{margin: '20px'}}>
                    <button onClick={() => window.location.href = `/admins`}
                            className="btn btn-primary">Back
                    </button>
                    &nbsp;
                    <button className="btn btn-primary" type="submit">Update Admin</button>
                </div>
            </form>
        </div>
    );
};

export default EditAdminComponent;
