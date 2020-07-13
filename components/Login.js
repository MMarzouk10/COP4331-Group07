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

    return(
      <div id="loginDiv">
        <form onSubmit={doLogin}>
        <span id="inner-title">PLEASE LOG IN</span><br />
        <input type="text" id="loginName" placeholder="Username" ref={(c) => loginName = c} /><br />
        <input type="password" id="loginPassword" placeholder="Password" ref={(c) => loginPassword = c} /><br />
        <input type="submit" id="loginButton" class="buttons" value = "Do It"
          onClick={doLogin} />
          <input type="submit" id="loginButton" class="buttons" value = "Signup?"
          onClick={doSignup} />
        </form>
        <span id="loginResult">{message}</span>
     </div>
    );
};

export default Login;
