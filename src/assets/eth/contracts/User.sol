// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Lib.sol";

contract UserContract {
    using AddressLinkedList for AddressLinkedList.T;

    address public admin; // 管理员

    struct UserInfo {
        string avatar; // 头像
        string nickname; // 昵称
        string signature; //签名
        uint login_timestamp;
        AddressLinkedList.T followings; //我的关注
        AddressLinkedList.T followers; //关注我的
        uint ID; // 校园卡ID
        string major; // 专业
        uint heart; // 热心值
    }

    struct UserSelfInfo {
        string avatar;
        string nickname;
        string signature;
        uint login_timestamp;
        uint following_num;
        uint follower_num;
        uint ID;
        string major;
        uint heart;
    }

    struct UserBriefInfo {
        string avatar;
        string nickname;
        string signature;
        uint login_timestamp;
        uint following_num;
        uint follower_num;
        uint heart;
    }

    struct UserSimpleInfo {
        string avatar;
        string nickname;
    }

    mapping(address => UserInfo) users; // 所有用户

    constructor(){
        admin = msg.sender;
    }

    // 是否已注册
    modifier _registered_(address user_address) {
        require(users[user_address].login_timestamp != 0, "E0: User.sol>UserContract>_registered_");
        _;
    }

    // 是否未注册
    modifier _notRegistered_(address user_address) {
        require(users[user_address].login_timestamp == 0, "E1: User.sol>UserContract>_notRegistered_");
        _;
    }

    // 注册账号
    function register(string memory nickname)
    _notRegistered_(msg.sender)
    public returns (UserSelfInfo memory self_info) {
        UserInfo storage user_info = users[msg.sender];

        user_info.nickname = nickname;
        user_info.followers.init();
        user_info.followings.init();
        user_info.login_timestamp = block.timestamp;
        self_info = getSelfInfo();
    }

    // 判断账号是否已注册
    function isRegistered(address user_address)
    public view returns (bool is_registered){
        is_registered = users[user_address].login_timestamp != 0;
    }

    // 获取个人信息
    function getSelfInfo()
    _registered_(msg.sender)
    public view returns (UserSelfInfo memory self_info){
        UserInfo storage user_info = users[msg.sender];

        self_info = UserSelfInfo({
            avatar: user_info.avatar,
            nickname: user_info.nickname,
            signature: user_info.signature,
            login_timestamp: user_info.login_timestamp,
            following_num: user_info.followings.length,
            follower_num: user_info.followers.length,
            ID: user_info.ID,
            major: user_info.major,
            heart: user_info.heart
        });
    }

    // 获取其它用户的详细信息
    function getUserInfo(address user_address)
    _registered_(user_address)
    public view returns (UserBriefInfo memory user_info){
        UserInfo storage user = users[user_address];
        user_info = UserBriefInfo({
            avatar: user.avatar,
            nickname: user.nickname,
            signature: user.signature,
            login_timestamp: user_info.login_timestamp,
            following_num: user.followings.length,
            follower_num: user.followers.length,
            heart: user.heart
        });
    }

    // 获取我关注的用户的摘要信息
    function getFollowings(address cursor)
    _registered_(msg.sender)
    public view returns (UserSimpleInfo[10] memory followings_info, uint length){
        AddressLinkedList.T storage followings = users[msg.sender].followings;
        length = followings.length;
        address[10] memory followings_address = followings.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            UserInfo storage following = users[followings_address[i]];
            followings_info[i] = UserSimpleInfo({
                avatar: following.avatar,
                nickname: following.nickname
            });
        }
    }

    // 获取关注我的用户的摘要信息
    function getFollowers(address cursor)
    _registered_(msg.sender)
    public view returns (UserSimpleInfo[10] memory followers_info, uint length){
        AddressLinkedList.T storage followers = users[msg.sender].followers;
        length = followers.length;
        address[10] memory followers_address = users[msg.sender].followers.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            UserInfo storage follower = users[followers_address[i]];
            followers_info[i] = UserSimpleInfo({
                avatar: follower.avatar,
                nickname: follower.nickname
            });
        }
    }

    // 关注或取关用户
    function setFollow(address target_user, bool is_follow)
    _registered_(msg.sender)
    _registered_(target_user)
    public {
        AddressLinkedList.T storage followings = users[msg.sender].followings;
        AddressLinkedList.T storage followers = users[target_user].followers;
        if (is_follow && !followings.contain(target_user)) {
            followings.append(target_user);
            followers.append(msg.sender);
        } else if (!is_follow && followings.contain(target_user)) {
            followings.remove(target_user);
            followers.remove(msg.sender);
        }
    }
}
