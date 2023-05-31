// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "../../utils/AddressLinkedList.sol";
import "../../utils/AddressOrderedMap.sol";

import "../../utils/Uint.sol";
import "../../utils/String.sol";
import "../../utils/Bytes32.sol";

import "../../utils/Common.sol";


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

    struct FileRootComment {
        address comment_address;

        FileChildrenComment[2] children_comments;

        string content;//内容
        string[3] images;//图片

        UserBriefInfo author;

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint up_and_down;
        uint comment_num;//评论数
        uint comment_timestamp;//评论时间
    }

    struct FileChildrenComment {
        address target_address;//被回复的子评论地址
        address comment_address;//根评论地址
        address sub_comment_address;//子评论地址

        string content;//内容

        UserBriefInfo author;
        UserBriefInfo target_author;

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint up_and_down;
        uint comment_timestamp;//评论时间
    }

    //文件表
    struct FileStore {
        mapping(address => File) file_info;//文件信息

        AddressLinkedList.T file_index;//文件地址

        AddressOrderedMap.T _file_by_price;//价格索引
        AddressOrderedMap.T _file_by_up_num;//点赞索引
        AddressOrderedMap.T _file_by_buyer_num;//购买量索引
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

    /* 悬赏相关模型 */
    //悬赏全部信息
    struct Reward {
        address author;//作者
        address reward_address;//悬赏地址
        address approved_comment;//被采纳的评论

        string title;//标题
        string description;//描述

        string[3] images;//图片

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint comment_num;//点踩次数
        uint remuneration;//酬金
        uint update_timestamp;//更新时间
        uint create_timestamp;//上传时间

        mapping(address => uint) up_and_downs;//已点赞用户
        mapping(address => RewardComment) comment_info;//评论信息

        AddressLinkedList.T comment_index;//评论地址
        AddressOrderedMap.T _comments_by_up_num;//评论按点赞排序
    }

    struct RewardBriefInfo {
        address reward_address;//悬赏地址
        address approved_comment;//被采纳的评论

        string cover;//图片
        string title;//标题
        string author;//作者
        string description;//描述

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint up_and_down;
        uint comment_num;//点踩次数
        uint remuneration;//酬金
        uint update_timestamp;//更新时间
    }

    struct RewardDetailInfo {
        address author;//作者
        address reward_address;//悬赏地址
        address approved_comment;//被采纳的评论

        string title;//标题
        string description;//描述

        string[3] images;//图片

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint up_and_down;
        uint comment_num;//点踩次数
        uint remuneration;//酬金
        uint create_timestamp;//上传时间
        uint update_timestamp;//更新时间
    }


    //评论
    struct RewardComment {
        address author;//作者
        address file_address;//文件地址
        address comment_address;//评论地址

        string content;//内容
        string[3] images;//图片

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint comment_timestamp;//评论时间

        mapping(address => uint) up_and_downs;//已点赞用户
        mapping(address => RewardSubComment) sub_comment_info;//子评论信息

        AddressLinkedList.T sub_comment_index;//子评论
    }

    //子评论
    struct RewardSubComment {
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

    struct RewardRootComment {
        address comment_address;

        FileBriefInfo file_info;

        RewardChildrenComment[2] children_comments;

        string content;//内容
        string[3] images;//图片

        UserBriefInfo author;

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint up_and_down;
        uint comment_num;//评论数
        uint comment_timestamp;//评论时间
    }

    struct RewardChildrenComment {
        address target_address;//被回复的子评论地址
        address comment_address;//根评论地址
        address sub_comment_address;//子评论地址

        string content;//内容

        UserBriefInfo author;
        UserBriefInfo target_author;

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint up_and_down;
        uint comment_timestamp;//评论时间
    }

    //悬赏表
    struct RewardStore {
        mapping(address => Reward) reward_info;//悬赏信息

        AddressLinkedList.T reward_index;//悬赏地址

        AddressOrderedMap.T _reward_by_up_num;//点赞数排序
        AddressOrderedMap.T _reward_by_update_time;//更新时间排序
        AddressOrderedMap.T _reward_by_remuneration;//价格排序
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

    function getOtherBriefInfo(Types.UserStore storage self, address user_address)
    public view returns (Types.UserBriefInfo memory brief_info){
        Types.UserInfo storage user_info = self.user_info[user_address];

        brief_info.user_address = user_info.user_address;

        brief_info.avatar = user_info.avatar;
        brief_info.nickname = user_info.nickname;

        brief_info.experience = user_info.experience;
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

    //上传文件后
    function afterCreateReward(Types.UserStore storage self, address reward_address)
    public {
        self.user_info[msg.sender].rewards.append(reward_address);
    }
}

library FileLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;

    using UserLib for Types.UserStore;

    function init(Types.FileStore storage self)
    public {
        self.file_index.init();
        self._file_by_price.init();
        self._file_by_up_num.init();
        self._file_by_buyer_num.init();
    }

    function isContain(Types.FileStore storage self, address file_address)
    public view returns (bool is_contain) {
        is_contain = self.file_index.isContain(file_address);
    }

    function upload(
        Types.FileStore storage self,
        string memory ipfs_address,
        string memory name,
        string memory title,
        string memory description,
        address category_address,
        string[3] memory images,
        uint price
    ) public returns (address file_address){
        file_address = keccak256(abi.encodePacked(ipfs_address, title, msg.sender, block.timestamp)).toAddress();

        require(!isContain(self, file_address), "FileLib>uploadFile");

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

        file_info.comment_index.init();
        file_info._comments_by_up_num.init();

        self.file_index.append(file_address);
        self._file_by_price.update(AddressOrderedMap.Item(file_address, price));
        self._file_by_buyer_num.update(AddressOrderedMap.Item(file_address, 0));
    }

    function getBriefInfo(Types.FileStore storage self, address file_address, Types.UserStore storage users)
    public view returns (Types.FileBriefInfo memory file_info){
        Types.File storage file = self.file_info[file_address];

        file_info.file_address = file.file_address;
        file_info.category_address = file.category_address;

        file_info.is_buy = file.buyers[msg.sender];

        file_info.name = file.name;
        file_info.title = file.title;
        file_info.owner = users.user_info[file.owner].nickname;
        file_info.description = file.description;

        file_info.cover = file.images[0];

        file_info.price = file.price;
        file_info.up_num = file.up_num;
        file_info.down_num = file.down_num;
        file_info.buyer_num = file.buyer_num;
        file_info.comment_num = file.comment_num;
        file_info.up_and_down = file.up_and_downs[msg.sender];
        file_info.upload_timestamp = file.upload_timestamp;
    }

    function getSelfBriefInfos(
        Types.FileStore storage self,
        address cursor,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished) {
        address[10] memory file_index_slice = users.user_info[msg.sender].uploaded_files.slice(cursor, reverse);
        for (uint i = 0; i < 10; i++) {
            next = file_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            file_infos[i] = getBriefInfo(self, next, users);
        }
    }

    function getBriefInfos(
        Types.FileStore storage self,
        address cursor,
        address category_address,
        uint order,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = self._file_by_price.get(cursor, !reverse);
            } else if (order == 2) {
                cursor = self._file_by_buyer_num.get(cursor, !reverse);
            } else {
                cursor = self.file_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            if (self.file_info[cursor].category_address == category_address || category_address == address(0x0)) {
                file_infos[index] = getBriefInfo(self, cursor, users);
                index++;
            }

            next = cursor;
        }
    }

    function getDetailInfo(Types.FileStore storage self, address file_address)
    public view returns (Types.FileDetailInfo memory detail_info){
        Types.File storage file = self.file_info[file_address];

        detail_info = Types.FileDetailInfo({
            owner: file.owner,
            file_address: file.file_address,
            category_address: file.category_address,
            is_buy: file.buyers[msg.sender],
            name: file.name,
            title: file.title,
            description: file.description,
            ipfs_address: file.buyers[msg.sender] ? file.ipfs_address : "",
            images: file.images,
            price: file.price,
            up_num: file.up_num,
            down_num: file.down_num,
            buyer_num: file.buyer_num,
            comment_num: file.comment_num,
            up_and_down: file.up_and_downs[msg.sender],
            upload_timestamp: file.upload_timestamp
        });
    }

    function upAndDown(Types.FileStore storage self, address file_address, bool is_up)
    public {
        Types.File storage file = self.file_info[file_address];
        uint up_and_down = file.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, file.up_num, file.down_num, is_up);

        file.up_and_downs[msg.sender] = _up_and_down;
        file.up_num = _up_num;
        file.down_num = _down_num;


        self._file_by_up_num.update(AddressOrderedMap.Item(file_address, file.up_num));
    }

    function addComment(
        Types.FileStore storage self,
        address file_address,
        string memory content,
        string[3] memory images
    ) public {
        Types.File storage file = self.file_info[file_address];

        address comment_address = keccak256(abi.encodePacked(file_address, content, msg.sender, block.timestamp)).toAddress();

        Types.FileComment storage comment = file.comment_info[comment_address];

        comment.author = msg.sender;
        comment.comment_address = comment_address;

        comment.content = content;
        comment.images = images;

        comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.init();

        file.comment_num++;
        file.comment_index.append(comment_address);
        file._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, file.comment_num));
    }

    function upAndDownComment(
        Types.FileStore storage self,
        address file_address,
        address comment_address,
        bool is_up
    ) public {
        Types.FileComment storage comment = self.file_info[file_address].comment_info[comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];


        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;


        self.file_info[file_address]._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, comment.up_num));
    }

    function addSubComment(
        Types.FileStore storage self,
        address file_address,
        address target_address,
        address comment_address,
        string memory content
    ) public {
        Types.File storage file = self.file_info[file_address];
        Types.FileComment storage comment = file.comment_info[comment_address];

        address sub_comment_address = keccak256(abi.encodePacked(file_address, comment_address, content, msg.sender, block.timestamp)).toAddress();

        Types.FileSubComment storage sub_comment = comment.sub_comment_info[sub_comment_address];

        sub_comment.author = msg.sender;
        sub_comment.target_address = target_address;
        sub_comment.comment_address = comment_address;
        sub_comment.sub_comment_address = sub_comment_address;

        sub_comment.content = content;

        sub_comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.append(sub_comment_address);

        file.comment_num++;
    }

    function upAndDownSubComment(
        Types.FileStore storage self,
        address file_address,
        address comment_address,
        address sub_comment_address,
        bool is_up
    ) public {
        Types.FileSubComment storage comment = self.file_info[file_address].comment_info[comment_address].sub_comment_info[sub_comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;
    }

    function getRootComments(
        Types.FileStore storage self,
        address file_address,
        address cursor,
        uint order,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.FileRootComment[10] memory root_comments, address next, bool finished){
        Types.File storage file = self.file_info[file_address];

        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = file._comments_by_up_num.get(cursor, !reverse);
            } else {
                cursor = file.comment_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            Types.FileComment storage comment = file.comment_info[cursor];
            Types.FileChildrenComment[2] memory children_comments;

            address current = address(0x1);
            Types.FileSubComment storage sub_comment;

            for (uint i = 0; i < 2; i++) {
                current = comment.sub_comment_index.getNext(current);
                if (current == address(0x2)) break;
                sub_comment = comment.sub_comment_info[current];
                children_comments[i] = Types.FileChildrenComment({
                    target_address: sub_comment.target_address,
                    comment_address: sub_comment.comment_address,
                    sub_comment_address: sub_comment.sub_comment_address,
                    content: sub_comment.content,
                    author: users.getOtherBriefInfo(sub_comment.author),
                    target_author: users.getOtherBriefInfo(comment.sub_comment_info[sub_comment.target_address].author),
                    up_num: sub_comment.up_num,
                    down_num: sub_comment.down_num,
                    up_and_down: sub_comment.up_and_downs[msg.sender],
                    comment_timestamp: sub_comment.comment_timestamp
                });
            }


            root_comments[index] = Types.FileRootComment({
                comment_address: comment.comment_address,
                children_comments: children_comments,
                content: comment.content,
                images: comment.images,
                author: users.getOtherBriefInfo(comment.author),
                up_num: comment.up_num,
                down_num: comment.down_num,
                up_and_down: comment.up_and_downs[msg.sender],
                comment_num: comment.sub_comment_index.length,
                comment_timestamp: comment.comment_timestamp
            });

            index++;
            next = cursor;
        }
    }

    function getChildrenComments(
        Types.FileStore storage self,
        address file_address,
        address comment_address,
        address cursor,
        Types.UserStore storage users
    ) public view returns (Types.FileChildrenComment[10] memory children_comments, address next, bool finished) {
        Types.FileComment storage comment = self.file_info[file_address].comment_info[comment_address];

        uint index = 0;
        Types.FileSubComment storage sub_comment;

        while (index < 10) {
            cursor = comment.sub_comment_index.getNext(cursor);

            if (cursor == address(0x2)) {
                finished = true;
                break;
            }

            sub_comment = comment.sub_comment_info[cursor];

            children_comments[index] = Types.FileChildrenComment({
                target_address: sub_comment.target_address,
                comment_address: sub_comment.comment_address,
                sub_comment_address: sub_comment.sub_comment_address,
                content: sub_comment.content,
                author: users.getOtherBriefInfo(sub_comment.author),
                target_author: users.getOtherBriefInfo(comment.sub_comment_info[sub_comment.target_address].author),
                up_num: sub_comment.up_num,
                down_num: sub_comment.down_num,
                up_and_down: sub_comment.up_and_downs[msg.sender],
                comment_timestamp: sub_comment.comment_timestamp
            });

            index++;
            next = cursor;
        }
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

    function add(Types.CategoryStore storage self, string memory name)
    public {
        address category_address = keccak256(abi.encodePacked(name)).toAddress();
        require(!isContain(self, category_address), "CategoryLib>addCategory");

        Types.Category storage category_info = self.category_info[category_address];

        category_info.category_address = category_address;
        category_info.name = name;

        self.category_index.append(category_address);
    }

    function getSlice(Types.CategoryStore storage self, address cursor)
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

library RewardLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;

    using UserLib for Types.UserStore;
    using FileLib for Types.FileStore;

    function init(Types.RewardStore storage self)
    public {
        self.reward_index.init();
        self._reward_by_up_num.init();
        self._reward_by_update_time.init();
        self._reward_by_remuneration.init();
    }

    function isContain(Types.RewardStore storage self, address reward_address)
    public view returns (bool is_contain) {
        is_contain = self.reward_index.isContain(reward_address);
    }

    function create(
        Types.RewardStore storage self,
        string memory title,
        string memory description,
        string[3] memory images,
        uint remuneration
    ) public returns (address reward_address) {
        reward_address = keccak256(abi.encodePacked(title, msg.sender, block.timestamp)).toAddress();

        Types.Reward storage reward_info = self.reward_info[reward_address];

        reward_info.author = msg.sender;
        reward_info.reward_address = reward_address;

        reward_info.title = title;
        reward_info.description = description;

        reward_info.images = images;

        reward_info.remuneration = remuneration;

        reward_info.create_timestamp = block.timestamp;
        reward_info.update_timestamp = block.timestamp;

        reward_info.comment_index.init();
        reward_info._comments_by_up_num.init();

        self.reward_index.append(reward_address);
        self._reward_by_up_num.update(AddressOrderedMap.Item(reward_address, 0));
        self._reward_by_update_time.update(AddressOrderedMap.Item(reward_address, 0));
        self._reward_by_remuneration.update(AddressOrderedMap.Item(reward_address, remuneration));
    }

    function getBriefInfo(
        Types.RewardStore storage self,
        address reward_address,
        Types.UserStore storage users
    ) public view returns (Types.RewardBriefInfo memory reward_info){
        Types.Reward storage reward = self.reward_info[reward_address];

        reward_info = Types.RewardBriefInfo({
            reward_address: reward.reward_address,
            approved_comment: reward.approved_comment,
            cover: reward.images[0],
            title: reward.title,
            author: users.user_info[reward.author].nickname,
            description: reward.description,
            up_num: reward.up_num,
            down_num: reward.down_num,
            up_and_down: reward.up_and_downs[msg.sender],
            comment_num: reward.comment_num,
            remuneration: reward.remuneration,
            update_timestamp: reward.update_timestamp
        });
    }

    function getSelfBriefInfos(
        Types.RewardStore storage self,
        address cursor,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        address[10] memory reward_index_slice = users.user_info[msg.sender].rewards.slice(cursor, reverse);

        for (uint i = 0; i < 10; i++) {
            next = reward_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            reward_infos[i] = getBriefInfo(self, next, users);
        }
    }

    function getBriefInfos(
        Types.RewardStore storage self,
        address cursor,
        uint solved,
        uint order,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.RewardBriefInfo[10] memory reward_infos, address next, bool finished){
        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = self._reward_by_up_num.get(cursor, !reverse);
            } else if (order == 2) {
                cursor = self._reward_by_update_time.get(cursor, !reverse);
            } else if (order == 3) {
                cursor = self._reward_by_remuneration.get(cursor, !reverse);
            } else {
                cursor = self.reward_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            bool is_solved = self.reward_info[cursor].approved_comment != address(0x0);

            if (is_solved && solved == 1 || !is_solved && solved == 2 || solved == 0) {
                reward_infos[index] = getBriefInfo(self, cursor, users);
                index++;
            }

            next = cursor;
        }
    }

    function getDetailInfo(Types.RewardStore storage self, address reward_address)
    public view returns (Types.RewardDetailInfo memory detail_info){
        Types.Reward storage reward = self.reward_info[reward_address];

        detail_info = Types.RewardDetailInfo({
            author: reward.author,
            reward_address: reward.reward_address,
            approved_comment: reward.approved_comment,
            title: reward.title,
            description: reward.description,
            images: reward.images,
            up_num: reward.up_num,
            down_num: reward.down_num,
            up_and_down: reward.up_and_downs[msg.sender],
            comment_num: reward.comment_num,
            remuneration: reward.remuneration,
            create_timestamp: reward.create_timestamp,
            update_timestamp: reward.update_timestamp
        });
    }

    function upAndDown(Types.RewardStore storage self, address reward_address, bool is_up)
    public {
        Types.Reward storage reward = self.reward_info[reward_address];
        uint up_and_down = reward.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, reward.up_num, reward.down_num, is_up);

        reward.up_and_downs[msg.sender] = _up_and_down;
        reward.up_num = _up_num;
        reward.down_num = _down_num;


        self._reward_by_up_num.update(AddressOrderedMap.Item(reward_address, reward.up_num));
    }

    function addComment(
        Types.RewardStore storage self,
        address reward_address,
        address file_address,
        string memory content,
        string[3] memory images
    ) public {
        Types.Reward storage reward = self.reward_info[reward_address];

        address comment_address = keccak256(abi.encodePacked(reward_address, content, msg.sender, block.timestamp)).toAddress();

        Types.RewardComment storage comment = reward.comment_info[comment_address];

        comment.author = msg.sender;
        comment.file_address = file_address;
        comment.comment_address = comment_address;

        comment.content = content;
        comment.images = images;

        comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.init();

        reward.comment_num++;
        reward.comment_index.append(comment_address);
        reward._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, reward.comment_num));
    }

    function upAndDownComment(
        Types.RewardStore storage self,
        address reward_address,
        address comment_address,
        bool is_up
    ) public {
        Types.RewardComment storage comment = self.reward_info[reward_address].comment_info[comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];


        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;

        self.reward_info[reward_address]._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, comment.up_num));
    }

    function addSubComment(
        Types.RewardStore storage self,
        address reward_address,
        address target_address,
        address comment_address,
        string memory content
    ) public {
        Types.Reward storage reward = self.reward_info[reward_address];
        Types.RewardComment storage comment = reward.comment_info[comment_address];

        address sub_comment_address = keccak256(abi.encodePacked(reward_address, comment_address, content, msg.sender, block.timestamp)).toAddress();

        Types.RewardSubComment storage sub_comment = comment.sub_comment_info[sub_comment_address];

        sub_comment.author = msg.sender;
        sub_comment.target_address = target_address;
        sub_comment.comment_address = comment_address;
        sub_comment.sub_comment_address = sub_comment_address;

        sub_comment.content = content;

        sub_comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.append(sub_comment_address);

        reward.comment_num++;
    }

    function upAndDownSubComment(
        Types.RewardStore storage self,
        address reward_address,
        address comment_address,
        address sub_comment_address,
        bool is_up
    ) public {
        Types.RewardSubComment storage comment = self.reward_info[reward_address].comment_info[comment_address].sub_comment_info[sub_comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;
    }

    function _getRootComment(
        Types.Reward storage reward,
        address cursor,
        Types.UserStore storage users,
        Types.FileStore storage files
    ) internal view returns (Types.RewardRootComment memory root_comment)  {
        Types.RewardComment storage comment = reward.comment_info[cursor];
        Types.RewardChildrenComment[2] memory children_comments;

        address current = address(0x1);
        Types.RewardSubComment storage sub_comment;

        for (uint i = 0; i < 2; i++) {
            current = comment.sub_comment_index.getNext(current);
            if (current == address(0x2)) break;
            sub_comment = comment.sub_comment_info[current];
            children_comments[i] = Types.RewardChildrenComment({
                target_address: sub_comment.target_address,
                comment_address: sub_comment.comment_address,
                sub_comment_address: sub_comment.sub_comment_address,
                content: sub_comment.content,
                author: users.getOtherBriefInfo(sub_comment.author),
                target_author: users.getOtherBriefInfo(comment.sub_comment_info[sub_comment.target_address].author),
                up_num: sub_comment.up_num,
                down_num: sub_comment.down_num,
                up_and_down: sub_comment.up_and_downs[msg.sender],
                comment_timestamp: sub_comment.comment_timestamp
            });
        }

        root_comment = Types.RewardRootComment({
            comment_address: comment.comment_address,
            file_info: files.getBriefInfo(comment.file_address, users),
            children_comments: children_comments,
            content: comment.content,
            images: comment.images,
            author: users.getOtherBriefInfo(comment.author),
            up_num: comment.up_num,
            down_num: comment.down_num,
            up_and_down: comment.up_and_downs[msg.sender],
            comment_num: comment.sub_comment_index.length,
            comment_timestamp: comment.comment_timestamp
        });
    }

    function getRootComments(
        Types.RewardStore storage self,
        address reward_address,
        address cursor,
        uint order,
        bool reverse,
        Types.UserStore storage users,
        Types.FileStore storage files
    ) public view returns (Types.RewardRootComment[10] memory root_comments, address next, bool finished){
        Types.Reward storage reward = self.reward_info[reward_address];

        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = reward._comments_by_up_num.get(cursor, !reverse);
            } else {
                cursor = reward.comment_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            if (order == 3 && reward.comment_info[cursor].file_address == address(0x0)) continue;

            root_comments[index] = _getRootComment(reward, cursor, users, files);
            index++;
            next = cursor;
        }
    }

    function getChildrenComments(
        Types.RewardStore storage self,
        address reward_address,
        address comment_address,
        address cursor,
        Types.UserStore storage users
    ) public view returns (Types.RewardChildrenComment[10] memory children_comments, address next, bool finished) {
        Types.RewardComment storage comment = self.reward_info[reward_address].comment_info[comment_address];

        uint index = 0;
        Types.RewardSubComment storage sub_comment;

        while (index < 10) {
            cursor = comment.sub_comment_index.getNext(cursor);

            if (cursor == address(0x2)) {
                finished = true;
                break;
            }

            sub_comment = comment.sub_comment_info[cursor];

            children_comments[index] = Types.RewardChildrenComment({
                target_address: sub_comment.target_address,
                comment_address: sub_comment.comment_address,
                sub_comment_address: sub_comment.sub_comment_address,
                content: sub_comment.content,
                author: users.getOtherBriefInfo(sub_comment.author),
                target_author: users.getOtherBriefInfo(comment.sub_comment_info[sub_comment.target_address].author),
                up_num: sub_comment.up_num,
                down_num: sub_comment.down_num,
                up_and_down: sub_comment.up_and_downs[msg.sender],
                comment_timestamp: sub_comment.comment_timestamp
            });

            index++;
            next = cursor;
        }
    }
}

abstract contract StoreContact {
    Types.UserStore users;//所有用户
    Types.FileStore files;//所有文件
    Types.CategoryStore categories;//分类
    Types.RewardStore rewards;


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
