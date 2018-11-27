pragma solidity ^0.4.24;

contract SimpleBifrostCollectibleCore {
    event callbackOnCreateCollection(
        uint id,
        address owner,
        uint dna
    );
    
    constructor() public {
        collectionCountId = 0;
    }
    
    struct Collection {
        uint id;
        address owner;
        uint dna;
    }
    
    mapping (uint => Collection) private collections;
    
    uint private collectionCountId;
    
    function createCollectionCore(address owner) public {
        collectionCountId++;
        
        uint dna = uint(keccak256(block.timestamp, block.difficulty));
        
        collections[collectionCountId] = Collection({
            id: collectionCountId,
            owner: owner,
            dna: dna
        });
        
        emit callbackOnCreateCollection(collectionCountId, owner, dna);
    }
    
    function getCollectionById(uint collectionId) public view returns(uint, address, uint) {
        return (collections[collectionId].id, collections[collectionId].owner, collections[collectionId].dna);
    }
}
