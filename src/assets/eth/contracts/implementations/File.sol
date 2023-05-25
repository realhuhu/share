//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface FileInterface {
    function addCategory(string memory name) external;

    function getCategorySlice(address cursor) external view returns (StoreContact.Category[10] memory category_slice, address next);

    function uploadFile(string memory ipfs_address, string memory name, string memory title, string memory description, address category, string[3] memory images, uint price) external;

    function getSelfFileBriefInfos(address cursor, bool reverse) external view returns (StoreContact.FileBriefInfo[10] memory file_infos, address next, bool finished);

    function getFileBriefInfos(address cursor, address category, uint order, bool reverse) external view returns (StoreContact.FileBriefInfo[10] memory file_infos, address next, bool finished);

    function getFileDetailInfo(address file_address) external view returns (StoreContact.FileDetailInfo memory detail_info);

    function addComment(address file_address, string memory content, string[3] memory images) external;
}



abstract contract FileContact is BaseContact, FileInterface {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using UintLib for uint;
    using StringLib for string;
    using Bytes32Lib for bytes32;

    function FileContract_init()
    internal {
        categories.category_index.init();
        files.file_index.init();
        files._file_by_price.init();
        files._file_by_buyer_num.init();
    }

    function _validFile_(address file_address)
    internal view {
        require(files.file_index.isContain(file_address), "FileContact>_validFile_");
    }

    function _validFileComment_(File storage file, address comment_address)
    internal view {
        require(file.comment_index.isContain(comment_address), "FileContact>_validFileComment_");
    }

    function _validFileTargetComment_(FileComment storage comment, address target_address)
    internal view {
        require(target_address == address(0x0) || comment.sub_comment_index.isContain(target_address), "FileContact>_validFileTargetComment_");
    }

    function addCategory(string memory name)
    _onlyAdmin_
    external {
        address category_address = keccak256(abi.encodePacked(name)).toAddress();
        Category storage category_info = categories.category_info[category_address];
        category_info.category_address = category_address;
        category_info.name = name;
        categories.category_index.append(category_address);
    }

    function getCategorySlice(address cursor)
    external view returns (Category[10] memory category_slice, address next){
        address[10] memory category_index_slice = categories.category_index.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            next = category_index_slice[i];
            if (next == address(0x0)) break;
            category_slice[i] = categories.category_info[next];
        }
    }


    function uploadFile(
        string memory ipfs_address,
        string memory name,
        string memory title,
        string memory description,
        address category,
        string[3] memory images,
        uint price
    )
    external {
        _registered_(msg.sender);
        _validCategory_(category);

        title._range_(1, 64);
        description._range_(1, 512);
        price._range_(1, 20);

        address file_address = keccak256(abi.encodePacked(title)).toAddress();
        File storage file_info = files.file_info[file_address];

        file_info.owner = msg.sender;
        file_info.category = category;
        file_info.file_address = file_address;

        file_info.name = name;
        file_info.title = title;
        file_info.description = description;
        file_info.ipfs_address = ipfs_address;

        file_info.images = images;

        file_info.price = price;
        file_info.upload_timestamp = block.timestamp;

        file_info.buyers[msg.sender] = true;

        files.file_index.append(file_address);
        files._file_by_price.update(AddressOrderedMap.Item(file_address, price));
        files._file_by_buyer_num.update(AddressOrderedMap.Item(file_address, 0));

        categories.category_info[category].num++;

        address message_address = keccak256(abi.encodePacked(file_address)).toAddress();
        FollowingUploadMessage storage message = messages.following_upload[message_address];

        message.user = msg.sender;
        message.file = file_address;

        address cursor = address(0x1);
        UserInfo storage self = users.user_info[msg.sender];
        while (true) {
            cursor = self.followers.getNext(cursor);
            if (cursor == address(0x2)) break;
            self.following_upload_messages.update(AddressOrderedMap.Item(message_address, 1));
        }

        self.uploaded_files.append(file_address);
    }

    function _toFileBriefInfo(File storage file)
    internal view returns (FileBriefInfo memory file_info){
        file_info.category = file.category;
        file_info.file_address = file.file_address;

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

    function getSelfFileBriefInfos(address cursor, bool reverse)
    external view returns (FileBriefInfo[10] memory file_infos, address next, bool finished){
        _registered_(msg.sender);

        address[10] memory file_index_slice = users.user_info[msg.sender].uploaded_files.slice(cursor, reverse);
        for (uint i = 0; i < 10; i++) {
            next = file_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            file_infos[i] = _toFileBriefInfo(files.file_info[next]);
        }
    }

    function getFileBriefInfos(address cursor, address category, uint order, bool reverse)
    external view returns (FileBriefInfo[10] memory file_infos, address next, bool finished){
        FileBriefInfo memory file_info;
        uint index = 0;
        while (index < 10) {
            if (reverse) {
                if (cursor == address(0x1)) {
                    finished = true;
                    break;
                }

                if (order == 1) {
                    cursor = files._file_by_price.getPrev(cursor);
                } else if (order == 2) {
                    cursor = files._file_by_buyer_num.getPrev(cursor);
                } else {
                    cursor = files.file_index.getPrev(cursor);
                }
            } else {
                if (cursor == address(0x2)) {
                    finished = true;
                    break;
                }

                if (order == 1) {
                    cursor = files._file_by_price.getNext(cursor);
                } else if (order == 2) {
                    cursor = files._file_by_buyer_num.getNext(cursor);
                } else {
                    cursor = files.file_index.getNext(cursor);
                }
            }

            file_info = _toFileBriefInfo(files.file_info[cursor]);
            if (file_info.category == category || category == address(0x0)) {
                file_infos[index] = file_info;
                index++;
            }

            next = cursor;
        }
    }

    function getFileDetailInfo(address file_address)
    external view returns (FileDetailInfo memory detail_info){
        File storage file = files.file_info[file_address];

        detail_info.owner = file.owner;
        detail_info.category = file.category;
        detail_info.file_address = file.file_address;

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


    function addComment(
        address file_address,
        string memory content,
        string[3] memory images
    ) external {
        _validFile_(file_address);
        content._range_(0, 128);

        File storage file = files.file_info[file_address];

        address comment_address = keccak256(abi.encodePacked(file_address, content, msg.sender, block.timestamp)).toAddress();

        FileComment storage comment = file.comment_info[comment_address];

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

    function addSubComment(
        address file_address,
        address target_address,
        address comment_address,
        string memory content
    ) external {
        content._range_(0, 128);

        _validFile_(file_address);
        File storage file = files.file_info[file_address];

        _validFileComment_(file, comment_address);
        FileComment storage comment = file.comment_info[comment_address];

        _validFileTargetComment_(comment, target_address);

        address sub_comment_address = keccak256(abi.encodePacked(file_address, comment_address, content, msg.sender, block.timestamp)).toAddress();

        FileSubComment storage sub_comment = comment.sub_comment_info[sub_comment_address];

        sub_comment.author = msg.sender;
        sub_comment.target_address = target_address;
        sub_comment.comment_address = comment_address;
        sub_comment.sub_comment_address = sub_comment_address;

        sub_comment.content = content;

        sub_comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.append(sub_comment_address);
    }
}
