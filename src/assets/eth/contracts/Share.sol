// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Lib.sol";
import "./User.sol";

contract Share{
    using AddressLinkedList for AddressLinkedList.T;
    using File

    address public admin;
    UserContract User;

    struct File{
        address ipfs_address;
        address uploader;
        uint timestamp;
        string title;
        string description;
        uint price;
        uint heat;
    }

    mapping(address=>uint) brought_timestamp;


    AddressLinkedList.T flies;

    constructor(address user_contract_adress){
        User=UserContract(user_contract_adress);
    }

    modifier _notUploaded_(address file_address){
        require(!flies.contain(file_address),"E");
        _;
    }

        modifier _uploaded_(address file_address){
        require(flies.contain(file_address),"E");
        _;
    }

    function upload(address ipfs_address,string memory title,string memory description,uint price) _notUploaded_(ipfs_address) 
    public{
        require(User.isRegistered(msg.sender),"E0: Share.sol>Share>upload");
    }
}