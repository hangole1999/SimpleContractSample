pragma solidity ^0.4.24;

contract SimpleBifrostMarketplaceCore {
    event callbackOnBuyPlot (
        address balanceOwner,
        uint balance
    );
    
    struct Plot {
        address owner;
        uint price;
    }
    
    mapping (uint => Plot) public plots;
    
    constructor() public {
        plots[0] = Plot({
            owner: 0x0,
            price: 4
        });
        plots[1] = Plot({
            owner: 0x0,
            price: 4
        });
        plots[2] = Plot({
            owner: 0x0,
            price: 4
        });
        plots[3] = Plot({
            owner: 0x0,
            price: 4
        });
    }
    
    // function getPlots() public view returns(address[], uint[]) {
    //     address[] memory addrs = new address[](4);
    //     uint[] memory price = new uint[](4);
        
    //     for (uint i = 0; i < 4; i++) {
    //         Plot storage plot = plots[i];
    //         addrs[i] = plot.owner;
    //         price[i] = plot.price;
    //     }
        
    //     return (addrs, price);
    // }
    
    function buyPlotCore(uint index, address plotOwner, uint balance) public {
        address balanceOwner = plots[index].owner;
        
        plots[index].owner = plotOwner;
        
        emit callbackOnBuyPlot(balanceOwner, balance);
    }
}