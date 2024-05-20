import axios from 'axios';

class VendorService {

    addVendor(info){
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/addvendor', info);
    }

    editVendor(vendor_id, info){
        return axios.put('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/' + vendor_id, info);
    }

    getVendorById(vendor_id){
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/' + vendor_id);
    }

    getAllVendors(){
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/allvendors');
    }

    deleteVendor(vendor_id){
        return axios.delete('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/' + vendor_id);
    }

    getVendorCount() {
        return axios.get(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/vendorcount`);
    }
}

export default new VendorService();
