pragma solidity ^0.4.24;

contract SimpleBifrostBettingGameCore {
    struct Game {
        uint gameId;
        mapping(uint => address) betNumberM;
        mapping(address => uint) betAmountM;
        mapping(uint => address) playerM;
        uint playerCount;
        uint256 randomNumber;
    }
    
    mapping (uint => Game) private gameM;
    uint private gameIdCount = 0;
    
    event callbackOnCreateGame (uint gameId);
    event callbackOnBettingGame (uint gameId, uint betNumber, uint playerId, address player);
    event callbackOnFinishedGame (uint gameId, uint winNumber, address winnerAddress);
    
    function bettingGameCore(uint gameId, uint betNumber, address player) public payable {
        gameM[gameId].playerCount++;
        
        gameM[gameId].betNumberM[betNumber] = player;
        gameM[gameId].betAmountM[player] = msg.value;
        gameM[gameId].playerM[gameM[gameId].playerCount] = player;
        
        emit callbackOnBettingGame(gameId, betNumber, gameM[gameId].playerCount, player);
        
        if (gameM[gameId].playerCount == 4) {
            finishGame(gameId);
        }
    }
    
    function finishGame(uint gameId) private {
        uint winNumber = gameM[gameId].randomNumber;
        address winnerAddress = gameM[gameId].betNumberM[winNumber];
        
        emit callbackOnFinishedGame(gameId, winNumber, winnerAddress);
        
        winnerAddress.transfer(gameM[gameId].betAmountM[winnerAddress]*2);
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
    
    function getGameById(uint gameId) public view returns(uint) {
        return (gameM[gameId].playerCount);
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
