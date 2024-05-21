import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ListAdminComponent from "./components/Admin/ListAdminComponent";
import ListVendorComponent from "./components/Vendor/ListVendorComponent";
import ListStoreComponent from "./components/Store/ListStoreComponent";
import AddCategoryComponent from "./components/CategoryManagement/AddCategoryComponent";
import ListProductComponent from "./components/ProductManagement/ListProductComponent";
import AddProductComponent from "./components/ProductManagement/AddProductComponent";
import AddAdminComponent from "./components/Admin/AddAdminComponent";
import EditCategoryComponent from "./components/CategoryManagement/EditCategoryComponent";
import EditProductComponent from "./components/ProductManagement/EditProductComponent";
import EditAdminComponent from "./components/Admin/EditAdminComponent";
import ListCategoryComponent from "./components/CategoryManagement/ListCategoryComponent";
import EditStoreComponent from "./components/Store/EditStoreComponent";
import ListAnalyticsComponent from "./components/Analytics/ListAnalyticsComponent";

function App() {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<ListAdminComponent />} />
                    <Route path="/categories" element={<ListCategoryComponent />} />
                    <Route path="/analytics" element={<ListAnalyticsComponent />} />
                    <Route path="/products" element={<ListProductComponent />} />
                    <Route path="/vendors" element={<ListVendorComponent />} />
                    <Route path="/stores" element={<ListStoreComponent />} />
                    <Route path="/admins" element={<ListAdminComponent />} />
                    <Route path="/edit-category/:product_category_id" element={<EditCategoryComponent />} />
                    <Route path="/edit-product/:product_id" element={<EditProductComponent />} />
                    <Route path="/edit-admin/:admin_id" element={<EditAdminComponent />} />
                    <Route path="/add-category" element={<AddCategoryComponent />} />
                    <Route path="/add-product" element={<AddProductComponent />} />
                    <Route path="/add-admin" element={<AddAdminComponent />} />
                    <Route path="/edit-store/:store_id" element={<EditStoreComponent />} />
                </Routes>
            </Router>
        </div>
    );
}

export default App;
