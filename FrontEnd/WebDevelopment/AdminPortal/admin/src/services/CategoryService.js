import axios from 'axios';
import config from "../config";

class CategoryService {

    addCategory(categoryInfo) {
        return axios.post(config.baseUrl + '/api/product_category/addproductcategory', categoryInfo);
    }

    getAllCategories() {
        return axios.get(config.baseUrl + '/api/product_category/allproductcategories');
    }

    getCategoryById(categoryId) {
        return axios.get(config.baseUrl + '/api/product_category/' + categoryId);
    }

    editCategory(categoryId, info) {
        return axios.put(config.baseUrl + `/api/product_category/` + categoryId , info);
    }

    deleteCategory(categoryId) {
        return axios.delete(config.baseUrl + `/api/product_category/` + categoryId);
    }

    getCategoryCount() {
        return axios.get(config.baseUrl + `/api/product_category/productcategorycount`);
    }

}

export default new CategoryService();