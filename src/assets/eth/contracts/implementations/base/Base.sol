//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Admin.sol";
import "./Store.sol";

contract BaseContact is AdminContract, StoreContact {
    //是否已注册
    modifier _registered_(address user_address) {
        require(users.user_info[user_address].login_timestamp != 0, "E0: User.sol>UserContract>_registered_");
        _;
    }

    //是否未注册
    modifier _notRegistered_(address user_address) {
        require(users.user_info[user_address].login_timestamp == 0, "E1: User.sol>UserContract>_notRegistered_");
        _;
    }

    function toAddress(bytes32 input)
    internal pure returns (address output){
        assembly{
            output := mload(add(input, 32))
        }
    }
}
