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
        require(users.user_info[msg.sender].login_timestamp==0);
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

    function follow(uint,address user_address)
    external {
        _registered_(msg.sender);
        _registered_(user_address);
        users.follow(user_address);
    }
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

