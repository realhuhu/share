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

    //    function addComment(address file_address, string memory content, string[3] memory images) external;
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
        address owner_;
        (file_info, owner_) = files.getFileBriefInfo(file_address);
        file_info.owner = users.user_info[owner_].nickname;
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


    function uploadFile(
        string memory ipfs_address,
        string memory name,
        string memory title,
        string memory description,
        address category_address,
        string[3] memory images,
        uint price
    )
    external {
        _registered_(msg.sender);
        _validCategory_(category_address);

        title._range_(1, 64);
        description._range_(1, 512);
        price._range_(1, 20);

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
        address[10] memory file_index_slice = users.getSelfFileAddressSlice(cursor, reverse);
        for (uint i = 0; i < 10; i++) {
            next = file_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            file_infos[i] = _getFileBriefInfo(next);
        }
    }

    function getFileBriefInfos(address cursor, address category_address, uint order, bool reverse)
    external view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        address[10] memory file_slice;
        (file_slice, next, finished) = files.getFileSlice(cursor, category_address, order, reverse);
        for (uint i = 0; i < 10; i++) {
            if (file_slice[i] == address(0x0)) {
                break;
            }
            file_infos[i] = _getFileBriefInfo(file_slice[i]);
        }
    }

    function getFileDetailInfo(address file_address)
    external view returns (Types.FileDetailInfo memory detail_info){
        detail_info = files.getFileDetailInfo(file_address);
    }


    //    function addComment(
    //        address file_address,
    //        string memory content,
    //        string[3] memory images
    //    ) external {
    //        _validFile_(file_address);
    //        content._range_(0, 128);
    //
    //        File storage file = files.file_info[file_address];
    //
    //        address comment_address = keccak256(abi.encodePacked(file_address, content, msg.sender, block.timestamp)).toAddress();
    //
    //        FileComment storage comment = file.comment_info[comment_address];
    //
    //        comment.author = msg.sender;
    //        comment.comment_address = comment_address;
    //
    //        comment.content = content;
    //        comment.images = images;
    //
    //        comment.comment_timestamp = block.timestamp;
    //
    //        comment.sub_comment_index.init();
    //
    //        file.comment_num++;
    //        file.comment_index.append(comment_address);
    //        file._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, file.comment_num));
    //    }
    //
    //    function addSubComment(
    //        address file_address,
    //        address target_address,
    //        address comment_address,
    //        string memory content
    //    ) external {
    //        content._range_(0, 128);
    //
    //        _validFile_(file_address);
    //        File storage file = files.file_info[file_address];
    //
    //        _validFileComment_(file, comment_address);
    //        FileComment storage comment = file.comment_info[comment_address];
    //
    //        _validFileTargetComment_(comment, target_address);
    //
    //        address sub_comment_address = keccak256(abi.encodePacked(file_address, comment_address, content, msg.sender, block.timestamp)).toAddress();
    //
    //        FileSubComment storage sub_comment = comment.sub_comment_info[sub_comment_address];
    //
    //        sub_comment.author = msg.sender;
    //        sub_comment.target_address = target_address;
    //        sub_comment.comment_address = comment_address;
    //        sub_comment.sub_comment_address = sub_comment_address;
    //
    //        sub_comment.content = content;
    //
    //        sub_comment.comment_timestamp = block.timestamp;
    //
    //        comment.sub_comment_index.append(sub_comment_address);
    //    }
}
