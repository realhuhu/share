//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./base/Base.sol";

interface FileInterface {
    function uploadFile(address ipfs_address, string memory title, string memory description, bytes[][3] memory images, uint price) external;
}

abstract contract FileContact is BaseContact {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    function FileContact_init()
    internal {
        files.file_index.init();
        files._file_by_price.init();
        files._file_by_buyer_num.init();
    }

    function uploadFile(
        address ipfs_address,
        string memory title,
        string memory description,
        bytes[][3] memory images,
        uint price
    ) external {
        address file_address = toAddress(keccak256(abi.encodePacked(ipfs_address, title, description, price)));

        File storage file_info = files.file_info[file_address];

        file_info.ipfs_address = ipfs_address;
        file_info.owner = msg.sender;
        file_info.title = title;
        file_info.description = description;
        file_info.images = images;
        file_info.upload_timestamp = block.timestamp;
        file_info.price = price;

        files.file_index.append(file_address);
        files._file_by_price.update(AddressOrderedMap.Item(file_address, price));
        files._file_by_buyer_num.update(AddressOrderedMap.Item(file_address, 0));
    }
}
