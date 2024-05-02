import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ListAdminComponent from "./components/Admin/ListAdminComponent";
import ListContentManagementComponent from "./components/ContentManagement/ListContentManagementComponent";
import Vendors from "./components/Admin/vendors";
import AddCategory from "./components/ContentManagement/AddCategory"; // Import AddCategory component

function App() {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<ListAdminComponent />} />
                    <Route path="/vendors" element={<Vendors />} />
                    <Route path="/contentManagement" element={<ListContentManagementComponent />} />
                    <Route path="/addCategory" element={<AddCategory />} /> {/* Add route for AddCategory component */}
                </Routes>
            </Router>
        </div>
    );
}

export default App;
