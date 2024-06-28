import axios from 'axios';
import config from "../config";

class StoreService {
    addStore(info) {
        return axios.post(config.baseUrl + '/api/grocery_store/addstore', info);
    }

    editStore(store_id, info) {
        return axios.put(config.baseUrl + `/api/grocery_store/${store_id}`, info);
    }

    getStoreById(store_id) {
        return axios.get(config.baseUrl + `/api/grocery_store/${store_id}`);
    }

    getAllStores() {
        return axios.get(config.baseUrl + '/api/grocery_store/allstores');
    }

    deleteStore(store_id) {
        return axios.delete(config.baseUrl + `/api/grocery_store/${store_id}`);
    }

    getStoreCount() {
        return axios.get(config.baseUrl + `/api/grocery_store/grocerystorecount`);
    }
}

export default new StoreService();
