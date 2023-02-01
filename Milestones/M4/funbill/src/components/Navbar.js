import React from "react";

const Navbar = () => {
  return (
    <nav class="navbar" id="nav">
      <div>
        <h1>
          <a href="#">FUNBILL</a>
        </h1>
      </div>
      <div>
        <a href="about.html">About</a>
      </div>
      <div>
        <input
          type="text"
          placeholder="Search transactions, users, expenses, categories, etc."
        ></input>
      </div>
      <div>
        <a href="index.html">Sign Out</a>
      </div>
    </nav>
  );
};

export default Navbar;
