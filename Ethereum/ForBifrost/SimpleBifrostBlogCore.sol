pragma solidity ^0.4.24;

contract SimpleBifrostBlogCore {
    struct Form {
        uint256 dataId;
        bytes32 data;
        address writer;
        uint256 timestamp;
    }
    
    mapping (uint256 => Form) private dataById;
    uint256 private dataIdCount = 0;
    
    event callbackOnCreateData (
        uint256 dataId,
        bytes32 data,
        address writer,
        uint256 timestamp
    );
    
    function writeDataCore(bytes32 data, address writer) public {
        dataIdCount++;
        
        uint256 timestamp = now;
        
        dataById[dataIdCount] = Form({
            dataId: dataIdCount,
            data: data,
            writer: writer,
            timestamp: timestamp
        });
        
        emit callbackOnCreateData(dataIdCount, data, writer, timestamp);
    }
    
    function getDataById(uint256 dataId) public view returns(bytes32, address, uint256) {
        return (dataById[dataId].data, dataById[dataId].writer, dataById[dataId].timestamp);
    }
}
