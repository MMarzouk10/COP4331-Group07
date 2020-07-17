import React, { useState } from 'react';
const BASE_URL = 'https://mernstack-1.herokuapp.com/';
function CardUI()
{
    var card = '';
    var search = '';
    var user={}

    const [message,setMessage] = useState('');
    const [searchResults,setResults] = useState('');
    const [cardList,setCardList] = useState('');

    var _ud = localStorage.getItem('user_data');
    var ud = JSON.parse(_ud);
    var userId = ud.id;
    var firstName = ud.firstName;
    var lastName = ud.lastName;



    const addCard = async event => 
    {
	    event.preventDefault();

        var js = '{"userId":"'+userId+'","card":"'+card.value+'"}';

        try
        {
        	const response = await fetch(BASE_URL + 'api/addcard',
           // const response = await fetch('http://localhost:5000/api/addcard',
            {method:'POST',body:js,headers:{'Content-Type': 'application/json'}});

            var txt = await response.text();
            var res = JSON.parse(txt);

            if( res.error.length > 0 )
            {
                setMessage( "API Error:" + res.error );
            }
            else
            {
                setMessage('Card has been added');
            }
        }
        catch(e)
        {
            setMessage(e.toString());
        }

	};


    const searchCard = async event => 
    {
        event.preventDefault();
        	
        var js = '{"userId":"'+userId+'","search":"'+search.value+'"}';

        try
        {
            //const response = await fetch('http://localhost:5000/api/searchcards',
            const response = await fetch(BASE_URL + 'api/searchcards',
            {method:'POST',body:js,headers:{'Content-Type': 'application/json'}});

            var txt = await response.text();
            var res = JSON.parse(txt);
            var _results = res.results;
            var resultText = '';
            for( var i=0; i<_results.length; i++ )
            {
                resultText += _results[i];
                if( i < _results.length - 1 )
                {
                    resultText += ', ';
                }
            }
            setResults('Card(s) have been retrieved');
            setCardList(resultText);
        }
        catch(e)
        {
            alert(e.toString());
            setResults(e.toString());
        }
    };

    const goProfile = async event => 
    {
        window.location.href = '/profile';
    };

	  const faq = async event => 
    {
        window.location.href = '/faq';
    };

    const doLogout = event => 
    {
	    event.preventDefault();
		
        alert('doLogout');
    }; 

    return(
        <div id="cardUIDiv" style={{width: '100%', height: '100%', backgroundColor:'purple', position:'absolute'}}>
        <h1 style={{color:'white'}}>WELCOME user</h1>
        <span id="userName">Logged In As John Doe </span><br />
        <button style={{backgroundColor:'lightblue', width: '135px'}} type="button" id="logoutButton" class="buttons" 
           onClick={doLogout}> Log Out </button>
        <button style={{backgroundColor:'lightblue', width: '135px'}} type="button" id="profilePage" class="buttons" 
          onClick={goProfile}> Profile </button>
        <button style={{backgroundColor:'lightblue', width: '135px'}} type="button" id="faqPage" class="buttons" 
          onClick={faq}> FAQ </button><br />
        <input type="text" id="searchText" placeholder="Card To Search For" 
          ref={(c) => search = c} />
        <button style={{backgroundColor:'lightblue', width: '135px'}} type="button" id="searchCardButton" class="buttons" 
          onClick={searchCard}> Search Card</button>
        <span id="cardSearchResult">{searchResults}</span>
        <p id="cardList">{cardList}</p><br />
        <input type="text" id="cardText" placeholder="Card To Add" 
          ref={(c) => card = c} />
        <button style={{backgroundColor:'lightblue', width: '135px'}} type="button" id="addCardButton" class="buttons" 
          onClick={addCard}> Add Card </button>
        <span id="cardAddResult">{message}</span>
      </div>
      
    );
}

export default CardUI;
