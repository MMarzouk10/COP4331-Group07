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
  width: 700,
     root: {
    '&:nth-of-type(odd)': {
      backgroundColor: 'lightpink',
    },
  },
}))(TableRow);

function createData(Questions, Answers) {
  return { Questions, Answers };
}

const rows = [
  createData('How to download mobile app?', 'Click on the following link:... Or go to Google Play and search for Ultra Trivia'),
  createData('How do I play the game?', 'Open the mobile app and once logging in select a category for the trivia'),
  createData('How does the interaction between the website and mobile app work?', 'The mobile app is the trivia section, web app is to reset password, view faq, and check leaderboards'),
  createData('How can I reset password?', 'The web app has that option at the following page:...'),
  createData('Can I view my high score?', 'Yes, click on leaderboards on the home page to view your score against top players'),
];

const useStyles = makeStyles({
  table: {
    minWidth: 500,
  },
});

const goHome = async event => 
    {
        window.location.href = '/home';
    };

export default function PageTitle() {
  const classes = useStyles();

  return (
    <div id="faqDiv" style={{textAlign:'center', width: '100%', height: '100%', backgroundImage: "linear-gradient(to bottom, #4A148C,#673AB7, #9C27B0)", position:'absolute', left:'50%', top:'50%', transform: 'translate(-50%, -50%)', display: 'flex', alignItems:'center',justifyContent:'center'}}>
    
    <form style={{ width:700, justifyContent: 'center', alignItems: 'center'}}>
    <h1 style={{color:'white', fontSize: 48}}>FAQ</h1>
     <br />
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
              <StyledTableCell align="center">{row.Questions}</StyledTableCell>
              <StyledTableCell align="center">{row.Answers}</StyledTableCell>
              
            </StyledTableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
    <br />
    <button style={{backgroundColor:'lightblue', fontSize: 24, height: 40, width: '250px', justifyContent: 'center', alignItems: 'center'}} type="button" id="faqPage" class="buttons" 
          onClick={goHome}> Home </button><br />
    </form>
    </div>
  );
  
}


