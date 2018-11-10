pragma solidity ^0.4.24;
// ----------------------- Public Network Part -----------------------
contract SimpleEthBlog {
    
    SimpleEthBlogCore internal privateNetwork;
    address internal owner;
    
    event onWrite(uint256 formId, address writer, bytes32 subject, bytes32 body, uint256 timestamp);
    event onShowForm(uint256 formId, address writer, bytes32 subject, bytes32 body, uint256 timestamp);
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function setPrivateNetwork(address newPrivateNetwork) public onlyOwner() {
        privateNetwork = SimpleEthBlogCore(newPrivateNetwork);
    }
    // ----------------------- Core Part -----------------------
        function writeForm(bytes32 subject, bytes32 body) public {
            privateNetwork.writeForm(msg.sender, subject, body);
        }
        
        function showForm(uint256 formId) public {
            privateNetwork.getPostById(formId);
        }
        
        function callbackOnWrite(uint256 formId, address writer, bytes32 subject, bytes32 body, uint256 timestamp) public {
            emit onWrite(formId, writer, subject, body, timestamp);
        }
        
        function callbackOnShowForm(uint256 formId, address writer, bytes32 subject, bytes32 body, uint256 timestamp) public {
            emit onShowForm(formId, writer, subject, body, timestamp);
        }
    // ----------------------- Core Part -----------------------
}
// ----------------------- Private Network Part -----------------------
contract SimpleEthBlogCore {
    
    SimpleEthBlog internal publicNetwork;
    address internal owner;
    
    constructor(address newPublicNetwork) public {
        owner = msg.sender;
        publicNetwork = SimpleEthBlog(newPublicNetwork);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
    // ----------------------- Core Part -----------------------
        struct Form{
            uint256 formId;
            address writer;
            bytes32 subject;
            bytes32 body;
            uint256 timestamp;
        }
    
        mapping (uint => Form) private formM;
        uint256 private formIdCount = 0;
        
        function writeForm(address writer, bytes32 subject, bytes32 body) public {
            formIdCount++;
            
            uint256 timestamp = now;
            
            formM[formIdCount] = Form({
                formId: formIdCount,
                writer: writer,
                subject: subject,
                body: body,
                timestamp: timestamp
            });
            
            publicNetwork.callbackOnWrite(formIdCount, writer, subject, body, timestamp);
        }
        
        function getPostById(uint256 formId) public {
            publicNetwork.callbackOnShowForm(formId, formM[formId].writer, formM[formId].subject, formM[formId].body, formM[formId].timestamp);
        }
    // ----------------------- Core Part -----------------------
}
