pragma solidity ^0.4.24;

contract SimpleBifrostContract {
    bytes32 private simpleData;
    
    event onSetData (
        bytes32 data,
        uint256 timestamp
    );
    
    event setDataCore (
        bytes32 data
    );
    
    function setData(bytes32 data) public {
        emit setDataCore(data);
    }
    
    function callbackOnSetData(bytes32 data, uint256 timestamp) public {
        simpleData = data;
        emit onSetData(data, timestamp);
    }
    
    function getData() public view returns(bytes32) {
        return (simpleData);
    }
}
