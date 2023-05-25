// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

library Bytes32Lib {
    function toAddress(bytes32 self)
    internal pure returns (address output){
        output = address(uint160(uint256(self)));
    }
}
