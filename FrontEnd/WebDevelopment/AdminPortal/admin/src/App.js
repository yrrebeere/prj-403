import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ListAdminComponent from "./components/Admin/ListAdminComponent";
import ListContentManagementComponent from "./components/ContentManagement/ListContentManagementComponent";
import ListVendorComponent from "./components/Vendor/ListVendorComponent";
import ListStoreComponent from "./components/Store/ListStoreComponent";
import AddCategory from "./components/ContentManagement/AddCategory";
import AddProduct from "./components/ContentManagement/AddProduct";
import AddVendor from "./components/Vendor/AddVendor";
import EditCategoryComponent from "./components/ContentManagement/EditCategoryComponent";
import EditProductComponent from "./components/ContentManagement/EditProductComponent";


function App() {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<ListAdminComponent />} />
                    <Route path="/content-management" element={<ListContentManagementComponent />} />
                    <Route path="/vendors" element={<ListVendorComponent />} />
                    <Route path="/stores" element={<ListStoreComponent />} />
                    <Route path="/update-category/:product_category_id" element={<EditCategoryComponent />} />
                    <Route path="/update-product" element={<EditProductComponent />} />
                    <Route path="/add-category" element={<AddCategory />} />
                    <Route path="/add-product" element={<AddProduct />} />
                    <Route path="/add-vendor" element={<AddVendor />} />
                </Routes>
            </Router>
        </div>
    );
}

export default App;
