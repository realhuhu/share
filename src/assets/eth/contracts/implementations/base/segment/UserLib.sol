// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Types.sol";
import "./FileLib.sol";

library UserUtils {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    function toSelfInfo(Types.User storage user)
    public view returns (Types.UserSelfInfo memory self_info){
        self_info = Types.UserSelfInfo({
            ID: user.ID,
            coins: user.coins,
            heart: user.heart,
            experience: user.experience,
            follower_num: user.followers.length,
            following_num: user.followings.length,
            login_timestamp: user.login_timestamp,
            uploaded_file_num: user.uploaded_files.length,
            major: user.major,
            avatar: user.avatar,
            nickname: user.nickname,
            signature: user.signature
        });
    }

    function toSimpleInfo(Types.User storage user, address user_address, Types.UserStore storage users)
    public view returns (Types.UserSimpleInfo memory simple_info){
        simple_info = Types.UserSimpleInfo({
            user_address: user.user_address,
            is_follower: users.user_info[msg.sender].followers.isContain(user_address),
            is_following: users.user_info[msg.sender].followings.isContain(user_address),
            major: user.major,
            avatar: user.avatar,
            nickname: user.nickname,
            signature: user.signature,
            heart: user.heart,
            medal_num: user.medals.length,
            experience: user.experience,
            follower_num: user.followers.length,
            uploaded_file_num: user.uploaded_files.length
        });
    }

    function toBriefInfo(Types.User storage user, address user_address, Types.UserStore storage users)
    public view returns (Types.UserBriefInfo memory brief_info){
        brief_info = Types.UserBriefInfo({
            user_address: user.user_address,
            is_follower: users.user_info[msg.sender].followers.isContain(user_address),
            is_following: users.user_info[msg.sender].followings.isContain(user_address),
            avatar: user.avatar,
            nickname: user.nickname,
            experience: user.experience
        });
    }
}

library UserLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    using UserUtils for *;

    function init(Types.UserStore storage self)
    public {
        self.user_index.init();
        self._user_by_heart.init();
        self._user_by_follower_num.init();
        self._user_by_medal_num.init();
    }

    function isRegistered(Types.UserStore storage self, address user_address)
    public view returns (bool is_registered){
        is_registered = self.user_info[user_address].login_timestamp != 0;
    }

    //注册账号
    function register(Types.UserStore storage self, string memory nickname)
    public {
        Types.User storage user = self.user_info[msg.sender];

        user.user_address = msg.sender;

        user.nickname = nickname;

        user.pits = 2;
        user.login_timestamp = block.timestamp;

        user.medals.init();
        user.rewards.init();
        user.followers.init();
        user.followings.init();
        user.up_messages.init();
        user.marked_files.init();
        user.marked_rewards.init();
        user.uploaded_files.init();
        user.reply_messages.init();
        user.purchased_files.init();
        user.following_upload_messages.init();
        user.marked_reward_solved_messages.init();

        self.user_index.append(msg.sender);
        self._user_by_heart.update(AddressOrderedMap.Item(msg.sender, 0));
        self._user_by_follower_num.update(AddressOrderedMap.Item(msg.sender, 0));
        self._user_by_medal_num.update(AddressOrderedMap.Item(msg.sender, 0));

    }

    //获取个人信息
    function getSelfInfo(Types.UserStore storage self)
    public view returns (Types.UserSelfInfo memory self_info){
        self_info = self.user_info[msg.sender].toSelfInfo();
    }

    function getOtherSimpleInfo(Types.UserStore storage self, address user_address)
    public view returns (Types.UserSimpleInfo memory simple_info){
        simple_info = self.user_info[user_address].toSimpleInfo(user_address, self);
    }

    function getOtherBriefInfo(Types.UserStore storage self, address user_address)
    public view returns (Types.UserBriefInfo memory brief_info){
        brief_info = self.user_info[user_address].toBriefInfo(user_address, self);
    }

    //更新头像
    function updateAvatar(Types.UserStore storage self, string memory avatar)
    public {
        self.user_info[msg.sender].avatar = avatar;
    }

    //更新姓名
    function updateNickname(Types.UserStore storage self, string memory nickname)
    public {
        self.user_info[msg.sender].nickname = nickname;
    }

    //更新签名
    function updateSignature(Types.UserStore storage self, string memory signature)
    public {
        self.user_info[msg.sender].signature = signature;
    }

    function follow(Types.UserStore storage self, address user_address)
    public {
        AddressLinkedList.T storage followings = self.user_info[msg.sender].followings;
        AddressLinkedList.T storage followers = self.user_info[user_address].followers;
        if (followings.isContain(user_address)) {
            followings.remove(user_address);
            followers.remove(msg.sender);
        } else {
            followings.append(user_address);
            followers.append(msg.sender);
        }
    }

    function getFollowers(Types.UserStore storage self, address cursor)
    public view returns (Types.UserBriefInfo[10] memory follower_infos, address next, bool finished){
        address[10] memory follower_index_slice = self.user_info[msg.sender].followers.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            next = follower_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            follower_infos[i] = getOtherBriefInfo(self, next);
        }
    }

    function getFollowings(Types.UserStore storage self, address cursor)
    public view returns (Types.UserBriefInfo[10] memory following_infos, address next, bool finished){
        address[10] memory following_index_slice = self.user_info[msg.sender].followings.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            next = following_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            following_infos[i] = getOtherBriefInfo(self, next);
        }
    }

    //上传文件后
    function afterUploadFile(Types.UserStore storage self, address file_address)
    public {
        self.user_info[msg.sender].uploaded_files.append(file_address);
    }

    //上传文件后
    function afterCreateReward(Types.UserStore storage self, address reward_address)
    public {
        self.user_info[msg.sender].rewards.append(reward_address);
    }

    function afterMarkFile(Types.UserStore storage self, address file_address, bool is_mark)
    public {
        if (is_mark) {
            self.user_info[msg.sender].marked_files.append(file_address);
        } else {
            self.user_info[msg.sender].marked_files.remove(file_address);
        }
    }

    function afterMarkReward(Types.UserStore storage self, address reward_address, bool is_mark)
    public {
        if (is_mark) {
            self.user_info[msg.sender].marked_rewards.append(reward_address);
        } else {
            self.user_info[msg.sender].marked_rewards.remove(reward_address);
        }
    }
}
