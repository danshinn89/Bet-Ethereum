pragma solidity >=0.5.16;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";


contract Bet  {
    
    address payable public owner;
    uint pot;
    uint minimumBet;
    uint SetWinner = 0;
    
    
    struct Payment{
        
        uint amount;
        uint timestamp;
      
    }
    
    struct Player  {
        
        uint entry;
        uint amountBet; 
        uint numPayments;
        bool teamA;
        bool teamB;
        bool collect;
        mapping(uint => Payment) payments; // maps the payments to unassigned integers . a counter
     
    }
    

    mapping (address => Player ) public playerBet; //mapping adddress to the (struct)balance)
    
    
    event PaymentSent(address _from, uint _amount);
    event CheckWinner(uint _winner);
    event CheckBool(bool _team);
    
     constructor() public {
      
      owner = msg.sender;
      minimumBet = 2000000000000000000;
      pot = 2000000000000000000;
      
   
    }    

   
   
   function betPlayerOne() public payable {
    //minimum required amount to enter  
    require(msg.value >= minimumBet, "Minimum Tokens Required = 2");
    require(SetWinner == 0, "Sorry you missed this one");
    //takes how much the player has bet and sets it to their msg.value
    playerBet[msg.sender].amountBet += msg.value; // .tatalbalance(access struct values)
    playerBet[msg.sender].entry = 1;
   
    //records memory of payment made and timestamp
    Payment memory payment = Payment(msg.value,now); //creating a new payment (stored in memory, msg.value amount sent / not --> gives current timestamp / Type payment created)
    playerBet[msg.sender].payments[playerBet[msg.sender].numPayments] = payment; //baalanceReceived[by the address]--> calls payments[track what i just received from sender].numPayments(calls the struct to register that as payment= payment)
    
    //changes the values of Struct Player after selection is made
    playerBet[msg.sender].teamA = true;
    playerBet[msg.sender].entry = 1;
    
    
   }
    
   function betPlayerTwo() public payable {
    //minimum required amount to enter / Make sure a winner hasn't been declared
    require(msg.value >= minimumBet, "Minimum Tokens Required = 2"); 
    require(SetWinner == 0, "Sorry you missed this one");
    //takes how much the player has bet and sets it to their msg.value
    playerBet[msg.sender].amountBet += msg.value; // .tatalbalance(access struct values)
    
    //records memory of payment made and timestamp
    Payment memory payment = Payment(msg.value,now); //creating a new payment (stored in memory, msg.value amount sent / not --> gives current timestamp / Type payment created)
    playerBet[msg.sender].payments[playerBet[msg.sender].numPayments] = payment; //balanceReceived[by the address]--> calls payments[track what i just received from sender].numPayments(calls the struct to register that as payment= payment)
    
    //changes the values of Struct Player after selection is made
    playerBet[msg.sender].teamB = true;
    playerBet[msg.sender].entry = 2;
    
   }
   
   function payouts() public {
     require(playerBet[msg.sender].entry == SetWinner, "You did not win");
     require(playerBet[msg.sender].collect == false, "You already collected your winnings");
     if(playerBet[msg.sender].entry == 1 && SetWinner ==1) {
        playerBet[msg.sender].amountBet += pot;
        playerBet[msg.sender].collect = true;
        
     }else{
         playerBet[msg.sender].entry == 2 && SetWinner ==2;
         playerBet[msg.sender].amountBet += pot;
         playerBet[msg.sender].collect = true;
         
     }
        
     emit PaymentSent(msg.sender, pot); 
     }
   
    
    function makeWinnerA() public  {
        require(msg.sender == owner, "Not the owner");
        SetWinner = 1;
        emit CheckWinner(SetWinner);
       
    }   
       
    function makeWinnerB() public   {
        require(msg.sender == owner, "Not the owner");
        SetWinner = 2;
         
        emit CheckWinner(SetWinner);
    }   
    
    function withdrawTokens(uint _amount) public {
        require(playerBet[msg.sender].amountBet > 0, "You have nothing to withdraw");
        require(playerBet[msg.sender].entry == SetWinner, "You lost this one");
        require(playerBet[msg.sender].collect == true, "Please collect your winnings");
        _amount = (playerBet[msg.sender].amountBet);
        msg.sender.transfer(_amount);
        
        
    }
    
  //  function destroyContract() public onlyOwner {
        
        
    
        
  // }
}