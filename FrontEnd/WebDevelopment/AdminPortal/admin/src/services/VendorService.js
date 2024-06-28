import axios from 'axios';
import config from "../config";

class VendorService {

    addVendor(info){
        return axios.post(config.baseUrl + '/api/vendor/addvendor', info);
    }

    editVendor(vendor_id, info){
        return axios.put(config.baseUrl + '/api/vendor/' + vendor_id, info);
    }

    getVendorById(vendor_id){
        return axios.get(config.baseUrl + '/api/vendor/' + vendor_id);
    }

    getAllVendors(){
        return axios.get(config.baseUrl + '/api/vendor/allvendors');
    }

    deleteVendor(vendor_id){
        return axios.delete(config.baseUrl + '/api/vendor/' + vendor_id);
    }

    getVendorCount() {
        return axios.get(config.baseUrl + `/api/vendor/vendorcount`);
    }
}

export default new VendorService();
