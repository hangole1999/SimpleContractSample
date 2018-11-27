pragma solidity ^0.4.24;

contract SimpleCollectible {
    SimpleCollectibleCore private privateNetwork;
    
    event onCreateCollection(
        uint id
    );
    
    function setPrivateNetwork(address newPrivateNetwork) public {
        privateNetwork = SimpleCollectibleCore(newPrivateNetwork);
    }
    
    function createCollection() public {
        privateNetwork.createCollectionCore(msg.sender);
    }
    
    function callbackOnCreateCollection(uint id) public {
        emit onCreateCollection(id);
    }
}

contract SimpleCollectibleCore {
    SimpleCollectible private publicNetwork;
    
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
    
    function setPublicNetwork(address newPublicNetwork) public {
        publicNetwork = SimpleCollectible(newPublicNetwork);
    }
    
    function createCollectionCore(address owner) public {
        collectionCountId++;
        
        uint dna = uint(keccak256(block.timestamp, block.difficulty));
        
        collections[collectionCountId] = Collection({
            id: collectionCountId,
            owner: owner,
            dna: dna
        });
        
        publicNetwork.callbackOnCreateCollection(collectionCountId);
    }
}