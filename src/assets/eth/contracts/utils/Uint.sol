// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

library UintLib {
    function _range_(uint self, uint min, uint max)
    internal pure {
        require(min == 0 || self >= min, "UintLib>range>1");
        require(max == 0 || self <= max, "UintLib>range>2");
    }
}
