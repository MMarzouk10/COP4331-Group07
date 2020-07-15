const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

/////////////////////////////////////////
// Added for Heroku deployment.
const path = require('path');
const PORT = process.env.PORT || 5000;
require('dotenv').config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

/////////////////////////////////////////
// Added for Heroku deployment.
app.set('port', (process.env.PORT || 5000));

const MongoClient = require('mongodb').MongoClient;

//const url = 'mongodb+srv://RickLeinecker:COP4331Rocks@cluster0-4pisv.mongodb.net/COP4331?retryWrites=true&w=majority';
// Changed for Heroku deployment.
//const url = process.env.MONGODB_URI;
const url = 'mongodb+srv://cardsuser:cop4331@cluster0.0mbkf.mongodb.net/COP4331?retryWrites=true&w=majority';

console.log( "url:" + url );

const client = new MongoClient(url);

console.log( "client:" + client );

client.connect();

console.log("After connect");

///////////////////////////////////////////////////
// For Heroku deployment
//if( process.env.NODE_ENV == 'production')
//{

///////////////////////////////////////////////////
// For Heroku deployment
app.use(express.static(path.join(__dirname, 'frontend', 'build')));

console.log("After app.use()");

///////////////////////////////////////////////////
// For Heroku deployment
app.get('*', (req, res) => 
{
  res.sendFile(path.join(__dirname, 'frontend', 'build', 'index.html'))
});

app.post('/api/addcard', async (req, res, next) =>
{
  // incoming: userId, card
  // outgoing: error

  const { userId, card } = req.body;

  const newCard = {Card:card,UserId:userId};
  var error = '';

  try
  {
    const db = client.db();
    const result = db.collection('cards').insertOne(newCard);
  }
  catch(e)
  {
    error = e.toString();
  }

  var ret = { error: error };
  res.status(200).json(ret);
});

app.post('/api/signup', async (req, res, next) =>
{
  // incoming: login, email, password
  // outgoing: error

  var error = '';

  const {login, email, password} = req.body;

  const newUser = {Login:login,Email:email,Password:password, Flag:false, Points:0};

  try
  {
    const db = client.db();
    const result = db.collection('users').insertOne(newUser);
  }
  catch(e)
  {
    error = e.toString();
  }

  var ret = {error:error};
  res.status(200).json(ret);
});

app.post('/api/forgotpassword', async (req, res, next) =>
{
  //incoming: email
  //outgoing: confirmation

  var error = '';

  const{email} = req.body;

//SEND EMAIL LINK TO RESET PASSWORD
})

app.post('/api/login', async (req, res, next) => 
{
  // incoming: login, password
  // outgoing: id, error

  var error = '';

  const { login, password } = req.body;

  const db = client.db();
  const results = await db.collection('users').find({Login:login,Password:password}).toArray();

  var id = -1;
  var loginName = '';

  if( results.length > 0 )
  {
    id = results[0]._id;
    loginName = results[0].Login;
  }
  else
  {
    error = 'Invalid user name/password';
  }

  var ret = {login:loginName, id: id, error:error};
  res.status(200).json(ret);
});

app.post('/api/searchcards', async (req, res, next) => 
{
  // incoming: userId, search
  // outgoing: results[], error

  var error = '';

  const { userId, search } = req.body;

  var _search = search.trim();
  
  const db = client.db();
  const results = await db.collection('cards').find({"Card":{$regex:_search+'.*', $options:'r'}, UserId:userId}).toArray();
  
  var _ret = [];
  for( var i=0; i<results.length; i++ )
  {
    _ret.push( results[i].Card );
  }

  var ret = {results:_ret, error:''};
  res.status(200).json(ret);
});

app.post('/api/changelogin', async (req, res, next) =>
{
  // incoming: userId, newlogin
  // outgoing: error

  var error = '';

  const {userId, newLogin} = req.body; //Get user and new login from body

  const db = client.db(); //set client for db
  //const result = await db.collection('users').find({UserId:userId}); //find the user

  try
  {
    db.collection('users').update({_id: userId}, {$set: {Login:newLogin}}); //update the login field
  }
  catch(e)
  {
    error = e.toString();
  }

  var ret = {userId: userId, error: error};
  res.status(200).json(ret);
});

app.post('/api/changepassword', async (req, res, next) =>
{
  // incoming: userId, newPassword, oldPassword
  // outgoing: error

  var error = '';

  const {userId, newPassword, oldPassword} = req.body;//Get userId, old password, and new password login from body

  const db = client.db();//set client db

  try{
    db.collection('users').update({_id:userId, Password:oldPassword }, {$set: {Password: newPassword}}); //update the password field
  }
  catch(e){
    error = e.toString();
  }

  var ret = {error: error};
  res.status(200).json(ret);
});

app.post('/api/changemail', async (req, res, next) =>
{
  // incoming: userId, newEmail
  // outgoing: error

  var error = '';

  const {userId, newEmail} = req.body;//Get user and new password login from body

  const db = client.db();//set client db

  try{
    db.collection('users').update({_id: userId}, {$set: {Email: newEmail}}); //update the password field
  }
  catch(e){
    error = e.toString();
  }

  var ret = {error: error};
  res.status(200).json(ret);
});

app.use((req, res, next) => 
{
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  );
  res.setHeader(
    'Access-Control-Allow-Methods',
    'GET, POST, PATCH, DELETE, OPTIONS'
  );
  next();
});
//}

// change dfor Heroku deployment
//app.listen(5000); // start Node + Express server on port 5000
app.listen(PORT, () => 
{
  console.log('Server listening on port ${PORT}.');
});
