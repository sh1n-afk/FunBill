import React from "react";

const Header = (props) => {
  const { title } = props;
  return (
    <header id="header">
      <div>
        <h1>{title}</h1>
      </div>
    </header>
  );
};

export default Header;
