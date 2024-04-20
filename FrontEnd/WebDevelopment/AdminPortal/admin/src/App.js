import './App.css';
import {BrowserRouter as Router, Route, Routes} from 'react-router-dom'
import ListAdminComponent from "./components/AdminManagement/ListAdminComponent";

function App() {
  return (
    <div className="App">
      <Router>
        <Routes>
          <Route path = "/" element = {<ListAdminComponent/>}></Route>
        </Routes>
      </Router>
    </div>
  );
}

export default App;
