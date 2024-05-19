import axios from 'axios';

class UserService {

    addUser(info) {
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/adduser', info);
    }

    editUser(user_id, info) {
        return axios.put('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/' + user_id, info);
    }

    getUserById(user_id) {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/' + user_id);
    }

    getAllUsers() {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/allusers');
    }

    deleteUser(user_id) {
        return axios.delete('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/' + user_id);
    }
}

export default new UserService();
