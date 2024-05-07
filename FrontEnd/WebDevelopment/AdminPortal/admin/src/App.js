import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ListAdminComponent from "./components/Admin/ListAdminComponent";
import ListContentManagementComponent from "./components/ContentManagement/ListContentManagementComponent";
import ListVendorComponent from "./components/Vendor/ListVendorComponent";
import AddCategory from "./components/ContentManagement/AddCategory";
import AddProduct from "./components/ContentManagement/AddProduct";
import UpdateCategoryComponent from "./components/ContentManagement/UpdateCategoryComponent";
import UpdateProductComponent from "./components/ContentManagement/UpdateProductComponent";


function App() {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<ListAdminComponent />} />
                    <Route path="/content-management" element={<ListContentManagementComponent />} />
                    <Route path="/vendors" element={<ListVendorComponent />} />
                    <Route path="/update-category/:product_category_id" element={<UpdateCategoryComponent />} />
                    <Route path="/update-product" element={<UpdateProductComponent />} />
                    <Route path="/add-category" element={<AddCategory />} />
                    <Route path="/add-product" element={<AddProduct />} />
                </Routes>
            </Router>
        </div>
    );
}

export default App;
