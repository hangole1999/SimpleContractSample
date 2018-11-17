pragma solidity ^0.4.24;

contract SimpleMarketplace {
    SimpleMarketplaceCore private privateNetwork;
    address owner;
    mapping (address => uint) public balances;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier isOwner() {
        require(msg.sender == owner, "Require Owner");
        _;
    }
    
    function transferOwnership(address newOwner) public isOwner() {
        owner = newOwner;
    }
    
    function setPrivateNetwork(address newPrivateNetwork) public isOwner() {
        privateNetwork = SimpleMarketplaceCore(newPrivateNetwork);
    }
    
    function buyPlot(uint index) public payable {
        privateNetwork.buyPlotCore(index, msg.sender);
    }
    
    // function buyPlot(uint index) public payable {
    //     privateNetwork.buyPlotCore(index, msg.sender, msg.value);
    // }
    
    function callbackBuyPlot(address balanceOwner) public {
        balances[balanceOwner] += 4;
    }
    
    // function callbackBuyPlot(address balanceOwner, uint balance) public {
    //     balances[balanceOwner] += balance;
    // }
    
    function withdrawFunds() public {
        address payee = msg.sender;
        uint payment = balances[payee];
        
        require(payment > 0);
        
        balances[payee] = 0;
        require(payee.send(payment));
    }
}

contract SimpleMarketplaceCore {
    SimpleMarketplace private publicNetwork;
    address owner;
    
    struct Plot {
        address owner;
        uint price;
    }
    
    mapping (uint => Plot) public plots;
    
    constructor() public {
        owner = msg.sender;
        
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
    
    modifier isOwner() {
        require(msg.sender == owner, "Require Owner");
        _;
    }
    
    function transferOwnership(address newOwner) public isOwner() {
        owner = newOwner;
    }
    
    function setPublicNetwork(address newPublicNetwork) public isOwner() {
        publicNetwork = SimpleMarketplace(newPublicNetwork);
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
    
    function buyPlotCore(uint index, address plotOwner) public {
        if (plots[index].owner == 0x0) {
            publicNetwork.callbackBuyPlot(owner);
        } else {
            publicNetwork.callbackBuyPlot(plots[index].owner);
        }
        
        plots[index].owner = plotOwner;
    }
    
    // function buyPlotCore(uint index, address plotOwner, uint balance) public {
    //     address balanceOwner = 0x0;
        
    //     if (plots[index].owner == 0x0) {
    //         balanceOwner = owner;
    //     } else {
    //         balanceOwner = plots[index].owner;
    //     }
        
    //     plots[index].owner = plotOwner;
        
    //     publicNetwork.callbackBuyPlot(balanceOwner, balance);
    // }
}