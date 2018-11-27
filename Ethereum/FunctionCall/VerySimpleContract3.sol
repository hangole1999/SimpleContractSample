pragma solidity ^0.4.24;
// ----------------------- Public Network Part ----------------------- // Betting Game
contract VerySimpleContract3 {
    VerySimpleContract3Core internal privateNetwork;
    
    event onWinner(address winnerAddress);
    event onCreateGame(uint gameId);
    
    function setPrivateNetwork(address newPrivateNetwork) public {
        privateNetwork = VerySimpleContract3Core(newPrivateNetwork);
    }
    
    mapping(address => uint) public betAmount;
    
    function bettingGame(uint gameId, uint betNumber) public payable {
        betAmount[msg.sender] = msg.value;
        privateNetwork.bettingGameCore(msg.sender, gameId, betNumber);
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
    
    function bettingGameCore(address player, uint gameId, uint betNumber) public {
        gameM[gameId].playerCount++;
        
        gameM[gameId].playerM[gameM[gameId].playerCount] = player;
        gameM[gameId].betNumberM[betNumber] = player;
        
        bool result = false;
        
        if (gameM[gameId].playerCount == 4) {
            result = true;
            finishGame(gameId);
        } else {
            publicNetwork.callbackOnBettingGame(false, 0);
        }
    }
    
    function finishGame(uint gameId) internal {
        uint winNumber = gameM[gameId].randomNumber;
        address winnerAddress = gameM[gameId].betNumberM[winNumber];
        
        publicNetwork.callbackOnBettingGame(true, winnerAddress);
    }
    
    function createGame() public {
        gameIdCount++;
        
        gameM[gameIdCount] = Game({
            gameId: gameIdCount,
            playerCount: 0,
            randomNumber: 0
        });
        
        gameM[gameIdCount].randomNumber = (uint(block.blockhash(block.number-1)) % 4) + 1;
        
        publicNetwork.callbackOnCreateGame(gameIdCount);
    }
}