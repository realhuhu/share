// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface MessageInterface {

}

contract MessageContact is BaseContact, MessageInterface {
    function MessageContract_init()
    internal {
    }
}
