pragma solidity ^0.4.24;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract SimplePrivateOraclize {
    SimplePrivateOraclizeCore private privateNetwork;
    
    event onSetRandomData (
        uint randomData
    );
    
    function setPrivateNetwork(address newPrivateNetwork) public {
        privateNetwork = SimplePrivateOraclizeCore(newPrivateNetwork);
    }
    
    function setRandomData() public {
        privateNetwork.setRandomDataCore();
    }
    
    function callbackOnSetRandomData(uint randomData) public {
        emit onSetRandomData(randomData);
    }
}

contract SimplePrivateOraclizeCore is usingOraclize {
    SimplePrivateOraclize private publicNetwork;
    
    uint private randomValue;
    
    uint public randomData;
    
    constructor() public {
        oraclize_setProof(proofType_Ledger);
        
        oraclize_newRandomDSQuery(0, 7, 200000);
    }
    
    function setPublicNetwork(address newPublicNetwork) public {
        publicNetwork = SimplePrivateOraclize(newPublicNetwork);
    }
    
    function setRandomDataCore() public {
        randomData = uint(sha256(block.timestamp, block.difficulty)) * randomValue;
        
        publicNetwork.callbackOnSetRandomData(randomData);
    }
    
    function __callback(bytes32 _queryId, string _result, bytes _proof) public {
        require(msg.sender == oraclize_cbAddress(), "Require __callback address is Oraclize address");
        
        if (oraclize_randomDS_proofVerify__returnCode(_queryId, _result, _proof) == 0) {
            randomValue = uint(sha256(_result));
        }
    }
}