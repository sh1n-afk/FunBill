import "./App.css";
import "./style.css";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";
import Header from "./components/Header";
import Footer from "./components/Footer";

// import styled component using Material UI
import Button from "@mui/material/Button";

function App() {
  return (
    <div class="main" id="layout">
      <Navbar />
      <Sidebar />
      <Header title="Groups Page" />

      <main id="group1">
        <a href="https://reactjs.org" target="_blank">
          Learn React
        </a>
        <Button variant="contained">Test Button</Button>
      </main>

      <Footer />
    </div>
  );
}

export default App;