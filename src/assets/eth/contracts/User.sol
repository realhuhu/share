// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Lib.sol";

contract UserContract {
    using AddressLinkedList for AddressLinkedList.T;

    struct UserInfo {
        string avatar; // 头像
        string nickname; // 昵称
        string signature; //签名
        AddressLinkedList.T followings; //我的关注
        AddressLinkedList.T followers; //关注我的
        uint ID; // 校园卡ID
        string major; // 专业
    }

    struct UserSelfInfo {
        string avatar; // 头像
        string nickname; // 昵称
        string signature; //签名
        uint following_num; //我的关注
        uint follower_num; //关注我的
        uint ID; // 校园卡ID
        string major; // 专业
    }

    struct UserBriefInfo {
        string avatar; // 头像
        string nickname; // 昵称
        string signature; //签名
        uint following_num; //我的关注
        uint follower_num; //关注我的
    }

    struct UserSimpleInfo {
        string avatar; // 头像
        string nickname; // 昵称
    }

    mapping(address => UserInfo) users;
    mapping(address => bool) _users_bit;

    modifier _registered_(address user) {
        require(_users_bit[user], "E0: User.sol>UserContract>_registered_");
        _;
    }

    modifier _notRegistered_(address user) {
        require(!_users_bit[user], "E1: User.sol>UserContract>_notRegistered_");
        _;
    }


    function register(string memory nickname) _notRegistered_(msg.sender)
    public returns (UserSelfInfo memory self_info) {
        UserInfo storage user_info = users[msg.sender];
        _users_bit[msg.sender] = true;

        user_info.nickname = nickname;
        user_info.followers.init();
        user_info.followings.init();
        self_info = getSelfInfo();
    }

    function isRegistered(address user_address)
    public view returns (bool is_registered){
        is_registered = _users_bit[user_address];
    }

    function getSelfInfo() _registered_(msg.sender)
    public view returns (UserSelfInfo memory self_info){
        UserInfo storage user_info = users[msg.sender];

        self_info = UserSelfInfo({
            avatar: user_info.avatar,
            nickname: user_info.nickname,
            signature: user_info.signature,
            following_num: user_info.followings.length,
            follower_num: user_info.followers.length,
            ID: user_info.ID,
            major: user_info.major
        });
    }

    function getUserInfo(address user_address) _registered_(user_address)
    public view returns (UserBriefInfo memory user_info){
        UserInfo storage user = users[user_address];
        user_info = UserBriefInfo({
            avatar: user.avatar,
            nickname: user.nickname,
            signature: user.signature,
            following_num: user.followings.length,
            follower_num: user.followers.length
        });
    }

    function getFollowings(address cursor) _registered_(msg.sender)
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

    function getFollowers(address cursor) _registered_(msg.sender)
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

    function setFollow(address target_user, bool is_follow) _registered_(msg.sender) _registered_(target_user)
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
