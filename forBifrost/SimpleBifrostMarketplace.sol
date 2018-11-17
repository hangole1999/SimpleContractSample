pragma solidity ^0.4.24;

contract SimpleBifrostMarketplace {
    event buyPlotCore(
        uint index,
        address owner,
        uint balance
    );
    
    mapping (address => uint) public balances;
    
    function buyPlot(uint index) public payable {
        emit buyPlotCore(index, msg.sender, msg.value);
    }
    
    function callbackOnBuyPlot(address balanceOwner, uint balance) public {
        balances[balanceOwner] += balance;
    }
    
    function withdrawFunds() public {
        address payee = msg.sender;
        uint payment = balances[payee];
        
        require(payment > 0);
        
        balances[payee] = 0;
        require(payee.send(payment));
    }
}