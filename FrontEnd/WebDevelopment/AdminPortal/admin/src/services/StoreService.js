import axios from 'axios';

class StoreService {
    addStore(info) {
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/addstore', info);
    }

    updateStore(store_id, info) {
        return axios.put(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/${store_id}`, info);
    }

    getStoreById(store_id) {
        return axios.get(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/${store_id}`);
    }

    getAllStores() {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/allstores');
    }

    deleteStore(store_id) {
        return axios.delete(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/${store_id}`);
    }
}

export default new StoreService();
