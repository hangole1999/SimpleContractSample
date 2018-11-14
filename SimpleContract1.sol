pragma solidity ^0.4.24;
// ----------------------- Public Network Part -----------------------
contract SimpleContract {
    SimpleContractCore private privateNetwork;
    address private owner;
    
    event onCreateData (
        uint256 indexed dataId,
        bytes32 indexed data,
        address indexed writer,
        uint256 timestamp
    );
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier isOwner() {
        require(msg.sender == owner, "Require Owner");
        _;
    }
    
    function transferOwnership(address newOwner) public isOwner() {
        owner = newOwner;
    }
    
    function setPrivateNetwork(address newPrivateNetwork) public isOwner() {
        privateNetwork = SimpleContractCore(newPrivateNetwork);
    }
    // ----------------------- Core Part -----------------------
        function writeData(bytes32 data) public {
            privateNetwork.writeData(data, msg.sender);
        }
        
        function callbackOnCreateData(uint256 dataId, bytes32 data, address wrtier, uint256 timestamp) public {
            emit onCreateData(dataId, data, wrtier, timestamp);
        }
    // ----------------------- Core Part -----------------------
}
// ----------------------- Private Network Part -----------------------
contract SimpleContractCore {
    SimpleContract private publicNetwork;
    address private owner;
    
    constructor() public {
        owner = msg.sender;
        dataIdCount = 0;
    }
    
    modifier isOwner() {
        require(msg.sender == owner, "Require Owner");
        _;
    }
    
    function transferOwnership(address newOwner) public isOwner() {
        owner = newOwner;
    }
    
    function setPublicNetwork(address newPublicNetwork) public isOwner() {
        publicNetwork = SimpleContract(newPublicNetwork);
    }
    // ----------------------- Core Part -----------------------
        struct Form {
            uint256 dataId;
            bytes32 data;
            address writer;
            uint256 timestamp;
        }
        
        uint256 private dataIdCount;
        mapping (uint256 => Form) private dataById;
        
        function writeData(bytes32 data, address writer) public returns(uint256) {
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
    // ----------------------- Core Part -----------------------
}