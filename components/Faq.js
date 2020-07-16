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
    backgroundColor: theme.palette.common.black,
    color: theme.palette.common.white,
  },
  body: {
    fontSize: 14,
  },
}))(TableCell);

const StyledTableRow = withStyles((theme) => ({
  width: 700,
     root: {
    '&:nth-of-type(odd)': {
      backgroundColor: theme.palette.action.hover,
    },
  },
}))(TableRow);

function createData(Questions, Answers) {
  return { Questions, Answers };
}

const rows = [
  createData('How to download mobile app?', 'click on the following link:... Or go to Google Play and search for Ultra Trivia'),
  createData('How to play game?', 'Open mobile once logging in and select a category for the trivia'),
  createData('How does the interaction between the website and mobile app work?', 'The mobile app is the trivia section, web app is to add friends, update settings and check leaderboards'),
  createData('How can I reset password?', 'The web app has that option at the following page:...'),
  createData('How can I add a friend', 'Once logging in, there will be an option at the top of the home page allowing user to add friend'),
];

const useStyles = makeStyles({
  table: {
    minWidth: 500,
  },
});

export default function PageTitle() {
  const classes = useStyles();

  return (
    <TableContainer component={Paper}>
      <Table className={classes.table} aria-label="customized table">
        <TableHead>
          <TableRow width= "700">
            <StyledTableCell align="center" >Questions</StyledTableCell>
            <StyledTableCell align="center" >Answers</StyledTableCell>
            
          </TableRow>
        </TableHead>
        <TableBody>
          {rows.map((row) => (
            <StyledTableRow key={row.name} width="700">
              <StyledTableCell component="th" scope="row">
                {row.name}
              </StyledTableCell>
              <StyledTableCell align="center">{row.Questions}</StyledTableCell>
              <StyledTableCell align="center">{row.Answers}</StyledTableCell>
              
            </StyledTableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
  
}



