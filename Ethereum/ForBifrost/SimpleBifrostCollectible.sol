pragma solidity ^0.4.24;

contract SimpleBifrostCollectible {
    event onCreateCollection(
        uint id,
        address owner,
        uint dna
    );
    
    event createCollectionCore(
        address owner
    );
    
    struct Collection {
        uint id;
        address owner;
        uint dna;
    }
    
    mapping (uint => Collection) private collections;
    
    function createCollection() public {
        emit createCollectionCore(msg.sender);
    }
    
    function callbackOnCreateCollection(uint id, address owner, uint dna) public {
        collections[id] = Collection({
            id: id,
            owner: owner,
            dna: dna
        });
        
        emit onCreateCollection(id, owner, dna);
    }
    
    function getCollectionById(uint collectionId) public view returns(uint, address, uint) {
        return (collections[collectionId].id, collections[collectionId].owner, collections[collectionId].dna);
    }
}
