import axios from 'axios';
import config from "../config";

class ProductService {

    addProduct(productInfo) {
        return axios.post(config.baseUrl + '/api/product/addproduct', productInfo);
    }

    getAllProducts() {
        return axios.get(config.baseUrl + '/api/product/allproducts');
    }

    getProductById(productId) {
        return axios.get(config.baseUrl + '/api/product/' + productId);
    }

    editProduct(productId, info) {
        return axios.put(config.baseUrl + `/api/product/` + productId, info);
    }

    deleteProduct(productId) {
        return axios.delete(config.baseUrl + `/api/product/` + productId);
    }

    getProductCount() {
        return axios.get(config.baseUrl + `/api/product/productcount`);
    }

}

export default new ProductService();
