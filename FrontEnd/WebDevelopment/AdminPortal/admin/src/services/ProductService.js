import axios from 'axios';

class ProductService {

    addProduct(productInfo) {
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/addproduct', productInfo);
    }

    getAllProducts() {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/allproducts');
    }

    editProduct(productId, productInfo) {
        return axios.put(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/${productId}`, productInfo);
    }

    deleteProduct(productId) {
        return axios.delete(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/${productId}`);
    }

}

export default new ProductService();