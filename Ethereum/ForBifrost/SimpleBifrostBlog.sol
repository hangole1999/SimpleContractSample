pragma solidity ^0.4.24;

contract SimpleBifrostBlog {
    struct Form {
        uint256 dataId;
        bytes32 data;
        address writer;
        uint256 timestamp;
    }
    
    mapping (uint256 => Form) private dataById;
    
    event onCreateData (
        uint256 indexed dataId,
        bytes32 indexed data,
        address indexed writer,
        uint256 timestamp
    );
    
    event writeDataCore (
        bytes32 data,
        address writer
    );
    
    function writeData(bytes32 data) public {
        emit writeDataCore(data, msg.sender);
    }
    
    function callbackOnCreateData(uint256 dataId, bytes32 data, address writer, uint256 timestamp) public {
        dataById[dataId] = Form({
            dataId: dataId,
            data: data,
            writer: writer,
            timestamp: timestamp
        });
        
        emit onCreateData(dataId, data, writer, timestamp);
    }
    
    function getDataById(uint256 dataId) public view returns(bytes32, address, uint256) {
        return (dataById[dataId].data, dataById[dataId].writer, dataById[dataId].timestamp);
    }
}
