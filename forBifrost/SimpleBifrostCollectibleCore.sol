pragma solidity ^0.4.24;

contract SimpleBifrostCollectibleCore {
    event callbackOnCreateCollection(
        uint id
    );
    
    constructor() public {
        collectionCountId = 0;
    }
    
    struct Collection {
        uint id;
        address owner;
        uint dna;
    }
    
    mapping (uint => Collection) public collections;
    
    uint public collectionCountId;
    
    function createCollectionCore(address owner) public {
        collectionCountId++;
        
        uint dna = uint(keccak256(block.timestamp, block.difficulty));
        
        collections[collectionCountId] = Collection({
            id: collectionCountId,
            owner: owner,
            dna: dna
        });
        
        emit callbackOnCreateCollection(collectionCountId);
    }
}