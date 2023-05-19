//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Admin.sol";
import "./Store.sol";

contract BaseContact is AdminContract, StoreContact {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    function _registered_(address user_address)
    internal view {
        require(users.user_info[user_address].login_timestamp != 0, "E0: User.sol>UserContract>_registered_");
    }

    function _notRegistered_(address user_address)
    internal view {
        require(users.user_info[user_address].login_timestamp == 0, "E1: User.sol>UserContract>_notRegistered_");
    }

    function _validCategory_(address category_address)
    internal view{
        require(categories.category_index.isContain(category_address),"BaseContact>_validCategory_");
    }

    function _uintRange_(uint data, uint min, uint max)
    internal pure {
        require(min == 0 || data >= min, "BaseContact>_range_>1");
        require(max == 0 || data <= max, "BaseContact>_range_>2");
    }

    function _stringRange_(string memory data, uint min, uint max)
    internal pure {
        uint length = bytes(data).length / 3;
        require(min == 0 || length >= min, "BaseContact>_range_>1");
        require(max == 0 || length <= max, "BaseContact>_range_>2");
    }

    function toAddress(bytes32 input)
    internal pure returns (address output){
        output = address(uint160(uint256(input)));
    }
}
