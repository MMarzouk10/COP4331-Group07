import React from 'react';
import { BrowserRouter as Router, Route, Redirect, Switch } from 'react-router-dom';
import './App.css';

import LoginPage from './pages/LoginPage';
import SignupPage from './pages/SignupPage';
import CardPage from './pages/CardPage';
import ProfilePage from './pages/ProfilePage';
import FaqPage from './pages/FaqPage';
import RecoveryPage from './pages/RecoveryPage';
import LeaderboardPage from './pages/LeaderboardPage'

function App() {
  return (
    <Router >
      <Switch>
        <Route path="/" exact>
          <LoginPage />
        </Route>
        <Route path="/signup" exact>
          <SignupPage />
        </Route>
        <Route path="/cards" exact>
          <CardPage />
        </Route>
        <Route path="/profile" exact>
          <ProfilePage />
        </Route>
        <Route path="/recovery" exact>
          <RecoveryPage />
        </Route>
        <Route path="/leaderboard" exact>
          <LeaderboardPage />
        </Route>
        <Route path="/faq" exact>
          <FaqPage />
        </Route>
        <Redirect to="/" />
      </Switch>  
    </Router>
  );
}

export default App;
