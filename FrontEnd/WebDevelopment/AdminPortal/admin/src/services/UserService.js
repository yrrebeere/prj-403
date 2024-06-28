import axios from 'axios';
import config from "../config";

class UserService {

    addUser(info) {
        return axios.post(config.baseUrl + '/api/user_table/adduser', info);
    }

    editUser(user_id, info) {
        return axios.put(config.baseUrl + '/api/user_table/' + user_id, info);
    }

    getUserById(user_id) {
        return axios.get(config.baseUrl + '/api/user_table/' + user_id);
    }

    getAllUsers() {
        return axios.get(config.baseUrl + '/api/user_table/allusers');
    }

    deleteUser(user_id) {
        return axios.delete(config.baseUrl + '/api/user_table/' + user_id);
    }
}

export default new UserService();
