// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./implementations/base/Base.sol";
import "./implementations/User.sol";
import "./implementations/File.sol";
import "./implementations/Reward.sol";
import "./implementations/Message.sol";

interface ImplementationInterface is AdminInterface, UserInterface, FileInterface, RewardInterface, MessageInterface {}


contract OurShare is AdminContract {
    bytes32 private constant user_position = keccak256("O");
    bytes32 private constant file_position = keccak256("U");
    bytes32 private constant reward_position = keccak256("R");
    bytes32 private constant message_position = keccak256("S");

    constructor(){
        admin = msg.sender;
    }

    function getImplementation()
    public view returns (address user_address, address file_address, address reward_address, address message_address) {
        bytes32 _user_position = user_position;
        bytes32 _file_position = file_position;
        bytes32 _reward_position = reward_position;
        bytes32 _message_position = message_position;
        assembly {
            user_address := sload(_user_position)
            file_address := sload(_file_position)
            reward_address := sload(_reward_position)
            message_address := sload(_message_position)
        }
    }


    function setImplementation(
        address user_address,
        address file_address,
        address reward_address,
        address message_address
    ) public _onlyAdmin_ {
        bytes32 _user_position = user_position;
        bytes32 _file_position = file_position;
        bytes32 _reward_position = reward_position;
        bytes32 _message_position = message_position;
        assembly {
            sstore(_user_position, user_address)
            sstore(_file_position, file_address)
            sstore(_reward_position, reward_address)
            sstore(_message_position, message_address)
        }
    }


    function _delegate(
        address user_address,
        address file_address,
        address reward_address,
        address message_address
    ) internal {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let p := mload(0x4)
            let result

            switch p
            case 0 {
                result := delegatecall(gas(), user_address, 0, calldatasize(), 0, 0)
            }
            case 1{
                result := delegatecall(gas(), file_address, 0, calldatasize(), 0, 0)
            }
            case 2{
                result := delegatecall(gas(), reward_address, 0, calldatasize(), 0, 0)
            }
            case 3{
                result := delegatecall(gas(), message_address, 0, calldatasize(), 0, 0)
            }

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
        address user_address;
        address file_address;
        address reward_address;
        address message_address;
        (user_address, file_address, reward_address, message_address) = getImplementation();
        _delegate(user_address, file_address, reward_address, message_address);
    }

    receive() external payable {
        address user_address;
        address file_address;
        address reward_address;
        address message_address;
        (user_address, file_address, reward_address, message_address) = getImplementation();
        _delegate(user_address, file_address, reward_address, message_address);
    }
}
