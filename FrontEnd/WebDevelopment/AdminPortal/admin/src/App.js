import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ListAdminComponent from "./components/Admin/ListAdminComponent";
import ListContentManagementComponent from "./components/ContentManagement/ListContentManagementComponent";
import AddCategory from "./components/ContentManagement/AddCategory";
import AddProduct from "./components/ContentManagement/AddProduct";


function App() {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<ListAdminComponent />} />
                    <Route path="/contentManagement" element={<ListContentManagementComponent />} />
                    <Route path="/addCategory" element={<AddCategory />} /> {/* Add route for AddCategory component */}
                    <Route path="/addProduct" element={<AddProduct />} /> {/* Add route for AddProduct component */}
                </Routes>
            </Router>
        </div>
    );
}

export default App;
