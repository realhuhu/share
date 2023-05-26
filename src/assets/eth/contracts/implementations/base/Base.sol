//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Admin.sol";
import "./Store.sol";


contract BaseContact is AdminContract, StoreContact {
    using UserLib for Types.UserStore;
    using CategoryLib for Types.CategoryStore;

    function _registered_(address user_address)
    internal view {
        require(users.isRegistered(user_address), "E0: User.sol>UserContract>_registered_");
    }

    function _notRegistered_(address user_address)
    internal view {
        require(!users.isRegistered(user_address), "E1: User.sol>UserContract>_notRegistered_");
    }

    function _validCategory_(address category_address)
    internal view {
        require(categories.isContain(category_address), "BaseContact>_validCategory_");
    }
}
