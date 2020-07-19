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

export default function PageTitle() {
  const classes = useStyles();

  return (
    <div id="leaderDIV" style={{textAlign:'center', width: '100%', height: '100%', backgroundImage: "linear-gradient(to bottom, #4A148C,#673AB7, #9C27B0)", position:'absolute', left:'50%', top:'50%', transform: 'translate(-50%, -50%)', display: 'flex', alignItems:'center',justifyContent:'center'}}>
    <form style={{ width:700, justifyContent: 'center', alignItems: 'center'}}>
      <br />
    <button style={{backgroundColor:'lightblue', fontSize: 24, height: 40, width: '125px', float: 'right'}} type="button" id="logoutButton" class="buttons" 
           onClick={doLogout}> Log Out </button>
        <button style={{backgroundColor:'lightblue', fontSize: 24, height: 40, width: '125px'}} type="button" id="profilePage" class="buttons" 
          onClick={goProfile}> Profile </button>
        <button style={{backgroundColor:'lightblue', fontSize: 24, height: 40, width: '125px', float: 'left'}} type="button" id="faqPage" class="buttons" 
          onClick={faq}> FAQ </button>
    <h1 style={{color:'white', fontSize: 48}} >Ultra Trivia - Leaderboard</h1>
    <h4 style={{color:'white', fontSize: 24}} >Your High Score</h4>

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
              <StyledTableCell align="center">{row.x}</StyledTableCell>
              <StyledTableCell align="center">{row.Points}</StyledTableCell>
            </StyledTableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
    </form>
    </div>
  );
  
}


