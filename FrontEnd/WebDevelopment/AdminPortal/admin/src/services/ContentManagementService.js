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

    updateProductCategory(categoryId, updatedName) {
        return axios.put(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/${categoryId}`, { category_name: updatedName });
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

    updateProduct(productId, productInfo) {
        return axios.put(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/${productId}`, productInfo);
    }
}

export default new ContentManagementService();
