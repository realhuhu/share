// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "../../utils/AddressLinkedList.sol";
import "../../utils/AddressOrderedMap.sol";

import "../../utils/Uint.sol";
import "../../utils/String.sol";
import "../../utils/Bytes32.sol";

abstract contract Types {
    /* 用户相关模型 */
    //用户全部信息
    struct UserInfo {
        address user_address;

        string major;//专业
        string avatar;//头像
        string nickname;//昵称
        string signature;//简介

        uint ID;//校园卡ID
        uint pits;//坑位数
        uint coins;//硬币数
        uint heart;//热心值
        uint experience;//经验值
        uint login_timestamp;//注册时间

        AddressLinkedList.T medals;//获得的勋章
        AddressLinkedList.T rewards;//我的悬赏
        AddressLinkedList.T comments;//我的评论
        AddressLinkedList.T followers;//我的粉丝
        AddressLinkedList.T followings;//我的关注
        AddressOrderedMap.T up_messages;//我的悬赏或评论被点赞消息
        AddressLinkedList.T marked_rewards;//我关注的悬赏
        AddressLinkedList.T uploaded_files;//已上传的文件
        AddressOrderedMap.T reply_messages;//我的悬赏或评论被回复消息
        AddressLinkedList.T purchased_files;//已购买的文件
        AddressOrderedMap.T following_upload_messages;//我的关注上传文件消息
        AddressOrderedMap.T marked_reward_solved_messages;//关注的悬赏被解决消息
    }

    //用户表
    struct UserStore {
        mapping(address => UserInfo) user_info;//用户信息

        AddressLinkedList.T user_index;//用户地址

        AddressOrderedMap.T _user_by_heart;//热心值索引
        AddressOrderedMap.T _user_by_medal_num;//奖牌数索引
        AddressOrderedMap.T _user_by_follower_num;//粉丝数索引
    }


    //个人信息摘要
    struct UserSelfInfo {
        string major;//专业
        string avatar;//头像
        string nickname;//用户名
        string signature;//简介

        uint ID;//校园卡ID
        uint coins;//硬币数
        uint heart;//热心值
        uint experience;//经验值
        uint follower_num;//粉丝数
        uint following_num;//关注数
        uint login_timestamp;//注册时间
        uint uploaded_file_num;//我上传的文件数
    }

    //卡片用户信息
    struct UserSimpleInfo {
        string major;//专业
        string avatar;//头像
        string nickname;//用户名
        string signature;//简介

        uint heart;//热心值
        uint medal_num;//勋章数
        uint experience;//经验值
        uint follower_num;//粉丝数
        uint uploaded_file_num;//上传的文件数
    }

    //用户摘要信息
    struct UserBriefInfo {
        address user_address;

        string avatar;//头像
        string nickname;//用户名

        uint experience;//经验值
    }


    /* 文件相关模型 */
    //文件全部信息
    struct File {
        address owner;//上传者
        address file_address;//地址
        address category_address;//分类

        string name;//文件名
        string title;//标题
        string description;//描述
        string ipfs_address;//ipfs地址

        string[3] images;//图片

        uint price;//价格
        uint up_num;//点赞数
        uint down_num;//点踩数
        uint buyer_num;//购买量
        uint comment_num;//评论数
        uint upload_timestamp;//上传时间

        mapping(address => bool) buyers;//已购买的用户
        mapping(address => uint) up_and_downs;//已点赞用户
        mapping(address => FileComment) comment_info;//评论信息

        AddressLinkedList.T comment_index;//评论地址
        AddressOrderedMap.T _comments_by_up_num;//评论按点赞排序
    }

    //评论
    struct FileComment {
        address author;//作者
        address comment_address;

        string content;//内容
        string[3] images;//图片

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint comment_timestamp;//评论时间

        mapping(address => uint) up_and_downs;//已点赞用户
        mapping(address => FileSubComment) sub_comment_info;//子评论信息

        AddressLinkedList.T sub_comment_index;//子评论
    }

    //子评论
    struct FileSubComment {
        address author;//作者
        address target_address;//被回复的子评论地址
        address comment_address;//根评论地址
        address sub_comment_address;//子评论地址

        string content;//内容

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint comment_timestamp;//评论时间

        mapping(address => uint) up_and_downs;//已点赞用户
    }


    //文件表
    struct FileStore {
        mapping(address => File) file_info;//文件信息

        AddressLinkedList.T file_index;//文件地址

        AddressOrderedMap.T _file_by_price;//价格索引
        AddressOrderedMap.T _file_by_buyer_num;//购买量索引
    }


    struct FileBriefInfo {
        address file_address;//地址
        address category_address;//分类

        bool is_buy;//是否已购买

        string name;//文件名
        string title;//标题
        string owner;//上传者用户名
        string description;//描述

        string cover;//图片

        uint price;//价格
        uint up_num;//点赞数
        uint down_num;//点踩数
        uint buyer_num;//购买量
        uint comment_num;//评论数
        uint up_and_down;//点赞点踩
        uint upload_timestamp;//上传时间
    }

    struct FileDetailInfo {
        address owner;//上传者地址
        address file_address;//地址
        address category_address;//分类

        bool is_buy;//是否已购买

        string name;//文件名
        string title;//标题
        string description;//描述
        string ipfs_address;//ipfs地址

        string[3] images;//图片

        uint price;//价格
        uint up_num;//点赞数
        uint down_num;//点踩数
        uint buyer_num;//购买量
        uint comment_num;//评论数
        uint up_and_down;//点赞点踩
        uint upload_timestamp;//上传时间
    }


    struct Category {
        address category_address;

        string name;

        uint num;
    }

    struct CategoryStore {
        mapping(address => Category) category_info;

        AddressLinkedList.T category_index;
    }

}


library UserLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;


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
        Types.UserInfo storage user_info = self.user_info[msg.sender];

        user_info.user_address = msg.sender;

        user_info.nickname = nickname;

        user_info.pits = 2;
        user_info.login_timestamp = block.timestamp;

        user_info.medals.init();
        user_info.rewards.init();
        user_info.comments.init();
        user_info.followers.init();
        user_info.followings.init();
        user_info.up_messages.init();
        user_info.marked_rewards.init();
        user_info.uploaded_files.init();
        user_info.reply_messages.init();
        user_info.purchased_files.init();
        user_info.following_upload_messages.init();
        user_info.marked_reward_solved_messages.init();

        self.user_index.append(msg.sender);
        self._user_by_heart.update(AddressOrderedMap.Item(msg.sender, 0));
        self._user_by_follower_num.update(AddressOrderedMap.Item(msg.sender, 0));
        self._user_by_medal_num.update(AddressOrderedMap.Item(msg.sender, 0));

    }

    //获取个人信息
    function getSelfInfo(Types.UserStore storage self)
    public view returns (Types.UserSelfInfo memory self_info){
        Types.UserInfo storage user_info = self.user_info[msg.sender];

        self_info = Types.UserSelfInfo({
            ID: user_info.ID,
            coins: user_info.coins,
            heart: user_info.heart,
            experience: user_info.experience,
            follower_num: user_info.followers.length,
            following_num: user_info.followings.length,
            login_timestamp: user_info.login_timestamp,
            uploaded_file_num: user_info.uploaded_files.length,

            major: user_info.major,
            avatar: user_info.avatar,
            nickname: user_info.nickname,
            signature: user_info.signature
        });
    }

    function getOtherSimpleInfo(Types.UserStore storage self, address user_address)
    public view returns (Types.UserSimpleInfo memory simple_info){
        Types.UserInfo storage user_info = self.user_info[user_address];

        simple_info.major = user_info.major;
        simple_info.avatar = user_info.avatar;
        simple_info.nickname = user_info.nickname;
        simple_info.signature = user_info.signature;

        simple_info.heart = user_info.heart;
        simple_info.medal_num = user_info.medals.length;
        simple_info.experience = user_info.experience;
        simple_info.follower_num = user_info.followers.length;
        simple_info.uploaded_file_num = user_info.uploaded_files.length;
    }

    function getSelfFileAddressSlice(Types.UserStore storage self, address cursor, bool reverse)
    public view returns (address[10] memory file_index_slice){
        file_index_slice = self.user_info[msg.sender].uploaded_files.slice(cursor, reverse);
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

    //上传文件后
    function afterUploadFile(Types.UserStore storage self, address file_address)
    public {
        self.user_info[msg.sender].uploaded_files.append(file_address);
    }
}

library FileLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;


    function init(Types.FileStore storage self)
    public {
        self.file_index.init();
        self._file_by_price.init();
        self._file_by_buyer_num.init();
    }

    function uploadFile(
        Types.FileStore storage self,
        string memory ipfs_address,
        string memory name,
        string memory title,
        string memory description,
        address category_address,
        string[3] memory images,
        uint price
    )
    public returns (address file_address){
        file_address = keccak256(abi.encodePacked(title)).toAddress();

        Types.File storage file_info = self.file_info[file_address];

        file_info.owner = msg.sender;
        file_info.file_address = file_address;
        file_info.category_address = category_address;

        file_info.name = name;
        file_info.title = title;
        file_info.description = description;
        file_info.ipfs_address = ipfs_address;

        file_info.images = images;

        file_info.price = price;
        file_info.upload_timestamp = block.timestamp;

        file_info.buyers[msg.sender] = true;

        self.file_index.append(file_address);
        self._file_by_price.update(AddressOrderedMap.Item(file_address, price));
        self._file_by_buyer_num.update(AddressOrderedMap.Item(file_address, 0));
    }

    function getFileBriefInfo(Types.FileStore storage self, address file_address)
    public view returns (Types.FileBriefInfo memory file_info, address owner_){
        Types.File storage file = self.file_info[file_address];

        file_info.file_address = file.file_address;
        file_info.category_address = file.category_address;

        file_info.is_buy = file.buyers[msg.sender];

        file_info.name = file.name;
        file_info.title = file.title;
        file_info.description = file.description;

        file_info.cover = file.images[0];

        file_info.price = file.price;
        file_info.up_num = file.up_num;
        file_info.down_num = file.down_num;
        file_info.buyer_num = file.buyer_num;
        file_info.comment_num = file.comment_num;
        file_info.up_and_down = file.up_and_downs[msg.sender];
        file_info.upload_timestamp = file.upload_timestamp;

        owner_ = file.owner;
    }

    function getFileSlice(Types.FileStore storage self, address cursor, address category_address, uint order, bool reverse)
    public view returns (address[10] memory file_slice, address next, bool finished){
        uint index = 0;
        while (index < 10) {
            if (reverse) {
                if (cursor == address(0x1)) {
                    finished = true;
                    break;
                }

                if (order == 1) {
                    cursor = self._file_by_price.getPrev(cursor);
                } else if (order == 2) {
                    cursor = self._file_by_buyer_num.getPrev(cursor);
                } else {
                    cursor = self.file_index.getPrev(cursor);
                }
            } else {
                if (cursor == address(0x2)) {
                    finished = true;
                    break;
                }

                if (order == 1) {
                    cursor = self._file_by_price.getNext(cursor);
                } else if (order == 2) {
                    cursor = self._file_by_buyer_num.getNext(cursor);
                } else {
                    cursor = self.file_index.getNext(cursor);
                }
            }


            if (self.file_info[cursor].category_address == category_address || category_address == address(0x0)) {
                file_slice[index] = cursor;
                index++;
            }

            next = cursor;
        }
    }

    function getFileDetailInfo(Types.FileStore storage self, address file_address)
    public view returns (Types.FileDetailInfo memory detail_info){
        Types.File storage file = self.file_info[file_address];

        detail_info.owner = file.owner;
        detail_info.file_address = file.file_address;
        detail_info.category_address = file.category_address;

        detail_info.is_buy = file.buyers[msg.sender];

        detail_info.name = file.name;
        detail_info.title = file.title;
        detail_info.description = file.description;

        detail_info.images = file.images;

        if (detail_info.is_buy) detail_info.ipfs_address = file.ipfs_address;

        detail_info.price = file.price;
        detail_info.up_num = file.up_num;
        detail_info.down_num = file.down_num;
        detail_info.buyer_num = file.buyer_num;
        detail_info.comment_num = file.comment_num;
        detail_info.up_and_down = file.up_and_downs[msg.sender];
        detail_info.upload_timestamp = file.upload_timestamp;
    }


}

library CategoryLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;

    function init(Types.CategoryStore storage self)
    public {
        self.category_index.init();
    }

    function isContain(Types.CategoryStore storage self, address category_address)
    public view returns (bool is_contain){
        is_contain = self.category_index.isContain(category_address);
    }

    function addCategory(Types.CategoryStore storage self, string memory name)
    public {
        address category_address = keccak256(abi.encodePacked(name)).toAddress();

        Types.Category storage category_info = self.category_info[category_address];

        category_info.category_address = category_address;
        category_info.name = name;

        self.category_index.append(category_address);
    }

    function getCategorySlice(Types.CategoryStore storage self, address cursor)
    public view returns (Types.Category[10] memory category_slice, address next, bool finished){
        address[10] memory category_index_slice = self.category_index.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            next = category_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            category_slice[i] = self.category_info[next];
        }
    }

    function increase(Types.CategoryStore storage self, address category_address)
    public {
        self.category_info[category_address].num++;
    }

}

abstract contract StoreContact {
    Types.UserStore users;//所有用户
    Types.FileStore files;//所有文件
    Types.CategoryStore categories;//分类

    //    /* 悬赏相关模型 */
    //    //悬赏全部信息
    //    struct Reward {
    //        address author;//作者
    //        address reward;
    //        address approved_comment;//被采纳的评论
    //
    //        string title;//标题
    //        string content;//内容
    //        string description;//描述
    //
    //        string[3] images;//图片
    //
    //        uint up_num;//点赞次数
    //        uint view_num;//浏览次数
    //        uint down_num;//点踩次数
    //        uint comment_num;//点踩次数
    //        uint remuneration;//酬金
    //        uint update_timestamp;//更新时间
    //        uint create_timestamp;//上传时间
    //
    //        mapping(address => uint) up_and_downs;//已点赞用户
    //    }
    //
    //    //悬赏表
    //    struct RewardStore {
    //        mapping(address => Reward) reward_info;//悬赏信息
    //
    //        AddressLinkedList.T reward_index;//悬赏地址
    //
    //        AddressOrderedMap.T _reward_by_update_timestamp;//悬赏按更新时间排序
    //        AddressOrderedMap.T _reward_by_view_num;//悬赏按浏览人数排序
    //        AddressOrderedMap.T _reward_by_up_num;//悬赏按点赞数排序
    //        AddressOrderedMap.T _reward_by_comment_num;//悬赏按评论数排序
    //    }
    //
    //    RewardStore rewards;//所有悬赏
    //
    //    /* 消息模型 */
    //    //关注用户上传文件
    //    struct FollowingUploadMessage {
    //        address user;//上传者
    //        address file;//文件地址
    //    }
    //
    //    //关注的悬赏被解决
    //    struct MarkedRewardSolvedMessage {
    //        address user;//评论者
    //        address reward;//所属悬赏
    //        address comment;//所属评论
    //    }
    //
    //    //悬赏或评论被回复
    //    struct ReplyMessage {
    //        address user;//评论者
    //        address target;//所属悬赏|文件
    //        address comment;//所属评论
    //        address sub_comment;//所属子评论
    //
    //        uint target_type;//评论类型 0:文件 1:文件评论 2:悬赏 3:悬赏评论
    //    }
    //
    //    //悬赏或评论被点赞
    //    struct UpMessage {
    //        address user;//点赞者
    //        address target;//所属悬赏|文件
    //        address comment;//所属评论
    //        address sub_comment;//所属子评论
    //
    //        uint target_type;//点赞类型 0:文件 1:文件评论 2:悬赏 3:悬赏评论
    //    }
    //
    //    //消息表
    //    struct MessageStore {
    //        mapping(address => UpMessage) up;//悬赏或评论被点赞消息
    //        mapping(address => ReplyMessage) reply;//悬赏或评论被回复消息
    //        mapping(address => FollowingUploadMessage) following_upload;//上传文件消息
    //        mapping(address => MarkedRewardSolvedMessage) marked_reward_solved;//悬赏被解决消息
    //    }
    //
    //    MessageStore messages;//所有消息
}
