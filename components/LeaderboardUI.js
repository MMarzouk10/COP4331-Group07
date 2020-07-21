import React, { useState } from 'react';
import { CognitoUserPool } from 'amazon-cognito-identity-js';
import { withStyles, makeStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';
import { createChainedFunction } from '@material-ui/core';

const BASE_URL = 'https://mernstack-1.herokuapp.com/';

export default function LeaderboardUI() {

  const StyledTableCell = withStyles((theme) => ({
    head: {
      backgroundColor: '#FF69B4',
      color: 'theme.palette.common.white',
      fontWeight : 'bold',
    },
    body: {
      fontSize: 14,
    },
  }))(TableCell);

  const StyledTableRow = withStyles((theme) => ({
    width: 300,
      root: {
      '&:nth-of-type(odd)': {
        backgroundColor: 'lightpink',
      },
    },
  }))(TableRow);

  function createData(Rank, User, Points) {
    return { Rank, User, Points };
  }

  /*
  var js = '{"numPlayers":0}';

  const response = fetch(BASE_URL + 'api/leaderboard',
              {method:'POST',body:js,headers:{'Content-Type': 'application/json'}});

  var txt = response.text();
  var res = JSON.parse(txt);
  var _results = res.Results;

  const rows = [
    createData('1', _results[0].Email, _results[0].Points),
    createData('2', _results[1].Email, _results[1].Points),
    createData('3', _results[2].Email, _results[2].Points),
    createData('4', _results[3].Email, _results[3].Points),
    createData('5', _results[4].Email, _results[4].Points),
    createData('6', _results[5].Email, _results[5].Points),
    createData('7', _results[6].Email, _results[6].Points),
    createData('8', _results[7].Email, _results[7].Points),
    createData('9', _results[8].Email, _results[8].Points),
    createData('10', _results[9].Email, _results[9].Points)
    
  ];
 */

  const rows = [
    createData('1', 'mirettegamal965@gmail.com', '174'),
    createData('2', 'jertz@uswnt.com', '45'),
    createData('3', 'mfch98@gmail.com', '30'),
    createData('4', 'maxmc2234@gmail.com', '21'),
    createData('5', 'rockyrod@baonpdx', '17'),
    createData('6', 'mfch98@yahoo.com', '4'),
    createData('7', 'ptfc@baonpdx.com', '3'),
    createData('8', 'corella_m@knights.ucf.edu', '3'),
    createData('9', 'maxmc2234@knights.ucf.edu', '1'),
    createData('10', 'mfch98@hotmail.com', '1')
    
  ];

  const useStyles = makeStyles({
    table: {
      minWidth: 300,
    },
  });

  const doLogout = event => 
    {
      event.preventDefault();
    
      localStorage.removeItem("user_data")
      window.location.href = '/';
    }; 

    const goProfile = async event =>
      {
          window.location.href = '/profile';
    };

    const faq = async event =>
      {
          window.location.href = '/faq';
    };

    const classes = useStyles();

    return (
      <div id="leaderDIV" style={{textAlign:'center', width: '100%', height: '100%', backgroundImage: "linear-gradient(to bottom, #4A148C,#673AB7, #9C27B0)", position:'absolute', left:'50%', top:'50%', transform: 'translate(-50%, -50%)', display: 'flex', alignItems:'center',justifyContent:'center'}}>
      <form style={{ width:700, justifyContent: 'center', alignItems: 'center'}}>
        <br />
      <button style={{backgroundColor:'lightblue', fontSize: 24, height: 40, width: '125px', float: 'right'}} type="button" id="logoutButton" class="buttons" 
            onClick={doLogout}> Log Out </button>
          <button style={{backgroundColor:'lightblue', fontSize: 24, height: 40, width: '125px', float: 'left'}} type="button" id="faqPage" class="buttons" 
            onClick={faq}> FAQ </button>
      <h1 style={{color:'white', fontSize: 48}} >Ultra Trivia - Leaderboard</h1>
      <h4 style={{color:'white', fontSize: 24}} >Your High Score 0</h4>

      <TableContainer component={Paper}>
        <Table className={classes.table} aria-label="customized table">
          <TableHead>
            <TableRow >
              <StyledTableCell align="center" >Rank</StyledTableCell>
              <StyledTableCell align="center" >User</StyledTableCell>
              <StyledTableCell align="center" >Score</StyledTableCell>

            </TableRow>
          </TableHead>
          <TableBody>
            {rows.map((row) => (
              <StyledTableRow key={row.name} >

                <StyledTableCell align="center">{row.Rank}</StyledTableCell>
                <StyledTableCell align="center">{row.User}</StyledTableCell>
                <StyledTableCell align="center">{row.Points}</StyledTableCell>
              </StyledTableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      </form>
      </div>
    );
    
};
