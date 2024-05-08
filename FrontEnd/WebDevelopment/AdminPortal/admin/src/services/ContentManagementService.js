import axios from 'axios';

class ContentManagementService {
    // Product Category API Methods
    addProductCategory(categoryInfo) {
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/addproductcategory', categoryInfo);
    }

    getAllProductCategories() {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/allproductcategories');
    }

    getProductCategoryById(categoryId) {
        return axios.get(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/${categoryId}`);
    }

    editProductCategory(categoryId, editedName) {
        return axios.put(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/` + categoryId , editedName);
    }

    deleteProductCategory(categoryId) {
        return axios.delete(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/${categoryId}`);
    }

    // Product API Methods
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

export default new ContentManagementService();
