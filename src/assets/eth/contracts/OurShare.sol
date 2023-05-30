// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./implementations/base/Base.sol";
import "./implementations/User.sol";
import "./implementations/File.sol";
import "./implementations/Reward.sol";
import "./implementations/Message.sol";

interface ImplementationInterface is AdminInterface, UserInterface, FileInterface, RewardInterface, MessageInterface {
    function init() external;
}

contract ImplementationContact is UserContract, FileContact, RewardContact, MessageContact {
    function init()
    public {
        require(admin != address(0), "initialized");
        admin = msg.sender;
        UserContract_init();
        FileContract_init();
        RewardContract_init();
        MessageContract_init();
    }
}

contract OurShare is AdminContract {
    bytes32 private constant implementation_position = keccak256("OurShare");

    constructor(){
        admin = msg.sender;
    }

    function getImplementation() public view returns (address implementation) {
        bytes32 position = implementation_position;
        assembly {
            implementation := sload(position)
        }
    }

    function setImplementation(address implementation) public _onlyAdmin_ {
        bytes32 position = implementation_position;
        assembly {
            sstore(position, implementation)
        }
    }

    function _delegate(address implementation) internal {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return (0, returndatasize())
            }
        }
    }

    fallback() external payable {
        _delegate(getImplementation());
    }

    receive() external payable {
        _delegate(getImplementation());
    }
}
