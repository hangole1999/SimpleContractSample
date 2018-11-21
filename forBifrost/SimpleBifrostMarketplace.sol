pragma solidity ^0.4.24;

contract SimpleBifrostMarketplace {
    event onBuyPlot(
        uint index,
        address plotOwner,
        address balanceOwner
    );
    
    event onCreatePlot (
        uint index,
        uint price
    );
    event buyPlotCore(
        uint index,
        address owner
    );
    
    struct Plot {
        address owner;
        uint price;
    }
    
    mapping (uint => Plot) private plots;
    
    mapping (address => uint) private balances;
    
    function buyPlot(uint index) public payable {
        balances[msg.sender] += msg.value;
        
        emit buyPlotCore(index, msg.sender);
    }
    
    function callbackOnCreatePlot(uint index, uint price) public {
        plots[index] = Plot({
            owner: 0x0,
            price: price
        });
        
        emit onCreatePlot(index, price);
    }
    
    function callbackOnBuyPlot(uint index, address plotOwner, address balanceOwner) public {
        plots[index].owner = plotOwner;
        
        emit onBuyPlot(index, plotOwner, balanceOwner);
        
        balanceOwner.transfer(balances[balanceOwner]);
    }
    
    function getPlotById(uint plotId) public view returns(address, uint) {
        return (plots[plotId].owner, plots[plotId].price);
    }
}
