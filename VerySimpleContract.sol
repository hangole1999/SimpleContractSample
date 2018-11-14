pragma solidity ^0.4.24;
// ----------------------- Public Network Part -----------------------
contract VerySimpleContract {
    VerySimpleContractCore private privateNetwork;
    
    event onSetData (
        bytes32 data,
        uint256 timestamp
    );
    
    event setDataCore (
        bytes32 data
    );
    
    function setPrivateNetwork(address newPrivateNetwork) public {
        privateNetwork = VerySimpleContractCore(newPrivateNetwork);
    }
    
    function setData(bytes32 data) public {
        emit setDataCore(data);
    }
    
    function callbackOnSetData(bytes32 data, uint256 timestamp) public {
        emit onSetData(data, timestamp);
    }
}
// ----------------------- Private Network Part -----------------------
contract VerySimpleContractCore {
    VerySimpleContract private publicNetwork;
    bytes32 private simpleData;
    
    event callbackOnSetData (
        bytes32 data,
        uint256 timestamp
    );
    
    function setPublicNetwork(address newPublicNetwork) public {
        publicNetwork = VerySimpleContract(newPublicNetwork);
    }
    
    function setDataCore(bytes32 data) public {
        simpleData = data;
        
        emit callbackOnSetData(simpleData, now);
    }
    
    function getData() public view returns(bytes32) {
        return (simpleData);
    }
}