import React, { useState } from 'react';

function signup()
{
    var loginName;
    var loginPassword;
    var emailName;

   // const [message,setMessage] = useState('');

    const doSignup = async event => 

    
    {
        
        event.preventDefault();

        var js = '{"email":"'
                + emailName.value
                + '","login":"'
            + loginName.value
            + '","password":"'
            + loginPassword.value +'"}';

            try
        {    
            const response = await fetch('http://localhost:5000/api/signup',
                {method:'POST',body:js,headers:{'Content-Type': 'application/json'}});

            var res = JSON.parse(await response.text());
            
            if( res.id > 0 )
            {
                //setMessage('User already exists');
                alert("user exists already");
            }
            else
            {
                var user = {firstName:res.firstName,lastName:res.lastName,id:res.id}
                localStorage.setItem('user_data', JSON.stringify(user));

               // setMessage('');
                window.location.href = '/';
            }
        }
        catch(e)
        {
            alert(e.toString());
            return;
        }    
    };


    return(
      <div id="loginDiv">
        <form onSubmit={doSignup}>
        <span id="inner-title">PLEASE SIGN UP</span><br />
        <input type="text" id="emailName" placeholder="email" ref={(c) => emailName = c} /><br />
        <input type="text" id="loginName" placeholder="Username" ref={(c) => loginName = c} /><br />
        <input type="password" id="loginPassword" placeholder="Password" ref={(c) => loginPassword = c} /><br />
        <input type="submit" id="signupButton" class="buttons" value = "Sign Up"
          onClick={doSignup} />

        </form>
        
     </div>
    );
};

export default signup;