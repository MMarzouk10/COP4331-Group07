import React, { useState } from 'react';

const BASE_URL = 'https://mernstack-1.herokuapp.com/';
//FOR LOCAL TESTING USE LOCALHOST URL
//const BASE_URL = 'http://localhost:5000/';

function Login()
{
    var loginName;
    var loginPassword;

    const [message,setMessage] = useState('');

    const doLogin = async event => 
    {
        event.preventDefault();

        var js = '{"login":"'
            + loginName.value
            + '","password":"'
            + loginPassword.value +'"}';

        try
        {    
            const response = await fetch(BASE_URL + 'api/login',
                {method:'POST',body:js,headers:{'Content-Type': 'application/json'}});

            var res = JSON.parse(await response.text());

            if( res.id <= 0 )
            {
                setMessage('User/Password combination incorrect');
            }
            else
            {
                var user = {firstName:res.firstName,lastName:res.lastName,id:res.id}
                localStorage.setItem('user_data', JSON.stringify(user));

                setMessage('');
                window.location.href = '/cards';
            }
        }
        catch(e)
        {
            alert(e.toString());
            return;
        }    
    };

    const doSignup = async event => 
    {
        
                window.location.href = '/signup';
         
    };
    const changePassword = async event => 
    {
        
                window.location.href = '/recovery';
         
    };

    return(
      <div id="loginDiv" style={{textAlign:'center', width: '100%', height: '100%', backgroundImage: "linear-gradient(to bottom, #4A148C,#673AB7, #9C27B0)", position:'absolute', left:'50%', top:'50%', transform: 'translate(-50%, -50%)', display: 'flex', alignItems:'center',justifyContent:'center'}}>
      <form onSubmit={doLogin}>
      <h1 style={{color:'white'}}>WELCOME TO ULTRA TRIVIA</h1>
      <span style={{color:'gray'}} id="inner-title"  >PLEASE LOG IN</span><br />
      <input style={{width: '250px',justifyContent: 'center', alignItems: 'center'}} type="text" id="loginName" placeholder="Username" ref={(c) => loginName = c} /><br />
      <input style={{width:'250px'}} type="password" id="loginPassword" placeholder="Password" ref={(c) => loginPassword = c} /><br />
      <input style={{backgroundColor:'lightblue', width: '135px'}} type="submit" id="loginButton" class="buttons" value = "Login"
          onClick={doLogin} />
      <input style={{backgroundColor:'lightblue', width: '135px'}} type="submit" id="loginButton" class="buttons" value = "Signup"
          onClick={doSignup} />
      <br />
      <input style={{width: '270px',justifyContent: 'center', alignItems: 'center', backgroundColor: 'lightblue'}} type="submit" id="forgotPasswordButton" class="buttons" value = "Forgot Password?"
          onClick={changePassword} />
      </form>
      <span id="loginResult">{message}</span>
     </div>
    );
};

export default Login;
