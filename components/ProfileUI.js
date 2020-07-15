import React, { useState } from 'react';

function ProfileUI()
{
    

    const changePassword = async event => 
    {
	    

	};


    const changeEmail = async event => 
    {
        
    };

    const goHome = async event => 
    {
        window.location.href = '/cards';
    };



    return(
        <div id="profileUIDiv">
        <h1 id="title"> Profile Page </h1>
        <button type="button" id="homePage" class="buttons" 
          onClick={goHome}> Home </button><br />
        <br />
        <button type="button" id="changePassword" class="buttons" 
          onClick={changePassword}> Change Password </button><br />
        <br />
        <button type="button" id="changeEmail" class="buttons" 
          onClick={changeEmail}> Change Email </button><br />
      </div>
      
    );
}

export default ProfileUI;
