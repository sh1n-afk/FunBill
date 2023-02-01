import React from 'react';
import './RegistrationForm.css';

class RegistrationForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: '',
      username: '',
      birthdate: '',
      password: '',
      confirmPassword: ''
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    const name = event.target.name;
    const value = event.target.value;

    this.setState({
      [name]: value
    });
  }

  handleSubmit(event) {
    event.preventDefault();

    // Validate the form fields
    if (this.state.email === '') {
      alert('Please enter an email address.');
      return;
    }
    if (this.state.username === '') {
      alert('Please enter a username.');
      return;
    }
    if (this.state.birthdate === '') {
      alert('Please enter a birthdate.');
      return;
    }
    if (this.state.password === '') {
      alert('Please enter a password.');
      return;
    }
    if (this.state.password.length < 8){
      alert('Password must be at least 8 characters long')
      return;
    }
    if (this.state.password !== this.state.confirmPassword) {
      alert('The password and confirmation password do not match.');
      return;
    }
    

    // Submit the form
    alert(
      `Email Address: ${this.state.email}\nUsername: ${this.state.username}\nBirthdate: ${this.state.birthdate}\nPassword: ${this.state.password}`
    );
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
          <h1> Create an Account</h1>
          <br />
        <label>
          Email Address:
          <input
            name="email"
            type="email"
            value={this.state.email}
            onChange={this.handleChange}
          />
        </label>
        <br />
        <label>
          Username:
          <input
            name="username"
            type="text"
            value={this.state.username}
            onChange={this.handleChange}
          />
        </label>
        <br />
        <label>
          Birthdate: 
          <input
            name="birthdate"
            type="date"
            value={this.state.birthdate}
            onChange={this.handleChange}
          />
        </label>
        <br />
        <label>
          Password:
          <input
            name="password"
            type="password"
            value={this.state.password}
            onChange={this.handleChange}
            />
            </label>
            <br />
            <label>
          Confirm Password:
          <input
            name="confirmPassword"
            type="password"
            value={this.state.confirmPassword}
            onChange={this.handleChange}
          />
        </label>
        <br />
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

export default RegistrationForm;
