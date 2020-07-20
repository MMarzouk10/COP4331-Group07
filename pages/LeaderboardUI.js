import React from 'react';
import { withStyles, makeStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';

const StyledTableCell = withStyles((theme) => ({
  head: {
    backgroundColor: 'black',
    color: theme.palette.common.white,
  },
  body: {
    fontSize: 14,
  },
}))(TableCell);

const StyledTableRow = withStyles((theme) => ({
  width: 300,
     root: {
    '&:nth-of-type(odd)': {
      backgroundColor: theme.palette.action.hover,
    },
  },
}))(TableRow);

function createData(Rank, User, Points) {
  return { Rank, User, Points };
}
var js = '{"numPlayers":0}';



const response = fetch(BASE_URL + 'api/leaderboard',

	{method:'POST', body:js, headers:{'Content-Type':'application/json}});



var txt = response.text();

var res = JSON.parse(txt);

var _results = res.results;



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

const useStyles = makeStyles({
  table: {
    minWidth: 300,
  },
});

export default function LeaderboardUI() {
  const classes = useStyles();

  return (
    <div id="leaderboardDiv" style={{width: '100%', height: '100%', backgroundImage: "linear-gradient(to bottom, #4A148C,#673AB7, #9C27B0)", position:'absolute'}}>
    <h2 >Ultra Trivia - Leaderboard</h2>
    <TableContainer component={Paper}>
      <Table className={classes.table} aria-label="customized table">
        <TableHead>
          <TableRow width= "50">
            <StyledTableCell align="center" >Rank</StyledTableCell>
            <StyledTableCell align="center" >User</StyledTableCell>
            <StyledTableCell align="center" >Score</StyledTableCell>
            
          </TableRow>
        </TableHead>
        <TableBody>
          {rows.map((row) => (
            <StyledTableRow key={row.name} width="50">
              
              <StyledTableCell align="center">{row.Rank}</StyledTableCell>
              <StyledTableCell align="center">{row.User}</StyledTableCell>
              <StyledTableCell align="center">{row.Points}</StyledTableCell>
            </StyledTableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
    </div>
  );
}