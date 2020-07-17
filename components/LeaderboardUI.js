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
    backgroundColor: 'purple',
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

const rows = [
  createData('1', 'Angelina Jolie', '10.0'),
  createData('2', 'Beyonce', '9.2'),
  createData('3', 'Rihanna', '8.7'),
  createData('4', 'Tupac', '7.1'),
  createData('5', 'Aaron Rodger', '7.0'),
  createData('6', 'Daniel Biller', '6.5'),
  createData('7', 'Jack Sparrow', '6.3'),
  createData('8', 'Tom Brady', '6.1'),
  createData('9', 'The Rock', '5.7'),
  createData('10', 'Spongebob', '0.1')
  
];

const useStyles = makeStyles({
  table: {
    minWidth: 300,
  },
});

export default function PageTitle() {
  const classes = useStyles();

  return (
    <div >
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



