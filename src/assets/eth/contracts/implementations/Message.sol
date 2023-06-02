// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface MessageInterface {
    function MessageContact_init(uint) external;

    function getReplyMessages(uint, address cursor) external view returns (Types.ReplyMessageInfo[10] memory reply_message_infos, address next, bool finished);

    function getUpMessages(uint, address cursor) external view returns (Types.UpMessageInfo[10] memory up_message_infos, address next, bool finished);
}

contract MessageContact is BaseContact, MessageInterface {
    using MessageLib for Types.MessageStore;

    function MessageContact_init(uint)
    _onlyAdmin_
    external {

    }

    function getReplyMessages(uint, address cursor)
    external view returns (Types.ReplyMessageInfo[10] memory reply_message_infos, address next, bool finished){
        (reply_message_infos, next, finished) = messages.getReplyMessages(cursor, users, files, rewards);
    }

    function getUpMessages(uint, address cursor)
    external view returns (Types.UpMessageInfo[10] memory up_message_infos, address next, bool finished){
        (up_message_infos, next, finished) = messages.getUpMessages(cursor, users, files, rewards);
    }
}
