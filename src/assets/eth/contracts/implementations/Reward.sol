//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface RewardInterface {
    function createReward(string memory title, string memory description, string[3] memory images, uint remuneration) external;

    function getSelfRewardBriefInfos(address cursor, bool reverse) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);

    function getRewardDetailInfo(address reward_address) external view returns (Types.RewardDetailInfo memory detail_info);

    function getRewardBriefInfos(address cursor, uint solved, uint order, bool reverse) external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished);
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

        address reward_address = rewards.createReward(title, description, images, remuneration);

        users.afterCreateReward(reward_address);
    }

    function getSelfRewardBriefInfos(address cursor, bool reverse)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getSelfRewardBriefInfos(cursor, reverse, users);
    }

    function getRewardBriefInfos(address cursor, uint solved, uint order, bool reverse)
    external view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        (reward_infos, next, finished) = rewards.getRewardBriefInfos(cursor, solved, order, reverse, users);
    }

    function getRewardDetailInfo(address reward_address)
    external view returns (Types.RewardDetailInfo memory detail_info){
        detail_info = rewards.getRewardDetailInfo(reward_address);
    }
}
