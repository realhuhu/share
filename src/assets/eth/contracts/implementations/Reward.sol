//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface RewardInterface {
    function RewardContact_init(uint) external;

    function createReward(uint, string memory title, string memory description, string[3] memory images, uint remuneration) external;

    function getRewardBriefInfos(uint, address cursor, uint solved, uint order, bool reverse) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);

    function getUserRewardBriefInfos(uint, address user_address, address cursor, bool reverse) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);

    function getSelfRewardBriefInfos(uint, address cursor, bool reverse) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);

    function getRewardDetailInfo(uint, address reward_address) external view returns (Types.RewardDetailInfo memory detail_info);

    function upAndDownReward(uint, address reward_address, bool is_up) external;

    function addRewardComment(uint, address reward_address, address file_address, string memory content, string[3] memory images) external;

    function upAndDownRewardComment(uint, address reward_address, address comment_address, bool is_up) external;

    function addRewardSubComment(uint, address reward_address, address target_address, address comment_address, string memory content) external;

    function upAndDownRewardSubComment(uint, address reward_address, address comment_address, address sub_comment_address, bool is_up) external;

    function getRewardRootComments(uint, address reward_address, address cursor, uint order, bool reverse) external view returns (Types.RewardRootComment[10] memory root_comments, address next, bool finished);

    function getRewardChildrenComments(uint, address reward_address, address comment_address, address cursor) external view returns (Types.RewardChildrenComment[10] memory children_comments, address next, bool finished);

    function markReward(uint, address reward_address) external;

    function getMarkedRewards(uint, address cursor) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);
}

contract RewardContact is BaseContact, RewardInterface {
    using UserLib for Types.UserStore;
    using RewardLib for Types.RewardStore;
    using MessageLib for Types.MessageStore;

    function RewardContact_init(uint)
    _onlyAdmin_
    external {
        rewards.init();
    }

    function createReward(uint, string memory title, string memory description, string[3] memory images, uint remuneration)
    external {
        address reward_address = rewards.create(title, description, images, remuneration);
        users.afterCreateReward(reward_address);
    }

    function getSelfRewardBriefInfos(uint, address cursor, bool reverse)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getSelfBriefInfos(cursor, reverse, users);
    }

    function getRewardBriefInfos(uint, address cursor, uint solved, uint order, bool reverse)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getBriefInfos(cursor, solved, order, reverse, users);
    }

    function getUserRewardBriefInfos(uint, address user_address, address cursor, bool reverse)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getUserBriefInfos(user_address, cursor, reverse, users);
    }


    function getRewardDetailInfo(uint, address reward_address)
    external view returns (Types.RewardDetailInfo memory detail_info){
        detail_info = rewards.getDetailInfo(reward_address);
    }

    function upAndDownReward(uint, address reward_address, bool is_up)
    external {
        _published_(reward_address);
        address user_address;
        uint _is_up;
        (user_address, _is_up) = rewards.upAndDown(reward_address, is_up);
        messages.afterUp(user_address, reward_address, address(0x0), address(0x0), _is_up, 3, users);
    }

    function addRewardComment(uint, address reward_address, address file_address, string memory content, string[3] memory images)
    external {
        _published_(reward_address);
        address user_address;
        address reply_address;
        (user_address, reply_address) = rewards.addComment(reward_address, file_address, content, images);
        messages.afterComment(user_address, reply_address, reward_address, address(0x0), address(0x0), 3, users);
    }

    function upAndDownRewardComment(uint, address reward_address, address comment_address, bool is_up)
    external {
        _reward_commented_(reward_address, comment_address);
        address user_address;
        uint _is_up;
        (user_address, _is_up) = rewards.upAndDownComment(reward_address, comment_address, is_up);
        messages.afterUp(user_address, reward_address, comment_address, address(0x0), _is_up, 4, users);
    }

    function addRewardSubComment(uint, address reward_address, address target_address, address comment_address, string memory content)
    external {
        _reward_commented_(reward_address, comment_address);
        address user_address;
        uint _target_type;
        address reply_address;
        (user_address, _target_type, reply_address) = rewards.addSubComment(reward_address, target_address, comment_address, content);
        messages.afterComment(user_address, reply_address, reward_address, comment_address, target_address, _target_type, users);
    }

    function upAndDownRewardSubComment(uint, address reward_address, address comment_address, address sub_comment_address, bool is_up)
    external {
        _reward_sub_commented_(reward_address, comment_address, sub_comment_address);
        address user_address;
        uint _is_up;
        (user_address, _is_up) = rewards.upAndDownSubComment(reward_address, comment_address, sub_comment_address, is_up);
        messages.afterUp(user_address, reward_address, comment_address, sub_comment_address, _is_up, 5, users);
    }

    function getRewardRootComments(uint, address reward_address, address cursor, uint order, bool reverse)
    external view returns (Types.RewardRootComment[10] memory root_comments, address next, bool finished){
        (root_comments, next, finished) = rewards.getRootComments(reward_address, cursor, order, reverse, users, files);
    }

    function getRewardChildrenComments(uint, address reward_address, address comment_address, address cursor)
    external view returns (Types.RewardChildrenComment[10] memory children_comments, address next, bool finished){
        (children_comments, next, finished) = rewards.getChildrenComments(reward_address, comment_address, cursor, users);
    }

    function markReward(uint, address reward_address)
    external {
        _published_(reward_address);
        bool is_mark = rewards.mark(reward_address);
        users.afterMarkReward(reward_address, is_mark);
    }

    function getMarkedRewards(uint, address cursor)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getMarked(cursor, users);
    }

}
