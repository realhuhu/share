//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface UserInterface {
    function UserContract_init(uint) external;

    function register(uint, string memory nickname) external;

    function isRegistered(uint, address user_address) external view returns (bool is_registered);

    function getSelfInfo(uint) external view returns (Types.UserSelfInfo memory self_info);

    function getOtherSimpleInfo(uint, address user_address) external view returns (Types.UserSimpleInfo memory simple_info);

    function updateAvatar(uint, string memory avatar) external;

    function updateNickname(uint, string memory nickname) external;

    function updateSignature(uint, string memory signature) external;

    function follow(uint, address user_address) external;

    function getFollowers(uint, address cursor) external view returns (Types.UserBriefInfo[10] memory follower_infos, address next, bool finished);

    function getFollowings(uint, address cursor) external view returns (Types.UserBriefInfo[10] memory following_infos, address next, bool finished);
}

contract UserContract is BaseContact, UserInterface {
    using UserLib for Types.UserStore;

    function UserContract_init(uint)
    _onlyAdmin_
    external {
        users.init();
    }

    //判断账号是否已注册
    function isRegistered(uint, address user_address)
    external view returns (bool is_registered){
        is_registered = users.isRegistered(user_address);
    }

    //注册账号
    function register(uint, string memory nickname)
    external {
        require(users.user_info[msg.sender].login_timestamp == 0);
        users.register(nickname);
    }

    //获取个人信息
    function getSelfInfo(uint)
    external view returns (Types.UserSelfInfo memory self_info){
        self_info = users.getSelfInfo();
    }

    //获取其它用户的信息
    function getOtherSimpleInfo(uint, address user_address)
    external view returns (Types.UserSimpleInfo memory simple_info){
        simple_info = users.getOtherSimpleInfo(user_address);
    }

    //更新头像
    function updateAvatar(uint, string memory avatar)
    external {
        _registered_(msg.sender);
        users.updateAvatar(avatar);
    }

    //更新姓名
    function updateNickname(uint, string memory nickname)
    external {
        _registered_(msg.sender);
        users.updateNickname(nickname);
    }

    //更新签名
    function updateSignature(uint, string memory signature)
    external {
        _registered_(msg.sender);
        users.updateSignature(signature);
    }

    function follow(uint, address user_address)
    external {
        require(user_address != msg.sender);
        _registered_(msg.sender);
        _registered_(user_address);
        users.follow(user_address);
    }

    function getFollowers(uint, address cursor)
    external view returns (Types.UserBriefInfo[10] memory follower_infos, address next, bool finished){
        (follower_infos, next, finished) = users.getFollowers(cursor);
    }

    function getFollowings(uint, address cursor)
    external view returns (Types.UserBriefInfo[10] memory following_infos, address next, bool finished){
        (following_infos, next, finished) = users.getFollowings(cursor);
    }
}

