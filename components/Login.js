import React, { useState } from 'react';
import { CognitoUser, AuthenticationDetails } from "amazon-cognito-identity-js";
import UserPool from "../UserPool";

export default () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const onSubmit = event => {
    event.preventDefault();

    const user = new CognitoUser({
      Username: email,
      Pool: UserPool
    });
    const authDetails = new AuthenticationDetails({
      Username: email,
      Password: password
    });

    user.authenticateUser(authDetails, {
      onSuccess: data => {
        console.log("onSuccess:", data);
       
        window.location.href = '/cards';
      },

      onFailure: err => {
        console.error("onFailure:", err);
        //alert("Confirm email");
      },

      newPasswordRequired: data => {
        console.log("newPasswordRequired:", data);
      }
    });
  };
  const doSignup = async event => 
  {
      
              window.location.href = '/signup';
       
  };
  return (
    <div>
      <form onSubmit={onSubmit}>
        <input value={email} onChange={event => setEmail(event.target.value)} />

        <input
          value={password}
          onChange={event => setPassword(event.target.value)}
        />

        <button type="submit">Login</button>
        <input type="submit" id="loginButton" class="buttons" value = "Signup?"
          onClick={doSignup} />
      </form>
    </div>
  );
};
