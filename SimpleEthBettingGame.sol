pragma solidity ^0.4.24;
// ----------------------- Public Network Part -----------------------
contract EthBettingGame {
    EthBettingGameCore internal privateNetwork;
    address internal owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function transferOwnership(address newOwner) public onlyOwner() {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
    
    event onWinner(address winnerAddress);
    
    function setPrivateNetwork(address newPrivateNetwork) public onlyOwner() {
        privateNetwork = EthBettingGameCore(newPrivateNetwork);
    }
    // ----------------------- Core Part -----------------------
        mapping(address => uint) public betAmount;
        
        function bettingGame(uint gameId, uint betNumber) public payable {
            betAmount[msg.sender] = msg.value;
            privateNetwork.bettingGame(msg.sender, gameId, betNumber);
        }
        
        function callbackOnBettingGame(bool result, address winnerAddress) public payable {
            if(result){
                emit onWinner(winnerAddress);
                winnerAddress.transfer(betAmount[winnerAddress]*2);
            }
        }
    // ----------------------- Core Part -----------------------
}
// ----------------------- Private Network Part -----------------------
contract EthBettingGameCore {
    EthBettingGame internal publicNetwork;
    address internal owner;
    
    constructor(address newPublicNetwork) public {
        owner = msg.sender;
        publicNetwork = EthBettingGame(newPublicNetwork);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function transferOwnership(address newOwner) public onlyOwner() {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
    
    event onCreateGame(uint gameId);
    // ----------------------- Core Part -----------------------
        struct Game {
            uint gameId;
            mapping (uint => address) playerM;
            mapping(uint => address) betNumberM;
            uint playerCount;
            uint256 randomNumber;
        }
        
        mapping (uint => Game) public gameM;
        uint internal gameIdCount = 0;
        
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
                publicNetwork.callbackOnBettingGame(false, 0);
            }
        }
        
        function finishGame(uint gameId) internal returns(address) {
            uint winNumber = gameM[gameId].randomNumber;
            address winnerAddress = gameM[gameId].betNumberM[winNumber];
            
            publicNetwork.callbackOnBettingGame(true, winnerAddress);
            
            return (winnerAddress);
        }
        
        function createGame() public onlyOwner() {
            gameIdCount++;
            
            gameM[gameIdCount] = Game({
                gameId: gameIdCount,
                playerCount: 0,
                randomNumber: 0
            });
            
            gameM[gameIdCount].randomNumber = (uint(block.blockhash(block.number-1)) % 4) + 1;
            
            emit onCreateGame(gameIdCount);
        }
    // ----------------------- Core Part -----------------------
}