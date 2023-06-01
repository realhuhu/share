// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Types.sol";
import "./UserLib.sol";
import "./FileLib.sol";
import "./RewardLib.sol";

library MessageLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;

    using UserLib for Types.UserStore;
    using RewardLib for Types.RewardStore;

    function afterUploadFile(Types.MessageStore storage self, address file_address, Types.UserStore storage users)
    public {
        address message_address = keccak256(abi.encodePacked(file_address, msg.sender, block.timestamp)).toAddress();

        self.following_upload[message_address] = Types.FollowingUploadMessage({
            user_address: msg.sender,
            file_address: file_address
        });

        address cursor = address(0x1);

        while (true) {
            cursor = users.user_info[msg.sender].followers.getNext(cursor);
            if (cursor == address(0x2)) break;
            users.user_info[cursor].following_upload_messages.append(message_address);
        }
    }

    function afterRewardResolved(Types.MessageStore storage self, address reward_address, address comment_address, Types.UserStore storage users, Types.RewardStore storage rewards)
    public {
        address message_address = keccak256(abi.encodePacked(reward_address, comment_address, msg.sender, block.timestamp)).toAddress();

        self.marked_reward_solved[message_address] = Types.MarkedRewardSolvedMessage({
            reward_address: reward_address,
            comment_address: comment_address
        });

        address cursor = address(0x1);

        while (true) {
            cursor = rewards.reward_info[reward_address].markers.getNext(cursor);
            if (cursor == address(0x2)) break;
            users.user_info[cursor].marked_reward_solved_messages.append(message_address);
        }
    }
}
