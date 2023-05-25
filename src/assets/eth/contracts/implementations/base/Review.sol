// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Store.sol";

contract ReviewContact {
    // 评论区
    struct Review {
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

    mapping(address => Review) reviews;//评论区信息

    function createReview()  {
        
    }
}
