import React, { useState } from 'react';
import { CognitoUserPool } from 'amazon-cognito-identity-js';

const BASE_URL = 'https://mernstack-1.herokuapp.com/';

    export default () => {

      const [email, setEmail] = useState('');
      const [password, setPassword] = useState('');
    
      const poolData = {
        UserPoolId: 'us-east-2_qzkz9I4xL',
        ClientId: '2f4sc8c7580bo68jotflq4sr3l'
      };
    
      const UserPool = new CognitoUserPool(poolData);
    
      const onSubmit = event => {
        event.preventDefault();
    
        UserPool.signUp(email, password, [], null, (err, data) => {
          if (err) console.error(err);
          console.log(data);
        });

        var js = '{"email":"'+ email + '"}'; //saves email in a variable to send to API

        try
        {    
        const response = fetch(BASE_URL + 'api/signup',
            {method:'POST',body:js,headers:{'Content-Type': 'application/json'}});//API call
        }
        catch(e)
        {
            alert(e.toString());
            return;
        }  
      };
      
    return (
        <div>
          <form onSubmit={onSubmit}>
            <input
              value={email}
              onChange={event => setEmail(event.target.value)}
            />
    
            <input
              value={password}
              onChange={event => setPassword(event.target.value)}
            />
    
            <button type='submit'>Signup</button> 
          </form>
        </div>
      );
};
