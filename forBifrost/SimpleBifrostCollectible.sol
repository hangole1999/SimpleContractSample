pragma solidity ^0.4.24;

contract SimpleBifrostCollectible {
    event onCreateCollection(
        uint id
    );
    
    event createCollectionCore(
        address owner
    );
    
    function createCollection() public {
        emit createCollectionCore(msg.sender);
    }
    
    function callbackOnCreateCollection(uint id) public {
        emit onCreateCollection(id);
    }
}