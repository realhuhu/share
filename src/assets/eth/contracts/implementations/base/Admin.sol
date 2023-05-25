// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

interface AdminInterface {
    function renounceAdmin() external;

    function transferAdmin(address new_admin) external;
}

abstract contract AdminContract {
    address public admin;

    event AdminTransferred(address indexed old_admin, address indexed new_admin);

    modifier _onlyAdmin_() {
        require(admin == msg.sender, "AdminContract>_onlyAdmin_");
        _;
    }

    function renounceAdmin() public _onlyAdmin_ {
        _transferAdmin(address(0));
    }

    function transferAdmin(address new_admin) public _onlyAdmin_ {
        require(new_admin != address(0), "AdminContract>transferAdmin");
        _transferAdmin(new_admin);
    }

    function _transferAdmin(address new_admin) internal {
        address old_admin = admin;
        admin = new_admin;
        emit AdminTransferred(old_admin, new_admin);
    }
}
