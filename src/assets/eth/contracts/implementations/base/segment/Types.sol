// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "../../../utils/AddressLinkedList.sol";
import "../../../utils/AddressOrderedMap.sol";
import "../../../utils/Common.sol";
import "../../../utils/Uint.sol";
import "../../../utils/String.sol";
import "../../../utils/Bytes32.sol";

abstract contract Types {
    /* 用户相关模型 */
    //用户全部信息
    struct User {
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
        AddressLinkedList.T followers;//我的粉丝
        AddressLinkedList.T followings;//我的关注
        AddressLinkedList.T up_messages;//我的悬赏或评论被点赞消息
        AddressLinkedList.T marked_files;//我关注的文件
        AddressLinkedList.T marked_rewards;//我关注的悬赏
        AddressLinkedList.T uploaded_files;//已上传的文件
        AddressLinkedList.T reply_messages;//我的悬赏或评论被回复消息
        AddressLinkedList.T purchased_files;//已购买的文件
        AddressLinkedList.T following_upload_messages;//我的关注上传文件消息
        AddressLinkedList.T marked_reward_solved_messages;//关注的悬赏被解决消息
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
        address user_address;

        bool is_follower;
        bool is_following;

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

        bool is_follower;
        bool is_following;

        string avatar;//头像
        string nickname;//用户名

        uint experience;//经验值
    }

    //用户表
    struct UserStore {
        mapping(address => User) user_info;//用户信息

        AddressLinkedList.T user_index;//用户地址

        AddressOrderedMap.T _user_by_heart;//热心值索引
        AddressOrderedMap.T _user_by_medal_num;//奖牌数索引
        AddressOrderedMap.T _user_by_follower_num;//粉丝数索引
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
        uint mark_num;//关注数
        uint buyer_num;//购买量
        uint comment_num;//评论数
        uint upload_timestamp;//上传时间

        mapping(address => bool) buyers;//已购买的用户
        mapping(address => bool) markers;//已购买的用户
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
        bool is_mark;

        string name;//文件名
        string title;//标题
        string description;//描述
        string ipfs_address;//ipfs地址

        string[3] images;//图片

        uint price;//价格
        uint up_num;//点赞数
        uint down_num;//点踩数
        uint mark_num;//关注数
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

        AddressLinkedList.T markers;
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

        bool is_mark;

        string title;//标题
        string description;//描述

        string[3] images;//图片

        uint up_num;//点赞次数
        uint down_num;//点踩次数
        uint mark_num;
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

    /* 消息模型 */
    //关注用户上传文件
    struct FollowingUploadMessage {
        address user_address;//上传者
        address file_address;//文件地址

        uint timestamp;
    }

    //关注的悬赏被解决
    struct MarkedRewardSolvedMessage {
        address reward_address;//所属悬赏
        address comment_address;

        uint timestamp;
    }

    //悬赏或评论被回复
    struct ReplyMessage {
        address user_address;//评论者
        address reply_address;//评论地址
        address target_address;//所属悬赏|文件
        address comment_address;//所属评论
        address sub_comment_address;//所属子评论

        uint timestamp;
        uint target_type;//评论类型 0:文件 1:文件评论 2:文件评论评论 3:悬赏 4:悬赏评论 5:悬赏评论评论
    }

    //悬赏或评论被回复
    struct ReplyMessageInfo {
        address target_address;//所属悬赏|文件

        string avatar;
        string target;
        string content;
        string nickname;

        uint timestamp;
        uint target_type;//评论类型 0:文件 1:文件评论 2:文件评论评论 3:悬赏 4:悬赏评论 5:悬赏评论评论
    }

    //悬赏或评论被点赞
    struct UpMessage {
        address user_address;//点赞者
        address target_address;//所属悬赏|文件
        address comment_address;//所属评论
        address sub_comment_address;//所属子评论

        uint num;
        uint timestamp;
        uint target_type;//点赞类型 0:文件 1:文件评论 2:文件评论评论 3:悬赏 4:悬赏评论 5:悬赏评论评论
    }

    struct UpMessageInfo {
        address target_address;//所属悬赏|文件

        string avatar;
        string content;
        string nickname;

        uint num;
        uint target_type;//点赞类型 0:文件 1:文件评论 2:文件评论评论 3:悬赏 4:悬赏评论 5:悬赏评论评论
    }

    //消息表
    struct MessageStore {
        mapping(address => UpMessage) up;//悬赏或评论被点赞消息
        mapping(address => ReplyMessage) reply;//悬赏或评论被回复消息
        mapping(address => FollowingUploadMessage) following_upload;//上传文件消息
        mapping(address => MarkedRewardSolvedMessage) marked_reward_solved;//悬赏被解决消息
    }
}

