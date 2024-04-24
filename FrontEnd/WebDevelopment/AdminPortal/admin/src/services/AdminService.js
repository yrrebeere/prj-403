import axios from 'axios'

class AdminService {

    addAdmin(info){
        return axios.post('http://localhost:4000/api/admin/addadmin', info);
    }

    updateAdmin(admin_id, info){
        return axios.put('http://localhost:4000/api/admin/' + admin_id, info);
    }

    getAdminById(admin_id){
        return axios.get('http://localhost:4000/api/admin/' + admin_id);
    }

    getAllAdmins(){
        return axios.get('http://localhost:4000/api/admin/alladmins');
    }

    deleteAdmin(admin_id){
        return axios.delete('http://localhost:4000/api/admin/' + admin_id);
    }
}

export default new AdminService();

