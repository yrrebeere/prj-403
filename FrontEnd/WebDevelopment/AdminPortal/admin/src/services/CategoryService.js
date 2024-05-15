import axios from 'axios';

class CategoryService {

    addCategory(categoryInfo) {
        return axios.post('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/addproductcategory', categoryInfo);
    }

    getAllCategories() {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/allproductcategories');
    }

    getCategoryById(categoryId) {
        return axios.get('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/' + categoryId);
    }

    editCategory(categoryId, info) {
        return axios.put(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/` + categoryId , info);
    }

    deleteCategory(categoryId) {
        return axios.delete(`https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/` + categoryId);
    }

}

export default new CategoryService();