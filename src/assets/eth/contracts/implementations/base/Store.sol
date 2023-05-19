// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "../../utils/AddressLinkedList.sol";
import "../../utils/AddressOrderedMap.sol";


abstract contract StoreContact {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    /* 用户相关模型 */
    //用户全部信息
    struct UserInfo {
        address user_address;

        uint ID;//校园卡ID
        uint pits;//坑位数
        uint coins;//硬币数
        uint heart;//热心值
        uint experience;//经验值
        uint login_timestamp;//注册时间

        string major;//专业
        string avatar;//头像
        string nickname;//昵称
        string signature;//简介

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

    //个人信息摘要
    struct UserSelfInfo {
        uint ID;//校园卡ID
        uint coins;//硬币数
        uint heart;//热心值
        uint experience;//经验值
        uint follower_num;//粉丝数
        uint following_num;//关注数
        uint login_timestamp;//注册时间
        uint uploaded_file_num;//我上传的文件数

        string major;//专业
        string avatar;//头像
        string nickname;//用户名
        string signature;//简介
    }

    //其他用户信息
    struct UserBriefInfo {
        string avatar;//头像
        string nickname;//用户名
        string signature;//简介
        uint experience;//经验值
        uint login_timestamp;//登录时间
        uint follower_num;//粉丝数
        uint medal_num;//勋章数
        string major;//专业
        uint heart;//热心值
    }

    //卡片用户信息
    struct UserSimpleInfo {
        string avatar;//头像
        string nickname;//用户名
        string signature;//简介
        uint experience;//经验值
        uint follower_num;//粉丝数
        string major;//专业
        uint heart;//热心值
    }

    //用户表
    struct UserStore {
        AddressLinkedList.T user_index;//用户地址
        mapping(address => UserInfo) user_info;//用户信息

        AddressOrderedMap.T _user_by_heart;//热心值索引
        AddressOrderedMap.T _user_by_follower_num;//粉丝数索引
        AddressOrderedMap.T _user_by_medal_num;//奖牌数索引
    }

    UserStore users;//所有用户

    /* 文件相关模型 */
    //文件全部信息
    struct File {
        address file_address;

        address ipfs_address;//ipfs 地址
        address owner;//上传者
        string title;//标题
        string description;//描述
        address category;//分类
        string[3] images;//图片
        uint upload_timestamp;//上传时间
        uint price;//价格
        mapping(address => bool) buyers;//已购买的用户
        uint buyer_num;//购买量
    }

    struct FileInfo {
        address file_address;

        address ipfs_address;//ipfs 地址
        address owner;//上传者
        string title;//标题
        string description;//描述
        address category;//分类
        string[3] images;//图片
        uint upload_timestamp;//上传时间
        uint price;//价格
        uint buyer_num;//购买量
    }

    //文件表
    struct FileStore {
        AddressLinkedList.T file_index;//文件地址
        mapping(address => File) file_info;//文件信息

        AddressOrderedMap.T _file_by_price;//价格索引
        AddressOrderedMap.T _file_by_buyer_num;//购买量索引
    }

    struct Category {
        address category_address;

        string name;
        uint num;
    }

    struct CategoryStore {
        AddressLinkedList.T category_index;
        mapping(address => Category) category_info;
    }

    CategoryStore categories;//分类
    FileStore files;//所有文件

    /* 悬赏相关模型 */
    //悬赏全部信息
    struct Reward {
        address reward;

        address author;//作者
        string title;//标题
        string description;//描述
        string content;//内容
        string[3] images;//图片
        uint create_timestamp;//上传时间
        uint update_timestamp;//更新时间
        uint remuneration;//酬金
        uint view_num;//浏览次数
        uint up_num;//点赞次数
        uint down_num;//点踩次数
        address approved_comment;//被采纳的评论
        AddressLinkedList.T comment_index;//评论地址
        mapping(address => Comment) comment_info;//评论信息
        AddressOrderedMap.T _comments_by_up_num;//评论按点赞排序
    }

    //评论
    struct Comment {
        address comment_address;

        address author;//作者
        string content;//内容
        string[3] images;//图片
        uint comment_timestamp;//评论时间
        uint up_num;//点赞次数
        uint down_num;//点踩次数
        AddressLinkedList.T sub_comment_index;//子评论
        mapping(address => SubComment) sub_comment_info;//子评论信息
    }

    //子评论
    struct SubComment {
        address sub_comment_address;
        address author;//作者
        string content;//内容
        uint comment_timestamp;//评论时间
        address target;//被回复的子评论
        uint up_num;//点赞次数
        uint down_num;//点踩次数
    }

    //悬赏表
    struct RewardStore {
        AddressLinkedList.T reward_index;//悬赏地址
        mapping(address => Reward) reward_info;//悬赏信息

        AddressOrderedMap.T _reward_by_update_timestamp;//悬赏按更新时间排序
        AddressOrderedMap.T _reward_by_view_num;//悬赏按浏览人数排序
        AddressOrderedMap.T _reward_by_up_num;//悬赏按点赞数排序
        AddressOrderedMap.T _reward_by_comment_num;//悬赏按评论数排序
    }

    RewardStore rewards;//所有悬赏

    /* 消息模型 */
    //关注用户上传文件
    struct FollowingUploadMessage {
        address user;//上传者
        address file;//文件地址
    }

    //关注的悬赏被解决
    struct MarkedRewardSolvedMessage {
        address user;//评论者
        address reward;//所属悬赏
        address comment;//所属评论
    }

    //悬赏或评论被回复
    struct ReplyMessage {
        address user;//评论者
        uint target_type;//评论类型 0:悬赏 1:评论
        address reward;//所属悬赏
        address comment;//所属评论
    }

    //悬赏或评论被点赞
    struct UpMessage {
        address user;//点赞者
        uint target_type;//点赞类型 0:悬赏 1:评论
        address reward;//所属悬赏
        address comment;//所属评论
    }

    //消息表
    struct MessageStore {
        mapping(address => FollowingUploadMessage) following_upload;//上传文件消息
        mapping(address => MarkedRewardSolvedMessage) marked_reward_solved;//悬赏被解决消息
        mapping(address => ReplyMessage) reply;//悬赏或评论被回复消息
        mapping(address => UpMessage) up;//悬赏或评论被点赞消息
    }

    MessageStore messages;//所有消息
}
