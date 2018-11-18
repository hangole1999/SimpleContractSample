pragma solidity ^0.4.24;

contract SimpleBifrostPrivateOraclize {
    event onSetRandomData (
        uint randomData
    );
    
    event setRandomDataCore (
    );
    
    function setRandomData() public {
        emit setRandomDataCore();
    }
    
    function callbackOnSetRandomData(uint randomData) public {
        emit onSetRandomData(randomData);
    }
}