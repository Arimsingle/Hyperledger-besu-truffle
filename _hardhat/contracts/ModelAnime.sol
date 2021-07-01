pragma solidity ^0.7.1;
pragma experimental ABIEncoderV2;

import "hardhat/console.sol";

contract ModelAnime{
    
    struct Model {
        string id;
        string name;
        string madeFrom;
        bool limited;
        uint price;
    }
    
    constructor(){
        admin = msg.sender;
        balance[msg.sender] = 10**18;
    }
    
    address private admin;
    mapping(string => uint) private views;
    mapping(string => uint) private star;
    mapping(string => uint) private comment;
    mapping(address => uint) private nonce;
    mapping(address => uint) private balance;
    mapping(address => mapping(string => Model)) private model;
    mapping(address => Model[]) private models;
    mapping(address => mapping(string => bool)) private owner;

    modifier onlyAdmin {
        require(msg.sender == admin, "Only Admin use this method");
        _;
    }
    
    event _eventTransferModel(address indexed _fromAddr, address indexed _toAddr);
    event _eventCreateModel(address indexed _fromAddr, string indexed _id);
    event _eventTransferBalance(address indexed _fromAddr, address indexed _toAddr, uint indexed _amount);
    
    function incrementView(string memory _id) external returns (bool){
        views[_id] += 1;
        return true;
    }
    
    function incrementStar(string memory _id) external returns (bool){
        star[_id] += 1;
        return true;
    }
    
    function incrementComment(string memory _id) external returns (bool){
        comment[_id] += 1;
        return true;
    }
    
    function transferModel(address _fromAddr, address _toAddr, string memory _id, uint _nonce) external returns (bool){
        require(msg.sender == _fromAddr, "You're not owner");
        require(balance[_toAddr]  >= model[_fromAddr][_id].price, "Your balance not enough");
        require(nonce[_fromAddr] <= _nonce, "You're not owner");
        require(owner[_fromAddr][_id] == true, "You're not owner");
        
        balance[_fromAddr] += model[_fromAddr][_id].price;
        balance[_toAddr] -= model[_fromAddr][_id].price;
        model[_toAddr][_id] =  models[_fromAddr][_nonce-1];
        models[_toAddr].push(model[_toAddr][_id]);
        
        owner[_fromAddr][_id] = false;
        owner[_toAddr][_id] = true;
        
        emit _eventTransferModel(_fromAddr, _toAddr);
        return true;
    }
    
    function transferBalane(address _fromAddr, address _toAddr, uint _amount) external returns (bool){
        require(balance[_fromAddr]  >= _amount, "Your balance not enough");
        balance[_toAddr] += _amount;
        balance[_fromAddr] -= _amount;
        
        emit _eventTransferBalance(_fromAddr, _toAddr, _amount);
        return true;
    }
    
    function createModel(address _fromAddr,string memory _id, string memory _name, string memory _madeFrom, bool _limited, uint price) external onlyAdmin returns (bool){
        Model memory _modelObj = Model(_id, _name, _madeFrom, _limited, price);
        model[_fromAddr][_id] = _modelObj;
        models[_fromAddr].push(_modelObj);
        owner[_fromAddr][_id] = true;
        nonce[_fromAddr] += 1;
        
        
        emit _eventCreateModel(_fromAddr, _id);
        return true;
    }
    
    function showModels(address _ownerAddr) external view returns(Model[] memory){
        require(_ownerAddr != address(0), "invalid address");
        return models[_ownerAddr];
    }
    
    function showModelById(address _ownerAddr,string memory _id) external view returns(Model memory){
        require(_ownerAddr != address(0), "invalid address");
        return model[_ownerAddr][_id];
    }
    
    function showBalance(address _ownerAddr) external view returns(uint){
        require(_ownerAddr != address(0), "invalid address");
        return balance[_ownerAddr];
    }
    
    function showView(string memory _id) external view returns(uint){
        return views[_id];
    }
    
    function showStar(string memory _id) external view returns(uint){
        return star[_id];
    }
    
    function showComment(string memory _id) external view returns(uint){
        return comment[_id];
    }
    
    function showNonce(address _ownerAddr) external view returns(uint){
        return nonce[_ownerAddr];
    }
    
    function showOwner(address _ownerAddr, string memory _id) external view returns(bool){
        return owner[_ownerAddr][_id];
    }
    
}