//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface RewardInterface {
    function createReward(string memory title, string memory description, string[3] memory images, uint remuneration) external;

    function getSelfRewardBriefInfos(address cursor, bool reverse) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);

    function getRewardBriefInfos(address cursor, uint solved, uint order, bool reverse) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);

    function getRewardDetailInfo(address reward_address) external view returns (Types.RewardDetailInfo memory detail_info);

    function upAndDownReward(address reward_address, bool is_up) external;

    function addRewardComment(address reward_address, address file_address, string memory content, string[3] memory images) external;

    function upAndDownRewardComment(address reward_address, address comment_address, bool is_up) external;

    function addRewardSubComment(address reward_address, address target_address, address comment_address, string memory content) external;

    function upAndDownRewardSubComment(address reward_address, address comment_address, address sub_comment_address, bool is_up) external;

    function getRewardRootComments(address reward_address, address cursor, uint order, bool reverse) external view returns (Types.RewardRootComment[10] memory root_comments, address next, bool finished);

    function getRewardChildrenComments(address reward_address, address comment_address, address cursor) external view returns (Types.RewardChildrenComment[10] memory children_comments, address next, bool finished);

}

abstract contract RewardContact is BaseContact, RewardInterface {
    using UintLib for uint;
    using StringLib for string;

    using UserLib for Types.UserStore;
    using RewardLib for Types.RewardStore;

    function RewardContract_init()
    internal {
        rewards.init();
    }

    function createReward(
        string memory title,
        string memory description,
        string[3] memory images,
        uint remuneration
    ) external {
        title._range_(1, 64);
        description._range_(1, 512);
        remuneration._range_(1, 20);

        address reward_address = rewards.create(title, description, images, remuneration);

        users.afterCreateReward(reward_address);
    }

    function getSelfRewardBriefInfos(address cursor, bool reverse)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getSelfBriefInfos(cursor, reverse, users);
    }

    function getRewardBriefInfos(address cursor, uint solved, uint order, bool reverse)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getBriefInfos(cursor, solved, order, reverse, users);
    }

    function getRewardDetailInfo(address reward_address)
    external view returns (Types.RewardDetailInfo memory detail_info){
        detail_info = rewards.getDetailInfo(reward_address);
    }

    function upAndDownReward(address reward_address, bool is_up)
    external {
        rewards.upAndDown(reward_address, is_up);
    }

    function addRewardComment(address reward_address, address file_address, string memory content, string[3] memory images)
    external {
        rewards.addComment(reward_address, file_address, content, images);
    }

    function upAndDownRewardComment(address reward_address, address comment_address, bool is_up)
    external {
        rewards.upAndDownComment(reward_address, comment_address, is_up);
    }

    function addRewardSubComment(address reward_address, address target_address, address comment_address, string memory content)
    external {
        rewards.addSubComment(reward_address, target_address, comment_address, content);
    }

    function upAndDownRewardSubComment(address reward_address, address comment_address, address sub_comment_address, bool is_up)
    external {
        rewards.upAndDownSubComment(reward_address, comment_address, sub_comment_address, is_up);
    }

    function getRewardRootComments(address reward_address, address cursor, uint order, bool reverse)
    external view returns (Types.RewardRootComment[10] memory root_comments, address next, bool finished){
        (root_comments, next, finished) = rewards.getRootComments(reward_address, cursor, order, reverse, users, files);
    }

    function getRewardChildrenComments(address reward_address, address comment_address, address cursor)
    external view returns (Types.RewardChildrenComment[10] memory children_comments, address next, bool finished){
        (children_comments, next, finished) = rewards.getChildrenComments(reward_address, comment_address, cursor, users);
    }
}
