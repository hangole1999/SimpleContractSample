pragma solidity ^0.4.24;

contract SimpleBifrostPublicOraclizeCore {
    event callbackOnSetRandomData (
        uint randomData
    );
    
    uint public randomData;
    
    function setRandomDataCore(uint newRandomData) public {
        randomData = newRandomData;
        
        emit callbackOnSetRandomData(randomData);
    }
}