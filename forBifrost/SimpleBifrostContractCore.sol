pragma solidity ^0.4.24;
contract SimpleBifrostContractCore {
    bytes32 private simpleData;
    
    event callbackOnSetData (
        bytes32 data,
        uint256 timestamp
    );
    
    function setDataCore(bytes32 data) public {
        simpleData = data;
        
        emit callbackOnSetData(simpleData, now);
    }
    
    function getData() public view returns(bytes32) {
        return (simpleData);
    }
}
