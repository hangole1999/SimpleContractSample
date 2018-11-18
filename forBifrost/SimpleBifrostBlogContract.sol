pragma solidity ^0.4.24;
contract SimpleBifrostBlogContract {
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
    
    function callbackOnCreateData(uint256 dataId, bytes32 data, address wrtier, uint256 timestamp) public {
        emit onCreateData(dataId, data, wrtier, timestamp);
    }
}