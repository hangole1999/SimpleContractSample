pragma solidity ^0.4.24;

contract SimpleBifrostBettingGame {
    struct Game {
        uint gameId;
        mapping(uint => address) betNumberM;
        mapping(address => uint) betAmountM;
        mapping(uint => address) playerM;
    }
    
    mapping (uint => Game) private gameM;
    
    event onCreateGame(uint gameId);
    event onBettingGame(uint gameId, uint betNumber, uint playerId, address player);
    event onFinishedGame(uint gameId, uint winNumber, address winnerAddress);
    
    event bettingGameCore(uint gameId, uint betNumber, address player);
    
    function bettingGame(uint gameId, uint betNumber) public payable {
        gameM[gameId].betAmountM[msg.sender] = msg.value;
        
        emit bettingGameCore(gameId, betNumber, msg.sender);
    }
    
    function callbackOnCreateGame(uint gameId) public {
        gameM[gameId] = Game({
            gameId: gameId
        });
        
        emit onCreateGame(gameId);
    }
    
    function callbackOnBettingGame(uint gameId, uint betNumber, uint playerId, address player) public {
        gameM[gameId].betNumberM[betNumber] = player;
        gameM[gameId].playerM[playerId] = player;
        
        emit onBettingGame(gameId, betNumber, playerId, player);
    }
    
    function callbackOnFinishedGame(uint gameId, uint winNumber, address winnerAddress) public payable {
        emit onFinishedGame(gameId, winNumber, winnerAddress);

        winnerAddress.transfer(gameM[gameId].betAmountM[winnerAddress]*2);
    }
    
    function getGameBetNumberById(uint gameId, uint playerId) public view returns(address) {
        return (gameM[gameId].betNumberM[playerId]);
    }
    function getGameBetAmountByAddress(uint gameId, address playerAddress) public view returns(uint) {
        return (gameM[gameId].betAmountM[playerAddress]);
    }
    function getGamePlayerById(uint gameId, uint playerId) public view returns(address) {
        return (gameM[gameId].playerM[playerId]);
    }
}
