// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

library StringLib {
    function _range_(string memory self, uint min, uint max)
    internal pure {
        uint length = bytes(self).length / 3;
        require(min == 0 || length >= min, "StringLib>range>1");
        require(max == 0 || length <= max, "StringLib>range>2");
    }
}
