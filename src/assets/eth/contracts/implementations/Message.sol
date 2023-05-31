// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface MessageInterface {
    function MessageContact_init(uint) external;
}

contract MessageContact is BaseContact, MessageInterface {
    function MessageContact_init(uint)
    _onlyAdmin_
    external {
    }
}
