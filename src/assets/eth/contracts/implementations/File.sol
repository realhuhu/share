//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface FileInterface {
    function addCategory(string memory name) external;

    function getCategorySlice(address cursor) external view returns (StoreContact.Category[10] memory category_slice, address next);

    function uploadFile(address ipfs_address, string memory title, string memory description, address category, string[3] memory images, uint price) external;

    function getSelfFileInfos(address cursor, bool reverse) external view returns (StoreContact.FileInfo[10] memory file_infos, address next);
}

abstract contract FileContact is BaseContact, FileInterface {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    function FileContact_init()
    internal {
        categories.category_index.init();
        files.file_index.init();
        files._file_by_price.init();
        files._file_by_buyer_num.init();
    }

    function addCategory(string memory name)
    _onlyAdmin_
    external {
        address category_address = toAddress(keccak256(abi.encodePacked(name)));
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
        address ipfs_address,
        string memory title,
        string memory description,
        address category,
        string[3] memory images,
        uint price
    )
    external {
        _registered_(msg.sender);
        _stringRange_(title, 1, 64);
        _stringRange_(description, 1, 512);
        _uintRange_(price, 1, 20);
        _validCategory_(category);

        address file_address = toAddress(keccak256(abi.encodePacked(title)));
        File storage file_info = files.file_info[file_address];

        file_info.file_address = file_address;
        file_info.ipfs_address = ipfs_address;
        file_info.owner = msg.sender;
        file_info.title = title;
        file_info.description = description;
        file_info.category = category;
        file_info.images = images;
        file_info.upload_timestamp = block.timestamp;
        file_info.price = price;
        file_info.buyer_num = 0;
        files.file_index.append(file_address);
        files._file_by_price.update(AddressOrderedMap.Item(file_address, price));
        files._file_by_buyer_num.update(AddressOrderedMap.Item(file_address, 0));

        address message_address = toAddress(keccak256(abi.encodePacked(file_address)));
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

    function _toFileInfo(File storage file)
    internal view returns (FileInfo memory file_info){
        file_info.file_address = file.file_address;
        file_info.ipfs_address = file.ipfs_address;
        file_info.owner = file.owner;
        file_info.title = file.title;
        file_info.description = file.description;
        file_info.images = file.images;
        file_info.upload_timestamp = file.upload_timestamp;
        file_info.price = file.price;
    }

    function getSelfFileInfos(address cursor, bool reverse)
    external view returns (FileInfo[10] memory file_infos, address next){
        _registered_(msg.sender);

        address[10] memory file_index_slice = users.user_info[msg.sender].uploaded_files.slice(cursor, reverse);
        for (uint i = 0; i < 10; i++) {
            next = file_index_slice[i];
            if (next == address(0x0)) break;
            file_infos[i] = _toFileInfo(files.file_info[next]);
        }

    }
}
