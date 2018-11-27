pragma solidity ^0.4.24;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract SimpleBifrostPrivateOraclizeCore is usingOraclize {
    event callbackOnSetRandomData (
        uint randomData
    );
    
    uint private randomValue;
    
    uint public randomData;
    
    constructor() public {
        oraclize_setProof(proofType_Ledger);
        
        oraclize_newRandomDSQuery(0, 7, 200000);
    }
    
    function setRandomDataCore() public {
        randomData = uint(sha256(block.timestamp, block.difficulty)) * randomValue;
        
        emit callbackOnSetRandomData(randomData);
    }
    
    function __callback(bytes32 _queryId, string _result, bytes _proof) public {
        require(msg.sender == oraclize_cbAddress(), "Require __callback address is Oraclize address");
        
        if (oraclize_randomDS_proofVerify__returnCode(_queryId, _result, _proof) == 0) {
            randomValue = uint(sha256(_result));
        }
    }
}