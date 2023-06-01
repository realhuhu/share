//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface FileInterface {
    function FileContract_init(uint) external;

    function addCategory(uint, string memory name) external;

    function getCategorySlice(uint, address cursor) external view returns (Types.Category[10] memory category_slice, address next, bool finished);

    function uploadFile(uint, string memory ipfs_address, string memory name, string memory title, string memory description, address category_address, string[3] memory images, uint price) external;

    function getFileBriefInfos(uint, address cursor, address category_address, uint order, bool reverse) external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished);

    function getUserFileBriefInfos(uint, address user_address, address cursor, bool reverse) external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished);

    function getSelfFileBriefInfos(uint, address cursor, bool reverse) external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished);

    function getFileDetailInfo(uint, address file_address) external view returns (Types.FileDetailInfo memory detail_info);

    function upAndDownFile(uint, address file_address, bool is_up) external;

    function addFileComment(uint, address file_address, string memory content, string[3] memory images) external;

    function upAndDownFileComment(uint, address file_address, address comment_address, bool is_up) external;

    function addFileSubComment(uint, address file_address, address target_address, address comment_address, string memory content) external;

    function upAndDownFileSubComment(uint, address file_address, address comment_address, address sub_comment_address, bool is_up) external;

    function getFileRootComments(uint, address file_address, address cursor, uint order, bool reverse) external view returns (Types.FileRootComment[10] memory root_comments, address next, bool finished);

    function getFileChildrenComments(uint, address file_address, address comment_address, address cursor) external view returns (Types.FileChildrenComment[10] memory children_comments, address next, bool finished);

    function markFile(uint, address file_address) external;

    function getMarkedFiles(uint, address cursor) external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished);
}

contract FileContact is BaseContact, FileInterface {
    using Bytes32Lib for bytes32;

    using UserLib for Types.UserStore;
    using FileLib for Types.FileStore;
    using CategoryLib for Types.CategoryStore;

    function FileContract_init(uint)
    _onlyAdmin_
    external {
        files.init();
        categories.init();
    }

    function addCategory(uint, string memory name)
    _onlyAdmin_
    external {
        categories.add(name);
    }

    function getCategorySlice(uint, address cursor)
    external view returns (Types.Category[10] memory category_slice, address next, bool finished){
        (category_slice, next, finished) = categories.getSlice(cursor);
    }

    function uploadFile(uint, string memory ipfs_address, string memory name, string memory title, string memory description, address category_address, string[3] memory images, uint price)
    external {
        address file_address = files.upload(ipfs_address, name, title, description, category_address, images, price);
        categories.increase(category_address);
        users.afterUploadFile(file_address);
    }

    function getFileBriefInfos(uint, address cursor, address category_address, uint order, bool reverse)
    external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        (file_infos, next, finished) = files.getBriefInfos(cursor, category_address, order, reverse, users);
    }

    function getUserFileBriefInfos(uint, address user_address, address cursor, bool reverse)
    external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        (file_infos, next, finished) = files.getUserBriefInfos(user_address, cursor, reverse, users);
    }


    function getSelfFileBriefInfos(uint, address cursor, bool reverse)
    external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        (file_infos, next, finished) = files.getSelfBriefInfos(cursor, reverse, users);
    }

    function getFileDetailInfo(uint, address file_address)
    external view returns (Types.FileDetailInfo memory detail_info){
        detail_info = files.getDetailInfo(file_address);
    }

    function upAndDownFile(uint, address file_address, bool is_up)
    external {
        _uploaded_(file_address);
        files.upAndDown(file_address, is_up);
    }

    function addFileComment(uint, address file_address, string memory content, string[3] memory images)
    external {
        _uploaded_(file_address);
        files.addComment(file_address, content, images);
    }

    function upAndDownFileComment(uint, address file_address, address comment_address, bool is_up)
    external {
        _file_commented_(file_address, comment_address);
        files.upAndDownComment(file_address, comment_address, is_up);
    }

    function addFileSubComment(uint, address file_address, address target_address, address comment_address, string memory content)
    external {
        _file_commented_(file_address, comment_address);
        files.addSubComment(file_address, target_address, comment_address, content);
    }

    function upAndDownFileSubComment(uint, address file_address, address comment_address, address sub_comment_address, bool is_up)
    external {
        _file_sub_commented_(file_address, comment_address, sub_comment_address);
        files.upAndDownSubComment(file_address, comment_address, sub_comment_address, is_up);
    }

    function getFileRootComments(uint, address file_address, address cursor, uint order, bool reverse)
    external view returns (Types.FileRootComment[10] memory root_comments, address next, bool finished){
        (root_comments, next, finished) = files.getRootComments(file_address, cursor, order, reverse, users);
    }

    function getFileChildrenComments(uint, address file_address, address comment_address, address cursor)
    external view returns (Types.FileChildrenComment[10] memory children_comments, address next, bool finished){
        (children_comments, next, finished) = files.getChildrenComments(file_address, comment_address, cursor, users);
    }

    function markFile(uint, address file_address)
    external {
        _uploaded_(file_address);
        bool is_mark = files.mark(file_address);
        users.afterMarkFile(file_address, is_mark);
    }

    function getMarkedFiles(uint, address cursor)
    external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        (file_infos, next, finished) = files.getMarked(cursor, users);
    }
}
