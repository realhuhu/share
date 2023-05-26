//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Admin.sol";
import "./Store.sol";


contract BaseContact is AdminContract, StoreContact {}
