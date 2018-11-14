pragma solidity ^0.4.24;
// ----------------------- Public Network Part ----------------------- // Betting Game
contract VerySimpleContract3 {
    VerySimpleContract3Core internal privateNetwork;
    
    event onWinner(address winnerAddress);
    event onCreateGame(uint gameId);
    
    event bettingGameCore(address player, uint gameId, uint betNumber);
    
    function setPrivateNetwork(address newPrivateNetwork) public {
        privateNetwork = VerySimpleContract3Core(newPrivateNetwork);
    }
    
    mapping(address => uint) public betAmount;
    
    function bettingGame(uint gameId, uint betNumber) public payable {
        betAmount[msg.sender] = msg.value;
        emit bettingGameCore(msg.sender, gameId, betNumber);
    }
    
    function callbackOnBettingGame(bool result, address winnerAddress) public payable {
        if(result){
            emit onWinner(winnerAddress);
            winnerAddress.transfer(betAmount[winnerAddress]*2);
        }
    }
    
    function callbackOnCreateGame(uint gameId) public {
        emit onCreateGame(gameId);
    }
}
// ----------------------- Private Network Part -----------------------
contract VerySimpleContract3Core {
    VerySimpleContract3 internal publicNetwork;
    
    constructor(address newPublicNetwork) public {
        publicNetwork = VerySimpleContract3(newPublicNetwork);
    }
    
    struct Game {
        uint gameId;
        mapping (uint => address) playerM;
        mapping(uint => address) betNumberM;
        uint playerCount;
        uint256 randomNumber;
    }
    
    mapping (uint => Game) public gameM;
    uint internal gameIdCount = 0;
    
    event callbackOnBettingGame (bool result, address winnerAddress);
    event callbackOnCreateGame (uint gameId);
    
    function bettingGame(address player, uint gameId, uint betNumber) public {
        gameM[gameId].playerCount++;
        
        gameM[gameId].playerM[gameM[gameId].playerCount] = player;
        gameM[gameId].betNumberM[betNumber] = player;
        
        bool result = false;
        address winnerAddress = address(0);
        
        if (gameM[gameId].playerCount == 4) {
            result = true;
            winnerAddress = finishGame(gameId);
        } else {
            emit callbackOnBettingGame(false, 0);
        }
    }
    
    function finishGame(uint gameId) internal returns(address) {
        uint winNumber = gameM[gameId].randomNumber;
        address winnerAddress = gameM[gameId].betNumberM[winNumber];
        
        emit callbackOnBettingGame(true, winnerAddress);
        
        return (winnerAddress);
    }
    
    function createGame() public {
        gameIdCount++;
        
        gameM[gameIdCount] = Game({
            gameId: gameIdCount,
            playerCount: 0,
            randomNumber: 0
        });
        
        gameM[gameIdCount].randomNumber = (uint(block.blockhash(block.number-1)) % 4) + 1;
        
        emit callbackOnCreateGame(gameIdCount);
    }
}