pragma solidity ^0.4.24;
contract SimpleBccContract3 {
    event onWinner(address winnerAddress);
    event onCreateGame(uint gameId);
    
    event bettingGameCore(address player, uint gameId, uint betNumber);
    
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