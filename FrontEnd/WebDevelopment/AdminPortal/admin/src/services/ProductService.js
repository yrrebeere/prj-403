import axios from 'axios';

class ProductService {

    addProduct(productInfo) {
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/addproduct', productInfo);
    }

    getAllProducts() {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/allproducts');
    }

    getProductById(productId) {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/' + productId);
    }

    editProduct(productId, info) {
        return axios.put(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/` + productId, info);
    }

    deleteProduct(productId) {
        return axios.delete(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/` + productId);
    }

    getProductCount() {
        return axios.get(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/productcount`);
    }

}

export default new ProductService();
