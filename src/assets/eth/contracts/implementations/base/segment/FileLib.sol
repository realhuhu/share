// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Types.sol";
import "./UserLib.sol";


library FileUtils {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;

    using UserLib for Types.UserStore;

    function toBriefInfo(
        Types.File storage file,
        Types.UserStore storage users
    ) public view returns (Types.FileBriefInfo memory file_info){
        file_info = file_info = Types.FileBriefInfo({
            file_address: file.file_address,
            category_address: file.category_address,
            is_buy: file.buyers[msg.sender],
            name: file.name,
            title: file.title,
            owner: users.user_info[file.owner].nickname,
            description: file.description,
            cover: file.images[0],
            price: file.price,
            up_num: file.up_num,
            down_num: file.down_num,
            buyer_num: file.buyer_num,
            comment_num: file.comment_num,
            up_and_down: file.up_and_downs[msg.sender],
            upload_timestamp: file.upload_timestamp
        });
    }

    function toDetailInfo(
        Types.File storage file
    ) public view returns (Types.FileDetailInfo memory detail_info) {
        detail_info = Types.FileDetailInfo({
            owner: file.owner,
            file_address: file.file_address,
            category_address: file.category_address,
            is_buy: file.buyers[msg.sender],
            is_mark: file.markers[msg.sender],
            name: file.name,
            title: file.title,
            description: file.description,
            ipfs_address: file.buyers[msg.sender] ? file.ipfs_address : "",
            images: file.images,
            price: file.price,
            up_num: file.up_num,
            down_num: file.down_num,
            mark_num: file.mark_num,
            buyer_num: file.buyer_num,
            comment_num: file.comment_num,
            up_and_down: file.up_and_downs[msg.sender],
            upload_timestamp: file.upload_timestamp
        });
    }

    function toRootComment(
        Types.FileComment storage comment,
        Types.UserStore storage users
    ) public view returns (Types.FileRootComment memory root_comment)  {
        Types.FileChildrenComment[2] memory children_comments;

        address current = address(0x1);
        for (uint i = 0; i < 2; i++) {
            current = comment.sub_comment_index.getNext(current);
            if (current == address(0x2)) break;
            children_comments[i] = toChildrenComment(comment.sub_comment_info[current], comment, users);
        }

        root_comment = Types.FileRootComment({
            comment_address: comment.comment_address,
            children_comments: children_comments,
            content: comment.content,
            images: comment.images,
            author: users.getOtherBriefInfo(comment.author),
            up_num: comment.up_num,
            down_num: comment.down_num,
            up_and_down: comment.up_and_downs[msg.sender],
            comment_num: comment.sub_comment_index.length,
            comment_timestamp: comment.comment_timestamp
        });
    }

    function toChildrenComment(
        Types.FileSubComment storage sub_comment,
        Types.FileComment storage comment,
        Types.UserStore storage users
    ) public view returns (Types.FileChildrenComment memory children_comment) {
        children_comment = Types.FileChildrenComment({
            target_address: sub_comment.target_address,
            comment_address: sub_comment.comment_address,
            sub_comment_address: sub_comment.sub_comment_address,
            content: sub_comment.content,
            author: users.getOtherBriefInfo(sub_comment.author),
            target_author: users.getOtherBriefInfo(comment.sub_comment_info[sub_comment.target_address].author),
            up_num: sub_comment.up_num,
            down_num: sub_comment.down_num,
            up_and_down: sub_comment.up_and_downs[msg.sender],
            comment_timestamp: sub_comment.comment_timestamp
        });
    }
}

library FileLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;

    using UserLib for Types.UserStore;

    using FileUtils for *;

    function init(Types.FileStore storage self)
    public {
        self.file_index.init();
        self._file_by_price.init();
        self._file_by_up_num.init();
        self._file_by_buyer_num.init();
    }

    function isContain(Types.FileStore storage self, address file_address)
    public view returns (bool is_contain) {
        is_contain = self.file_index.isContain(file_address);
    }

    function upload(
        Types.FileStore storage self,
        string memory ipfs_address,
        string memory name,
        string memory title,
        string memory description,
        address category_address,
        string[3] memory images,
        uint price
    ) public returns (address file_address){
        file_address = keccak256(abi.encodePacked(ipfs_address, title, msg.sender, block.timestamp)).toAddress();

        Types.File storage file_info = self.file_info[file_address];

        file_info.owner = msg.sender;
        file_info.file_address = file_address;
        file_info.category_address = category_address;

        file_info.name = name;
        file_info.title = title;
        file_info.description = description;
        file_info.ipfs_address = ipfs_address;

        file_info.images = images;

        file_info.price = price;
        file_info.upload_timestamp = block.timestamp;

        file_info.buyers[msg.sender] = true;

        file_info.comment_index.init();
        file_info._comments_by_up_num.init();

        self.file_index.append(file_address);
        self._file_by_price.update(AddressOrderedMap.Item(file_address, price));
        self._file_by_buyer_num.update(AddressOrderedMap.Item(file_address, 0));
    }

    function getBriefInfo(Types.FileStore storage self, address file_address, Types.UserStore storage users)
    public view returns (Types.FileBriefInfo memory file_info){
        file_info = self.file_info[file_address].toBriefInfo(users);
    }

    function getDetailInfo(Types.FileStore storage self, address file_address)
    public view returns (Types.FileDetailInfo memory detail_info){
        detail_info = self.file_info[file_address].toDetailInfo();
    }

    function getBriefInfos(
        Types.FileStore storage self,
        address cursor,
        address category_address,
        uint order,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = self._file_by_price.get(cursor, !reverse);
            } else if (order == 2) {
                cursor = self._file_by_buyer_num.get(cursor, !reverse);
            } else {
                cursor = self.file_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            if (self.file_info[cursor].category_address == category_address || category_address == address(0x0)) {
                file_infos[index] = self.file_info[cursor].toBriefInfo(users);
                index++;
            }

            next = cursor;
        }
    }

    function getUserBriefInfos(
        Types.FileStore storage self,
        address user_address,
        address cursor,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished) {
        address[10] memory file_index_slice = users.user_info[user_address].uploaded_files.slice(cursor, reverse);
        for (uint i = 0; i < 10; i++) {
            next = file_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            file_infos[i] = self.file_info[next].toBriefInfo(users);
        }
    }

    function getSelfBriefInfos(
        Types.FileStore storage self,
        address cursor,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished) {
        address[10] memory file_index_slice = users.user_info[msg.sender].uploaded_files.slice(cursor, reverse);
        for (uint i = 0; i < 10; i++) {
            next = file_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            file_infos[i] = self.file_info[next].toBriefInfo(users);
        }
    }

    function upAndDown(Types.FileStore storage self, address file_address, bool is_up)
    public {
        Types.File storage file = self.file_info[file_address];
        uint up_and_down = file.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, file.up_num, file.down_num, is_up);

        file.up_and_downs[msg.sender] = _up_and_down;
        file.up_num = _up_num;
        file.down_num = _down_num;

        self._file_by_up_num.update(AddressOrderedMap.Item(file_address, file.up_num));
    }

    function addComment(
        Types.FileStore storage self,
        address file_address,
        string memory content,
        string[3] memory images
    ) public {
        Types.File storage file = self.file_info[file_address];

        address comment_address = keccak256(abi.encodePacked(file_address, content, msg.sender, block.timestamp)).toAddress();

        Types.FileComment storage comment = file.comment_info[comment_address];

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

    function upAndDownComment(
        Types.FileStore storage self,
        address file_address,
        address comment_address,
        bool is_up
    ) public {
        Types.FileComment storage comment = self.file_info[file_address].comment_info[comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];


        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;


        self.file_info[file_address]._comments_by_up_num.update(AddressOrderedMap.Item(comment_address, comment.up_num));
    }

    function addSubComment(
        Types.FileStore storage self,
        address file_address,
        address target_address,
        address comment_address,
        string memory content
    ) public {
        Types.File storage file = self.file_info[file_address];
        Types.FileComment storage comment = file.comment_info[comment_address];

        address sub_comment_address = keccak256(abi.encodePacked(file_address, comment_address, content, msg.sender, block.timestamp)).toAddress();

        Types.FileSubComment storage sub_comment = comment.sub_comment_info[sub_comment_address];

        sub_comment.author = msg.sender;
        sub_comment.target_address = target_address;
        sub_comment.comment_address = comment_address;
        sub_comment.sub_comment_address = sub_comment_address;

        sub_comment.content = content;

        sub_comment.comment_timestamp = block.timestamp;

        comment.sub_comment_index.append(sub_comment_address);

        file.comment_num++;
    }

    function upAndDownSubComment(
        Types.FileStore storage self,
        address file_address,
        address comment_address,
        address sub_comment_address,
        bool is_up
    ) public {
        Types.FileSubComment storage comment = self.file_info[file_address].comment_info[comment_address].sub_comment_info[sub_comment_address];
        uint up_and_down = comment.up_and_downs[msg.sender];

        uint _up_and_down;
        uint _up_num;
        uint _down_num;

        (_up_and_down, _up_num, _down_num) = CommonLib.upAndDown(up_and_down, comment.up_num, comment.down_num, is_up);

        comment.up_and_downs[msg.sender] = _up_and_down;
        comment.up_num = _up_num;
        comment.down_num = _down_num;
    }

    function getRootComments(
        Types.FileStore storage self,
        address file_address,
        address cursor,
        uint order,
        bool reverse,
        Types.UserStore storage users
    ) public view returns (Types.FileRootComment[10] memory root_comments, address next, bool finished){
        Types.File storage file = self.file_info[file_address];

        uint index = 0;
        while (index < 10) {
            if (order == 1) {
                cursor = file._comments_by_up_num.get(cursor, !reverse);
            } else {
                cursor = file.comment_index.get(cursor, !reverse);
            }

            if (reverse && cursor == address(0x1) || !reverse && cursor == address(0x2)) {
                finished = true;
                break;
            }

            root_comments[index] = file.comment_info[cursor].toRootComment(users);

            index++;
            next = cursor;
        }
    }

    function getChildrenComments(
        Types.FileStore storage self,
        address file_address,
        address comment_address,
        address cursor,
        Types.UserStore storage users
    ) public view returns (Types.FileChildrenComment[10] memory children_comments, address next, bool finished) {
        Types.FileComment storage comment = self.file_info[file_address].comment_info[comment_address];

        uint index = 0;
        while (index < 10) {
            cursor = comment.sub_comment_index.getNext(cursor);

            if (cursor == address(0x2)) {
                finished = true;
                break;
            }

            children_comments[index] = comment.sub_comment_info[cursor].toChildrenComment(comment, users);
            index++;
            next = cursor;
        }
    }

    function mark(
        Types.FileStore storage self,
        address file_address
    ) public returns (bool is_mark){
        Types.File storage file = self.file_info[file_address];

        if (file.markers[msg.sender]) {
            is_mark = false;
            file.mark_num--;
            delete file.markers[msg.sender];
        } else {
            is_mark = true;
            file.mark_num++;
            is_mark = file.markers[msg.sender] = true;
        }
    }

    function getMarked(Types.FileStore storage self, address cursor, Types.UserStore storage users)
    public view returns (Types.FileBriefInfo[10] memory file_infos, address next, bool finished){
        address[10] memory file_index_slice = users.user_info[msg.sender].marked_files.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            next = file_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            file_infos[i] = self.file_info[next].toBriefInfo(users);
        }
    }
}

library CategoryLib {
    using AddressLinkedList for AddressLinkedList.T;
    using AddressOrderedMap for AddressOrderedMap.T;
    using Bytes32Lib for bytes32;

    function init(Types.CategoryStore storage self)
    public {
        self.category_index.init();
    }

    function isContain(Types.CategoryStore storage self, address category_address)
    public view returns (bool is_contain){
        is_contain = self.category_index.isContain(category_address);
    }

    function add(Types.CategoryStore storage self, string memory name)
    public {
        address category_address = keccak256(abi.encodePacked(name)).toAddress();

        Types.Category storage category_info = self.category_info[category_address];

        category_info.category_address = category_address;
        category_info.name = name;

        self.category_index.append(category_address);
    }

    function getSlice(Types.CategoryStore storage self, address cursor)
    public view returns (Types.Category[10] memory category_slice, address next, bool finished){
        address[10] memory category_index_slice = self.category_index.slice(cursor, false);
        for (uint i = 0; i < 10; i++) {
            next = category_index_slice[i];
            if (next == address(0x0)) {
                finished = true;
                break;
            }
            category_slice[i] = self.category_info[next];
        }
    }

    function increase(Types.CategoryStore storage self, address category_address)
    public {
        self.category_info[category_address].num++;
    }

}
