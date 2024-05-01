import './App.css';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ListAdminComponent from "./components/Admin/ListAdminComponent";
import ListContentManagementComponent from "./components/ContentManagement/ListContentManagementComponent"; // Import ListContentManagementComponent
import Vendors from "./components/Admin/vendors";

function App() {
    return (
        <div className="App">
            <Router>
                <Routes>
                    <Route path="/" element={<ListAdminComponent />} />
                    <Route path="/vendors" element={<Vendors />} />
                    <Route path="/contentManagement" element={<ListContentManagementComponent />} /> {/* Add route for ListContentManagementComponent */}
                </Routes>
            </Router>
        </div>
    );
}

export default App;
