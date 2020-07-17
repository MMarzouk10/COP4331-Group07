import React, { useState } from 'react';

function ProfileUI()
{
  var email;
  var password;

    const changePassword = async event => 
    {
	    

	  };


    const goHome = async event => 
    {
        window.location.href = '/cards';
    };



    return(
        <div id="profileUIDiv" style={{width: '100%', height: '100%', backgroundColor:'purple', position:'absolute'}} >
        <h1 id="title"> Profile Page </h1>
        <button style={{backgroundColor:'lightblue', width: '135px'}} type="button" id="homePage" class="buttons" 
          onClick={goHome}> Home </button><br />
        <br />
        <input type="password" id="loginPassword" placeholder="Password" ref={(c) => password = c} /><br />
        <button style={{backgroundColor:'lightblue', width: '135px'}} type="button" id="changePassword" class="buttons" 
          onClick={changePassword}> Change Password </button><br />
        <br />
      </div>
      
    );
}

export default ProfileUI;
