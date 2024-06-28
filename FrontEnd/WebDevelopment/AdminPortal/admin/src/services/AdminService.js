import axios from 'axios'
import config from "../config";

class AdminService {

    addAdmin(info){
        return axios.post(config.baseUrl + '/api/admin/addadmin', info);
    }

    editAdmin(admin_id, info){
        return axios.put(config.baseUrl + '/api/admin/' + admin_id, info);
    }

    getAdminById(admin_id){
        return axios.get(config.baseUrl + '/api/admin/' + admin_id);
    }

    getAllAdmins(){
        return axios.get(config.baseUrl + '/api/admin/alladmins');
    }

    deleteAdmin(admin_id){
        return axios.delete(config.baseUrl + '/api/admin/' + admin_id);
    }
}

export default new AdminService();

