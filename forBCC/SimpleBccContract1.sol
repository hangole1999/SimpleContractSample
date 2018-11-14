pragma solidity ^0.4.24;
contract SimpleBccContract1 {
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
        emit onSetData(data, timestamp);
    }
}