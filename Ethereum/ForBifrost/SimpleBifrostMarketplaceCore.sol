pragma solidity ^0.4.24;

contract SimpleBifrostMarketplaceCore {
    event callbackOnCreatePlot (
        uint index,
        uint price
    );
    event callbackOnBuyPlot (
        uint index,
        address plotOwner,
        address balanceOwner
    );
    
    struct Plot {
        address owner;
        uint price;
    }
    
    mapping (uint => Plot) private plots;
    uint private plotIdCount = 0;
    
    mapping (address => uint) private balances;
    
    function createPlot(uint price) public {
        plotIdCount++;
        
        plots[plotIdCount] = Plot({
            owner: 0x0,
            price: price
        });
        
        emit callbackOnCreatePlot(plotIdCount, price);
    }
    
    function buyPlotCore(uint index, address plotOwner) public payable {
        address balanceOwner = plots[index].owner;
        
        balances[plotOwner] += msg.value;
        
        plots[index].owner = plotOwner;
        
        emit callbackOnBuyPlot(index, plotOwner, balanceOwner);
        
        balanceOwner.transfer(balances[balanceOwner]);
    }
    
    function getPlotById(uint plotId) public view returns(address, uint) {
        return (plots[plotId].owner, plots[plotId].price);
    }
}
