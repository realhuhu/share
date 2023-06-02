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
    using FileLib for Types.FileStore;
    using RewardLib for Types.RewardStore;


    function afterUploadFile(
        Types.MessageStore storage self,
        address file_address,
        Types.UserStore storage users
    ) public {
        address message_address = keccak256(abi.encodePacked(file_address, msg.sender, block.timestamp)).toAddress();

        self.following_upload[message_address] = Types.FollowingUploadMessage({
            user_address: msg.sender,
            file_address: file_address,
            timestamp: block.timestamp
        });

        address cursor = address(0x1);

        while (true) {
            cursor = users.user_info[msg.sender].followers.getNext(cursor);
            if (cursor == address(0x2)) break;
            users.user_info[cursor].following_upload_messages.append(message_address);
        }
    }

    function afterRewardResolved(
        Types.MessageStore storage self,
        address reward_address,
        address comment_address,
        Types.UserStore storage users,
        Types.RewardStore storage rewards
    ) public {
        address message_address = keccak256(abi.encodePacked(reward_address, comment_address, msg.sender, block.timestamp)).toAddress();

        self.marked_reward_solved[message_address] = Types.MarkedRewardSolvedMessage({
            reward_address: reward_address,
            comment_address: comment_address,
            timestamp: block.timestamp
        });

        address cursor = address(0x1);

        while (true) {
            cursor = rewards.reward_info[reward_address].markers.getNext(cursor);
            if (cursor == address(0x2)) break;
            users.user_info[cursor].marked_reward_solved_messages.append(message_address);
        }
    }

    function afterComment(
        Types.MessageStore storage self,
        address user_address,
        address reply_address,
        address target_address,
        address comment_address,
        address sub_comment_address,
        uint target_type,
        Types.UserStore storage users
    ) public {
        if (user_address == msg.sender) return;

        address message_address = keccak256(abi.encodePacked(target_address, comment_address, sub_comment_address, msg.sender, block.timestamp)).toAddress();

        self.reply[message_address] = Types.ReplyMessage({
            user_address: user_address,
            reply_address: reply_address,
            target_address: target_address,
            comment_address: comment_address,
            sub_comment_address: sub_comment_address,
            timestamp: block.timestamp,
            target_type: target_type
        });

        users.user_info[user_address].reply_messages.append(message_address);
    }

    function getReplyMessages(
        Types.MessageStore storage self,
        address cursor,
        Types.UserStore storage users,
        Types.FileStore storage files,
        Types.RewardStore storage rewards
    ) public view returns (Types.ReplyMessageInfo[10] memory reply_message_infos, address next, bool finished){
        address[10] memory reply_message_index_slice = users.user_info[msg.sender].reply_messages.slice(cursor, true);

        for (uint i = 0; i < 10; i++) {
            next = reply_message_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }

            Types.ReplyMessage storage reply_message = self.reply[next];
            string memory target;
            string memory content;

            if (reply_message.target_type == 0) {
                target = files.file_info[reply_message.target_address].title;
                content = files.file_info[reply_message.target_address].comment_info[reply_message.reply_address].content;
            } else if (reply_message.target_type == 1) {
                target = files.file_info[reply_message.target_address].comment_info[reply_message.comment_address].content;
                content = files.file_info[reply_message.target_address].comment_info[reply_message.comment_address].sub_comment_info[reply_message.reply_address].content;
            } else if (reply_message.target_type == 2) {
                target = files.file_info[reply_message.target_address].comment_info[reply_message.comment_address].sub_comment_info[reply_message.sub_comment_address].content;
                content = files.file_info[reply_message.target_address].comment_info[reply_message.comment_address].sub_comment_info[reply_message.reply_address].content;
            } else if (reply_message.target_type == 3) {
                target = rewards.reward_info[reply_message.target_address].title;
                content = rewards.reward_info[reply_message.target_address].comment_info[reply_message.reply_address].content;
            } else if (reply_message.target_type == 4) {
                target = rewards.reward_info[reply_message.target_address].comment_info[reply_message.comment_address].content;
                content = rewards.reward_info[reply_message.target_address].comment_info[reply_message.comment_address].sub_comment_info[reply_message.reply_address].content;
            } else if (reply_message.target_type == 5) {
                target = rewards.reward_info[reply_message.target_address].comment_info[reply_message.comment_address].sub_comment_info[reply_message.sub_comment_address].content;
                content = rewards.reward_info[reply_message.target_address].comment_info[reply_message.comment_address].sub_comment_info[reply_message.reply_address].content;
            }

            reply_message_infos[i] = Types.ReplyMessageInfo({
                target_address: reply_message.target_address,
                avatar: users.user_info[reply_message.user_address].avatar,
                target: target,
                content: content,
                nickname: users.user_info[reply_message.user_address].nickname,
                timestamp: block.timestamp,
                target_type: reply_message.target_type
            });
        }
    }


    function afterUp(
        Types.MessageStore storage self,
        address user_address,
        address target_address,
        address comment_address,
        address sub_comment_address,
        uint is_up,
        uint target_type,
        Types.UserStore storage users
    ) public {
        if (user_address == msg.sender) return;

        if (is_up == 0) return;

        address message_address = keccak256(abi.encodePacked(target_address, comment_address, sub_comment_address)).toAddress();

        if (self.up[message_address].user_address == address(0x0)) {

            self.up[message_address] = Types.UpMessage({
                user_address: msg.sender,
                target_address: target_address,
                comment_address: comment_address,
                sub_comment_address: sub_comment_address,
                num: 1,
                timestamp: block.timestamp,
                target_type: target_type
            });
            users.user_info[user_address].up_messages.append(message_address);
        } else {
            if (is_up == 1) {
                self.up[message_address].num++;
                self.up[message_address].user_address = msg.sender;
            } else if (is_up == 2) {
                self.up[message_address].num--;
            }

            if (self.up[message_address].num == 0) {
                users.user_info[user_address].up_messages.remove(message_address);
                delete self.up[message_address];
                return;
            }

            self.up[message_address].timestamp = block.timestamp;
            users.user_info[user_address].up_messages.moveBefore(address(0x2), message_address);
        }
    }

    function getUpMessages(
        Types.MessageStore storage self,
        address cursor,
        Types.UserStore storage users,
        Types.FileStore storage files,
        Types.RewardStore storage rewards
    ) public view returns (Types.UpMessageInfo[10] memory up_message_infos, address next, bool finished){
        address[10] memory up_message_index_slice = users.user_info[msg.sender].up_messages.slice(cursor, true);

        for (uint i = 0; i < 10; i++) {
            next = up_message_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }

            Types.UpMessage storage up_message = self.up[next];
            string memory content;

            if (up_message.target_type == 0) {
                content = files.file_info[up_message.target_address].title;
            } else if (up_message.target_type == 1) {
                content = files.file_info[up_message.target_address].comment_info[up_message.comment_address].content;
            } else if (up_message.target_type == 2) {
                content = files.file_info[up_message.target_address].comment_info[up_message.comment_address].sub_comment_info[up_message.sub_comment_address].content;
            } else if (up_message.target_type == 3) {
                content = rewards.reward_info[up_message.target_address].title;
            } else if (up_message.target_type == 4) {
                content = rewards.reward_info[up_message.target_address].comment_info[up_message.comment_address].content;
            } else if (up_message.target_type == 5) {
                content = rewards.reward_info[up_message.target_address].comment_info[up_message.comment_address].sub_comment_info[up_message.sub_comment_address].content;
            }

            up_message_infos[i] = Types.UpMessageInfo({
                target_address: up_message.target_address,
                avatar: users.user_info[up_message.user_address].avatar,
                content: content,
                nickname: users.user_info[up_message.user_address].nickname,
                num: up_message.num,
                target_type: up_message.target_type
            });
        }
    }
}
