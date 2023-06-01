// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Types.sol";
import "./UserLib.sol";
import "./FileLib.sol";

library RewardUtils {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    using UserLib for Types.UserStore;
    using FileLib for Types.FileStore;

    function toBriefInfo(
        Types.Reward storage reward,
        Types.UserStore storage users
    ) public view returns (Types.RewardBriefInfo memory reward_info){
        reward_info = Types.RewardBriefInfo({
            reward_address: reward.reward_address,
            approved_comment: reward.approved_comment,
            cover: reward.images[0],
            title: reward.title,
            author: users.user_info[reward.author].nickname,
            description: reward.description,
            up_num: reward.up_num,
            down_num: reward.down_num,
            up_and_down: reward.up_and_downs[msg.sender],
            comment_num: reward.comment_num,
            remuneration: reward.remuneration,
            update_timestamp: reward.update_timestamp
        });
    }

    function toDetailInfo(
        Types.Reward storage reward
    ) public view returns (Types.RewardDetailInfo memory detail_info){
        detail_info = Types.RewardDetailInfo({
            author: reward.author,
            reward_address: reward.reward_address,
            approved_comment: reward.approved_comment,
            is_mark: reward.markers.isContain(msg.sender),
            title: reward.title,
            description: reward.description,
            images: reward.images,
            up_num: reward.up_num,
            down_num: reward.down_num,
            mark_num: reward.markers.length,
            up_and_down: reward.up_and_downs[msg.sender],
            comment_num: reward.comment_num,
            remuneration: reward.remuneration,
            create_timestamp: reward.create_timestamp,
            update_timestamp: reward.update_timestamp
        });
    }

    function toRootComment(
        Types.RewardComment storage comment,
        Types.UserStore storage users,
        Types.FileStore storage files
    ) public view returns (Types.RewardRootComment memory root_comment)  {
        Types.RewardChildrenComment[2] memory children_comments;

        address current = address(0x1);

        for (uint i = 0; i < 2; i++) {
            current = comment.sub_comment_index.getNext(current);
            if (current == address(0x2)) break;
            children_comments[i] = toChildrenComment(comment.sub_comment_info[current], comment, users);
        }

        root_comment = Types.RewardRootComment({
            comment_address: comment.comment_address,
            file_info: files.getBriefInfo(comment.file_address, users),
            children_comments: children_comments,
            content: comment.content,
            images: comment.images,
            author: users.getOtherBriefInfo(comment.author),
            up_num: comment.up_num,
            down_num: comment.down_num,
            up_and_down: comment.up_and_downs[msg.sender],
            comment_num: comment.sub_comment_index.length,
            comment_timestamp: comment.comment_timestamp
        });
    }

    function toChildrenComment(
        Types.RewardSubComment storage sub_comment,
        Types.RewardComment storage comment,
        Types.UserStore storage users
    ) public view returns (Types.RewardChildrenComment memory children_comment){
        children_comment = Types.RewardChildrenComment({
            target_address: sub_comment.target_address,
            comment_address: sub_comment.comment_address,
            sub_comment_address: sub_comment.sub_comment_address,
            content: sub_comment.content,
            author: users.getOtherBriefInfo(sub_comment.author),
            target_author: users.getOtherBriefInfo(comment.sub_comment_info[sub_comment.target_address].author),
            up_num: sub_comment.up_num,
            down_num: sub_comment.down_num,
            up_and_down: sub_comment.up_and_downs[msg.sender],
            comment_timestamp: sub_comment.comment_timestamp
        });
    }
}

library RewardLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;

    using UserLib for Types.UserStore;
    using FileLib for Types.FileStore;

    using RewardUtils for *;

    function init(Types.RewardStore storage self)
    public {
        self.reward_index.init();
        self._reward_by_up_num.init();
        self._reward_by_update_time.init();
        self._reward_by_remuneration.init();
    }

    function isContain(Types.RewardStore storage self, address reward_address)
    public view returns (bool is_contain) {
        is_contain = self.reward_index.isContain(reward_address);
    }

    function create(
        Types.RewardStore storage self,
        string memory title,
        string memory description,
        string[3] memory images,
        uint remuneration
    ) public returns (address reward_address) {
        reward_address = keccak256(abi.encodePacked(title, msg.sender, block.timestamp)).toAddress();

        Types.Reward storage reward_info = self.reward_info[reward_address];

        reward_info.author = msg.sender;
        reward_info.reward_address = reward_address;

        reward_info.title = title;
        reward_info.description = description;

        reward_info.images = images;

        reward_info.remuneration = remuneration;

        reward_info.create_timestamp = block.timestamp;
        reward_info.update_timestamp = block.timestamp;

        reward_info.markers.init();
        reward_info.comment_index.init();
        reward_info._comments_by_up_num.init();

        self.reward_index.append(reward_address);
        self._reward_by_up_num.update(AddressOrderedMap.Item(reward_address, 0));
        self._reward_by_update_time.update(AddressOrderedMap.Item(reward_address, 0));
        self._reward_by_remuneration.update(AddressOrderedMap.Item(reward_address, remuneration));
    }


    function getDetailInfo(Types.RewardStore storage self, address reward_address)
    public view returns (Types.RewardDetailInfo memory detail_info){
        detail_info = self.reward_info[reward_address].toDetailInfo();
    }

    function getBriefInfos(
        Types.RewardStore storage self,
        address cursor,
        uint solved,
        uint order,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = self._reward_by_up_num.get(cursor, !reverse);
            } else if (order == 2) {
                cursor = self._reward_by_update_time.get(cursor, !reverse);
            } else if (order == 3) {
                cursor = self._reward_by_remuneration.get(cursor, !reverse);
            } else {
                cursor = self.reward_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            bool is_solved = self.reward_info[cursor].approved_comment != address(0x0);

            if (is_solved && solved == 1 || !is_solved && solved == 2 || solved == 0) {
                reward_infos[index] = self.reward_info[cursor].toBriefInfo(users);
                index++;
            }

            next = cursor;
        }
    }

    function getUserBriefInfos(
        Types.RewardStore storage self,
        address user_address,
        address cursor,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        address[10] memory reward_index_slice = users.user_info[user_address].rewards.slice(cursor, reverse);

        for (uint i = 0; i < 10; i++) {
            next = reward_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            reward_infos[i] = self.reward_info[next].toBriefInfo(users);
        }
    }

    function getSelfBriefInfos(
        Types.RewardStore storage self,
        address cursor,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        address[10] memory reward_index_slice = users.user_info[msg.sender].rewards.slice(cursor, reverse);

        for (uint i = 0; i < 10; i++) {
            next = reward_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            reward_infos[i] = self.reward_info[next].toBriefInfo(users);
        }
    }

    function upAndDown(Types.RewardStore storage self, address reward_address, bool is_up)
    public {
        Types.Reward storage reward = self.reward_info[reward_address];
        uint up_and_down = reward.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, reward.up_num, reward.down_num, is_up);

        reward.up_and_downs[msg.sender] = _up_and_down;
        reward.up_num = _up_num;
        reward.down_num = _down_num;

        self._reward_by_up_num.update(AddressOrderedMap.Item(reward_address, reward.up_num));
    }

    function addComment(
        Types.RewardStore storage self,
        address reward_address,
        address file_address,
        string memory content,
        string[3] memory images
    ) public {
        Types.Reward storage reward = self.reward_info[reward_address];

        address comment_address = keccak256(abi.encodePacked(reward_address, content, msg.sender, block.timestamp)).toAddress();

        Types.RewardComment storage comment = reward.comment_info[comment_address];

        comment.author = msg.sender;
        comment.file_address = file_address;
        comment.comment_address = comment_address;

        comment.content = content;
        comment.images = images;

        comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.init();

        reward.comment_num++;
        reward.update_timestamp = block.timestamp;
        reward.comment_index.append(comment_address);
        reward._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, reward.comment_num));
    }

    function upAndDownComment(
        Types.RewardStore storage self,
        address reward_address,
        address comment_address,
        bool is_up
    ) public {
        Types.RewardComment storage comment = self.reward_info[reward_address].comment_info[comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];


        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;

        self.reward_info[reward_address]._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, comment.up_num));
    }

    function addSubComment(
        Types.RewardStore storage self,
        address reward_address,
        address target_address,
        address comment_address,
        string memory content
    ) public {
        Types.Reward storage reward = self.reward_info[reward_address];
        Types.RewardComment storage comment = reward.comment_info[comment_address];

        address sub_comment_address = keccak256(abi.encodePacked(reward_address, comment_address, content, msg.sender, block.timestamp)).toAddress();

        Types.RewardSubComment storage sub_comment = comment.sub_comment_info[sub_comment_address];

        sub_comment.author = msg.sender;
        sub_comment.target_address = target_address;
        sub_comment.comment_address = comment_address;
        sub_comment.sub_comment_address = sub_comment_address;

        sub_comment.content = content;

        sub_comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.append(sub_comment_address);

        reward.comment_num++;
        reward.update_timestamp = block.timestamp;
    }

    function upAndDownSubComment(
        Types.RewardStore storage self,
        address reward_address,
        address comment_address,
        address sub_comment_address,
        bool is_up
    ) public {
        Types.RewardSubComment storage comment = self.reward_info[reward_address].comment_info[comment_address].sub_comment_info[sub_comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;
    }

    function getRootComments(
        Types.RewardStore storage self,
        address reward_address,
        address cursor,
        uint order,
        bool reverse,
        Types.UserStore storage users,
        Types.FileStore storage files
    ) public view returns (Types.RewardRootComment[10] memory root_comments, address next, bool finished){
        Types.Reward storage reward = self.reward_info[reward_address];

        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = reward._comments_by_up_num.get(cursor, !reverse);
            } else {
                cursor = reward.comment_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            if (order == 3 && reward.comment_info[cursor].file_address == address(0x0)) continue;

            root_comments[index] = reward.comment_info[cursor].toRootComment(users, files);
            index++;
            next = cursor;
        }
    }

    function getChildrenComments(
        Types.RewardStore storage self,
        address reward_address,
        address comment_address,
        address cursor,
        Types.UserStore storage users
    ) public view returns (Types.RewardChildrenComment[10] memory children_comments, address next, bool finished) {
        Types.RewardComment storage comment = self.reward_info[reward_address].comment_info[comment_address];

        uint index = 0;
        while (index < 10) {
            cursor = comment.sub_comment_index.getNext(cursor);

            if (cursor == address(0x2)) {
                finished = true;
                break;
            }

            children_comments[index] = comment.sub_comment_info[cursor].toChildrenComment(comment, users);
            index++;
            next = cursor;
        }
    }

    function mark(
        Types.RewardStore storage self,
        address reward_address
    ) public returns (bool is_mark){
        Types.Reward storage reward = self.reward_info[reward_address];

        if (reward.markers.isContain(msg.sender)) {
            is_mark = false;
            reward.markers.remove(msg.sender);
        } else {
            is_mark = true;
            reward.markers.append(msg.sender);
        }
    }

    function getMarked(Types.RewardStore storage self, address cursor, Types.UserStore storage users)
    public view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        address[10] memory reward_index_slice = users.user_info[msg.sender].marked_rewards.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            next = reward_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            reward_infos[i] = self.reward_info[next].toBriefInfo(users);
        }
    }
}

