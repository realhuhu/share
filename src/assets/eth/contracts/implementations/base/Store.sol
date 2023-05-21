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

    //其他用户信息
    struct UserBriefInfo {
        string major;//专业
        string avatar;//头像
        string nickname;//用户名
        string signature;//简介

        uint heart;//热心值
        uint medal_num;//勋章数
        uint experience;//经验值
        uint follower_num;//粉丝数
        uint login_timestamp;//登录时间
    }

    //卡片用户信息
    struct UserSimpleInfo {
        string major;//专业
        string avatar;//头像
        string nickname;//用户名
        string signature;//简介

        uint heart;//热心值
        uint experience;//经验值
        uint follower_num;//粉丝数
    }

    //用户表
    struct UserStore {
        mapping(address => UserInfo) user_info;//用户信息

        AddressLinkedList.T user_index;//用户地址

        AddressOrderedMap.T _user_by_heart;//热心值索引
        AddressOrderedMap.T _user_by_medal_num;//奖牌数索引
        AddressOrderedMap.T _user_by_follower_num;//粉丝数索引
    }

    UserStore users;//所有用户

    /* 文件相关模型 */
    //文件全部信息
    struct File {
        address owner;//上传者
        address category;//分类
        address file_address;//地址

        string name;//文件名
        string title;//标题
        string description;//描述
        string ipfs_address;//ipfs地址

        string[3] images;//图片

        uint price;//价格
        uint up_num;//点赞数
        uint down_num;//点踩数
        uint buyer_num;//购买量
        uint upload_timestamp;//上传时间

        mapping(address => bool) buyers;//已购买的用户
        mapping(address => uint) up_and_downs;//已点赞用户
        mapping(address => Comment) comment_info;//评论信息

        AddressLinkedList.T comment_index;//评论地址
    }

    struct FileInfo {
        address owner;//上传者
        address category;//分类
        address file_address;//地址

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

    //文件表
    struct FileStore {
        mapping(address => File) file_info;//文件信息

        AddressLinkedList.T file_index;//文件地址

        AddressOrderedMap.T _file_by_price;//价格索引
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

    CategoryStore categories;//分类
    FileStore files;//所有文件

    /* 悬赏相关模型 */
    //悬赏全部信息
    struct Reward {
        address author;//作者
        address reward;
        address approved_comment;//被采纳的评论

        string title;//标题
        string content;//内容
        string description;//描述

        string[3] images;//图片

        uint up_num;//点赞次数
        uint view_num;//浏览次数
        uint down_num;//点踩次数
        uint remuneration;//酬金
        uint update_timestamp;//更新时间
        uint create_timestamp;//上传时间

        mapping(address => Comment) comment_info;//评论信息

        AddressLinkedList.T comment_index;//评论地址
        AddressOrderedMap.T _comments_by_up_num;//评论按点赞排序
    }

    //评论
    struct Comment {
        address author;//作者
        address comment_address;

        string content;//内容
        string[3] images;//图片

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint comment_timestamp;//评论时间

        mapping(address => SubComment) sub_comment_info;//子评论信息

        AddressLinkedList.T sub_comment_index;//子评论
    }

    //子评论
    struct SubComment {
        address author;//作者
        address target;//被回复的子评论
        address sub_comment_address;

        string content;//内容

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint comment_timestamp;//评论时间
    }

    //悬赏表
    struct RewardStore {
        mapping(address => Reward) reward_info;//悬赏信息

        AddressLinkedList.T reward_index;//悬赏地址

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
        address target;//所属悬赏|文件
        address comment;//所属评论
        address sub_comment;//所属子评论

        uint target_type;//评论类型 0:文件 1:文件评论 2:悬赏 3:悬赏评论
    }

    //悬赏或评论被点赞
    struct UpMessage {
        address user;//点赞者
        address target;//所属悬赏|文件
        address comment;//所属评论
        address sub_comment;//所属子评论

        uint target_type;//点赞类型 0:文件 1:文件评论 2:悬赏 3:悬赏评论
    }

    //消息表
    struct MessageStore {
        mapping(address => UpMessage) up;//悬赏或评论被点赞消息
        mapping(address => ReplyMessage) reply;//悬赏或评论被回复消息
        mapping(address => FollowingUploadMessage) following_upload;//上传文件消息
        mapping(address => MarkedRewardSolvedMessage) marked_reward_solved;//悬赏被解决消息
    }

    MessageStore messages;//所有消息
}
