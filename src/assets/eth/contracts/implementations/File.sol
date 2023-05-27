//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface FileInterface {
    function addCategory(string memory name) external;

    function getCategorySlice(address cursor) external view returns (Types.Category[10] memory category_slice, address next, bool finished);

    function uploadFile(string memory ipfs_address, string memory name, string memory title, string memory description, address category_address, string[3] memory images, uint price) external;

    function getSelfFileBriefInfos(address cursor, bool reverse) external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished);

    function getFileBriefInfos(address cursor, address category_address, uint order, bool reverse) external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished);

    function getFileDetailInfo(address file_address) external view returns (Types.FileDetailInfo memory detail_info);

    function upAndDownFile(address file_address, bool is_up) external;

    function addComment(address file_address, string memory content, string[3] memory images) external;

    function upAndDownFileComment(address file_address, address comment_address, bool is_up) external;

    function addSubComment(address file_address, address target_address, address comment_address, string memory content) external;

    function getRootComments(address file_address, address cursor, uint order, bool reverse) external view returns (Types.FileRootComment[10] memory root_comments, address next, bool finished);
}


abstract contract FileContact is BaseContact, FileInterface {
    using UintLib for uint;
    using StringLib for string;
    using Bytes32Lib for bytes32;

    using UserLib for Types.UserStore;
    using FileLib for Types.FileStore;
    using CategoryLib for Types.CategoryStore;

    function FileContract_init()
    internal {
        files.init();
        categories.init();
    }

    function _getFileBriefInfo(address file_address)
    internal view returns (Types.FileBriefInfo memory file_info){
        file_info = files.getFileBriefInfo(file_address, users);
    }

    function addCategory(string memory name)
    _onlyAdmin_
    external {
        categories.addCategory(name);
    }

    function getCategorySlice(address cursor)
    external view returns (Types.Category[10] memory category_slice, address next, bool finished){
        (category_slice, next, finished) = categories.getCategorySlice(cursor);
    }


    function uploadFile(string memory ipfs_address, string memory name, string memory title, string memory description, address category_address, string[3] memory images, uint price)
    external {
        require(categories.isContain(category_address), "FileContact>uploadFile");

        title._range_(1, 64);
        price._range_(1, 20);
        description._range_(1, 512);

        address file_address = files.uploadFile(ipfs_address, name, title, description, category_address, images, price);

        categories.increase(category_address);

        //        address message_address = keccak256(abi.encodePacked(file_address)).toAddress();
        //        FollowingUploadMessage storage message = messages.following_upload[message_address];
        //
        //        message.user = msg.sender;
        //        message.file = file_address;
        //
        //        address cursor = address(0x1);
        //        UserInfo storage self = users.user_info[msg.sender];
        //        while (true) {
        //            cursor = self.followers.getNext(cursor);
        //            if (cursor == address(0x2)) break;
        //            self.following_upload_messages.update(AddressOrderedMap.Item(message_address, 1));
        //        }

        users.afterUploadFile(file_address);
    }

    function getSelfFileBriefInfos(address cursor, bool reverse)
    external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        (file_infos, next, finished) = files.getSelfFileBriefInfos(cursor, reverse, users);
    }

    function getFileBriefInfos(address cursor, address category_address, uint order, bool reverse)
    external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        (file_infos, next, finished) = files.getFileBriefInfos(cursor, category_address, order, reverse, users);
    }

    function getFileDetailInfo(address file_address)
    external view returns (Types.FileDetailInfo memory detail_info){
        detail_info = files.getFileDetailInfo(file_address);
    }

    function upAndDownFile(address file_address, bool is_up)
    external {
        files.upAndDown(file_address, is_up);
    }

    function addComment(address file_address, string memory content, string[3] memory images)
    external {
        files.addComment(file_address, content, images);
    }

    function upAndDownFileComment(address file_address, address comment_address, bool is_up)
    external {
        files.upAndDownComment(file_address, comment_address, is_up);
    }

    function addSubComment(address file_address, address target_address, address comment_address, string memory content)
    external {
        files.addSubComment(file_address, target_address, comment_address, content);
    }

    function getRootComments(address file_address, address cursor, uint order, bool reverse)
    external view returns (Types.FileRootComment[10] memory root_comments, address next, bool finished){
        (root_comments, next, finished) = files.getRootComments(file_address, cursor, order, reverse, users);
    }
}
