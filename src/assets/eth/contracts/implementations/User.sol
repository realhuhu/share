//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface UserInterface {
    function register(string memory nickname) external;

    function isRegistered(address user_address) external view returns (bool is_registered);

    function getSelfInfo() external view returns (Types.UserSelfInfo memory self_info);

    function getOtherSimpleInfo(address user_address) external view returns (Types.UserSimpleInfo memory simple_info);

    function updateAvatar(string memory avatar) external;

    function updateNickname(string memory nickname) external;

    function updateSignature(string memory signature) external;

    //    function getUserInfo(address user_address) external view returns (StoreContact.UserBriefInfo memory user_info);
    //
    //    function getFollowings(address cursor) external view returns (StoreContact.UserSimpleInfo[10] memory followings_info, uint length);
    //
    //    function getFollowers(address cursor) external view returns (StoreContact.UserSimpleInfo[10] memory followers_info, uint length);
    //
    //    function getMedals(address cursor) external view returns (address[10] memory followers_info, uint length);
    //
    //    function setFollow(address target_user, bool is_follow) external;
}

abstract contract UserContract is BaseContact, UserInterface {
    using UserLib for Types.UserStore;

    function UserContract_init()
    internal {
        users.init();
    }

    //判断账号是否已注册
    function isRegistered(address user_address)
    external view returns (bool is_registered){
        is_registered = users.isRegistered(user_address);
    }

    //注册账号
    function register(string memory nickname)
    external {
        users.register(nickname);
    }

    //获取个人信息
    function getSelfInfo()
    external view returns (Types.UserSelfInfo memory self_info){
        self_info = users.getSelfInfo();
    }

    function getOtherSimpleInfo(address user_address)
    external view returns (Types.UserSimpleInfo memory simple_info){
        simple_info = users.getOtherSimpleInfo(user_address);
    }

    //更新头像
    function updateAvatar(string memory avatar)
    external {
        users.updateAvatar(avatar);
    }

    //更新姓名
    function updateNickname(string memory nickname)
    external {
        users.updateNickname(nickname);
    }

    //更新签名
    function updateSignature(string memory signature)
    external {
        users.updateSignature(signature);
    }

    //    //获取其它用户的详细信息
    //    function getUserInfo(address user_address)
    //    _registered_(user_address)
    //    external view returns (UserBriefInfo memory user_info){
    //        UserInfo storage user = users.user_info[user_address];
    //        user_info = UserBriefInfo({
    //            avatar: user.avatar,
    //            nickname: user.nickname,
    //            signature: user.signature,
    //            login_timestamp: user_info.login_timestamp,
    //            following_num: user.followings.length,
    //            follower_num: user.followers.length,
    //            heart: user.heart
    //        });
    //    }
    //
    //    //获取我关注的用户的摘要信息
    //    function getFollowings(address cursor)
    //    _registered_(msg.sender)
    //    external view returns (UserSimpleInfo[10] memory followings_info, uint length){
    //        AddressLinkedList.T storage followings = users.user_info[msg.sender].followings;
    //        length = followings.length;
    //        address[10] memory followings_address = followings.slice(cursor, false);
    //        for (uint i = 0; i < 10; i++) {
    //            UserInfo storage following = users.user_info[followings_address[i]];
    //            followings_info[i] = UserSimpleInfo({
    //                avatar: following.avatar,
    //                nickname: following.nickname
    //            });
    //        }
    //    }
    //
    //    //获取我的粉丝的摘要信息
    //    function getFollowers(address cursor)
    //    _registered_(msg.sender)
    //    external view returns (UserSimpleInfo[10] memory followers_info, uint length){
    //        AddressLinkedList.T storage followers = users.user_info[msg.sender].followers;
    //        length = followers.length;
    //        address[10] memory followers_address = users.user_info[msg.sender].followers.slice(cursor, false);
    //        for (uint i = 0; i < 10; i++) {
    //            UserInfo storage follower = users.user_info[followers_address[i]];
    //            followers_info[i] = UserSimpleInfo({
    //                avatar: follower.avatar,
    //                nickname: follower.nickname
    //            });
    //        }
    //    }
    //
    //    //获取我的勋章
    //    function getMedals(address cursor)
    //    _registered_(msg.sender)
    //    external view returns (address[10] memory medals, uint length){
    //        medals = users.user_info[msg.sender].medals.slice(cursor, false);
    //        length = users.user_info[msg.sender].medals.length;
    //    }
    //
    //    //关注或取关用户
    //    function setFollow(address target_user, bool is_follow)
    //    _registered_(msg.sender)
    //    _registered_(target_user)
    //    external {
    //        AddressLinkedList.T storage followings = users.user_info[msg.sender].followings;
    //        AddressLinkedList.T storage followers = users.user_info[target_user].followers;
    //        if (is_follow && !followings.isContain(target_user)) {
    //            followings.append(target_user);
    //            followers.append(msg.sender);
    //        } else if (!is_follow && followings.isContain(target_user)) {
    //            followings.remove(target_user);
    //            followers.remove(msg.sender);
    //        }
    //    }
}
