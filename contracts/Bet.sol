pragma solidity >=0.5.3;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

contract SportsBet {
    using SafeMath for uint256;

    address payable owner;
    uint minBet;
    
    uint256 totalBetsOne;
    uint256 totalBetsTwo;

    address payable[] public players;
    address public oracle;
    
    enum BettingStatus {Not_started, Started, Finished}
    
    
    BettingStatus public betStatus;
    
    
    struct Game{
    uint betId;  
    }
    
    struct Player {
    uint256 amountBet;
    uint16 team;
    bool betMade;
    uint odds;
    }
    
    uint nextGameId;
    
    mapping(address => Player) public playerInfo;
    mapping(uint => Game) public gameInfo;
    
    event BetPlayer(address indexed _from, uint256 _amount, uint player);
    
    constructor() public {
        owner = msg.sender;
        minBet = 1000000000000000000;
        betStatus = BettingStatus.Not_started;
        
    }
    
    function configureOracle(address _oracle) external onlyAdmin{
        oracle = _oracle;  
    }
    
    function kill() public {
      if(msg.sender == owner) selfdestruct(owner);
    }
    
    function checkPlayerExists(address payable player) public view returns(bool){
      for(uint256 i = 0; i < players.length; i++){
         if(players[i] == player) return true;
      }
      return false;
    }
    
    //creates game and gives it a betID
    //changes bet status to started
    function newGame() public  {
        require(betStatus == BettingStatus.Not_started, "This game has already started");
        gameInfo[nextGameId].betId = nextGameId;
        betStatus = BettingStatus.Started;
        nextGameId++;
    }
    
    //users can make a bet on team 1 or team 2. 
    function makeBet(uint8 _team, uint _odds) public payable {
        require(betStatus == BettingStatus.Started,"Game has not been created");
        require(playerInfo[msg.sender].betMade == false,"You have already made a bet");
        require(msg.value >= minBet, "Not enough sent to bet");
        
        
        //Player will make a bet and select team 
        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].team = _team;
        playerInfo[msg.sender].odds = _odds;
        
        //Add playerInfo to the players array
        players.push(msg.sender);
        
        if(_team == 1){
            totalBetsOne += msg.value;
        }
        else{
            totalBetsTwo += msg.value;
        }
        playerInfo[msg.sender].betMade = true;
        
        emit BetPlayer(msg.sender, msg.value, _team);
        
    }
    
    function payouts(uint _winner) public onlyAdmin {
        //temporary memory array. Fixed size to test
        address payable[100] memory winners;
        uint256 count = 0;
        uint256 loserBet = 0;
        uint256 winnerBet = 0;
        address add;
        uint256 playerOdds;
        uint256 betPlaced;
        address payable playerAddress;
        
        //loop through players to see who selected winning team
        for(uint256 i = 0; i < players.length; i++){
            playerAddress = players[i];
        //players who selected winning team     
        if(playerInfo[playerAddress].team == _winner){
        winners[count] = playerAddress;
        count++;
        
        }
    }
    if(_winner == 1){
        loserBet = totalBetsTwo;
        winnerBet = totalBetsOne;
        
    }else{
        loserBet = totalBetsOne;
        winnerBet = totalBetsTwo;
        
    }
    
    //check winners array & pays out winners
    for(uint256 j = 0; j < count; j++){
        if(winners[j] != address(0))
        add = winners[j];
        betPlaced = playerInfo[add].amountBet;
        playerOdds = playerInfo[add].odds;
        winners[j].transfer((betPlaced));
    }
    
    //reset data
    delete playerInfo[playerAddress];
    loserBet = 0;
    winnerBet = 0;
    totalBetsOne = 0;
    totalBetsTwo = 0;
    
}
    
    function teamOne() public view returns(uint256) {
        return totalBetsOne;
    }
    
    function teamTwo() public view returns(uint256) {
        return totalBetsTwo;
    }
    
    modifier onlyAdmin(){
        require(msg.sender == owner);
        _;
    }
}
