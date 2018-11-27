pragma solidity ^0.4.24;
// ----------------------- Public Network Part ----------------------- // Eth Blog
contract VerySimpleContract2 {
    VerySimpleContract2Core private privateNetwork;
    
    event onCreateData (
        uint256 indexed dataId,
        bytes32 indexed data,
        address indexed writer,
        uint256 timestamp
    );
    
    function setPrivateNetwork(address newPrivateNetwork) public {
        privateNetwork = VerySimpleContract2Core(newPrivateNetwork);
    }
    
    function writeData(bytes32 data) public {
        privateNetwork.writeDataCore(data, msg.sender);
    }
    
    function callbackOnCreateData(uint256 dataId, bytes32 data, address wrtier, uint256 timestamp) public {
        emit onCreateData(dataId, data, wrtier, timestamp);
    }
}
// ----------------------- Private Network Part -----------------------
contract VerySimpleContract2Core {
    VerySimpleContract2 private publicNetwork;
    
    struct Form {
        uint256 dataId;
        bytes32 data;
        address writer;
        uint256 timestamp;
    }
    
    mapping (uint256 => Form) private dataById;
    uint256 private dataIdCount = 0;
    
    function setPublicNetwork(address newPublicNetwork) public {
        publicNetwork = VerySimpleContract2(newPublicNetwork);
    }
    
    function writeDataCore(bytes32 data, address writer) public returns(uint256) {
        dataIdCount++;
        
        uint256 timestamp = now;
        
        dataById[dataIdCount] = Form({
            dataId: dataIdCount,
            data: data,
            writer: writer,
            timestamp: timestamp
        });
        
        publicNetwork.callbackOnCreateData(dataIdCount, data, writer, timestamp);
    }
    
    function getDataById(uint256 dataId) public view returns(bytes32, address, uint256) {
        return (dataById[dataId].data, dataById[dataId].writer, dataById[dataId].timestamp);
    }
}