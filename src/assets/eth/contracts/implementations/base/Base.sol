//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Admin.sol";
import "./Store.sol";
import "../../utils/Uint.sol";
import "../../utils/String.sol";
import "../../utils/Bytes32.sol";


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
    internal view {
        require(categories.category_index.isContain(category_address), "BaseContact>_validCategory_");
    }
}
