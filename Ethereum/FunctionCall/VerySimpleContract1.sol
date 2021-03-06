pragma solidity ^0.4.24;
// ----------------------- Public Network Part -----------------------
contract VerySimpleContract1 {
    VerySimpleContract1Core private privateNetwork;
    
    event onSetData (
        bytes32 data,
        uint256 timestamp
    );
    
    function setPrivateNetwork(address newPrivateNetwork) public {
        privateNetwork = VerySimpleContract1Core(newPrivateNetwork);
    }
    
    function setData(bytes32 data) public {
        privateNetwork.setDataCore(data);
    }
    
    function callbackOnSetData(bytes32 data, uint256 timestamp) public {
        emit onSetData(data, timestamp);
    }
}
// ----------------------- Private Network Part -----------------------
contract VerySimpleContract1Core {
    VerySimpleContract1 private publicNetwork;
    bytes32 private simpleData;
    
    function setPublicNetwork(address newPublicNetwork) public {
        publicNetwork = VerySimpleContract1(newPublicNetwork);
    }
    
    function setDataCore(bytes32 data) public {
        simpleData = data;
        
        publicNetwork.callbackOnSetData(simpleData, now);
    }
    
    function getData() public view returns(bytes32) {
        return (simpleData);
    }
}