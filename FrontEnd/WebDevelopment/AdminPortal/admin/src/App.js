import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ListAdminComponent from "./components/Admin/ListAdminComponent";
import ListContentManagementComponent from "./components/ContentManagement/ListContentManagementComponent";
import ListVendorComponent from "./components/Vendor/ListVendorComponent";
import ListStoreComponent from "./components/Store/ListStoreComponent";
import AddCategoryComponent from "./components/ContentManagement/AddCategoryComponent";
import AddProductComponent from "./components/ContentManagement/AddProductComponent";
import AddVendorComponent from "./components/Vendor/AddVendorComponent";
import EditCategoryComponent from "./components/ContentManagement/EditCategoryComponent";
import EditProductComponent from "./components/ContentManagement/EditProductComponent";
import EditVendorComponent from "./components/Vendor/EditVendorComponent";


function App() {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<ListAdminComponent />} />
                    <Route path="/content-management" element={<ListContentManagementComponent />} />
                    <Route path="/vendors" element={<ListVendorComponent />} />
                    <Route path="/stores" element={<ListStoreComponent />} />
                    <Route path="/edit-category/:product_category_id" element={<EditCategoryComponent />} />
                    <Route path="/edit-product/:product_id" element={<EditProductComponent />} />
                    <Route path="/edit-vendor/:vendor_id" element={<EditVendorComponent />} />
                    <Route path="/add-category" element={<AddCategoryComponent />} />
                    <Route path="/add-product" element={<AddProductComponent />} />
                    <Route path="/add-vendor" element={<AddVendorComponent />} />
                </Routes>
            </Router>
        </div>
    );
}

export default App;
