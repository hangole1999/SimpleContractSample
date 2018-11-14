pragma solidity ^0.4.24;
contract SimpleBccContract3Core {
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