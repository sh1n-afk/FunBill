import "./style.css";
import Navbar from "./components/Navbar";
import Sidebar from "./components/Sidebar";
import Header from "./components/Header";
import Footer from "./components/Footer";

// import styled component using Material UI
import Button from "@mui/material/Button";

function PageName() {
  return (
    <div class="main" id="layout">
      <Navbar />
      <Sidebar />
      <Header title="Set page's header here e.g. Groups Page" />
      <main id="group1">
        <h1>Main content area is here!</h1>
        <Button variant="text">Test Button</Button>
      </main>
      <Footer />
    </div>
  );
}
