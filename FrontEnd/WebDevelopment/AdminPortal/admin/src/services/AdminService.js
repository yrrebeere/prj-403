import axios from 'axios'

class AdminService {

    addAdmin(info){
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/admin/addadmin', info);
    }

    updateAdmin(admin_id, info){
        return axios.put('https://sea-lion-app-wbl8m.ondigitalocean.app/api/admin/' + admin_id, info);
    }

    getAdminById(admin_id){
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/admin/' + admin_id);
    }

    getAllAdmins(){
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/admin/alladmins');
    }

    deleteAdmin(admin_id){
        return axios.delete('https://sea-lion-app-wbl8m.ondigitalocean.app/api/admin/' + admin_id);
    }
}

export default new AdminService();

