pragma solidity ^0.4.24;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract SimplePublicOraclize is usingOraclize {
    constructor() public {
        oraclize_setProof(proofType_Ledger);
    }
    
    event onSetRandomData (
        uint randomData
    );
    
    event setRandomDataCore (
        uint newRandomData
    );
    
    function setRandomData() public payable {
        oraclize_newRandomDSQuery(0, 7, 200000);
    }
    
    function callbackOnSetRandomData(uint randomData) public {
        emit onSetRandomData(randomData);
    }
    
    function __callback(bytes32 _queryId, string _result, bytes _proof) public {
        require(msg.sender == oraclize_cbAddress(), "Require __callback address is Oraclize address");
        
        if (oraclize_randomDS_proofVerify__returnCode(_queryId, _result, _proof) == 0) {
            emit setRandomDataCore(uint(sha256(_result)));
        }
    }
}