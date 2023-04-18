// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

library AddressLinkedList {
    struct T {
        mapping(address => address) _next;
        mapping(address => address) _prev;
        bool _init;
        uint length;
    }

    function _inList(T storage self, address data)
    public view returns (bool is_contain){
        is_contain = self._next[data] != address(0x0) || self._prev[data] != address(0x0);
    }

    modifier _notGuard_(address data){
        require(data != address(0x1) && data != address(0x2), "E");
        _;
    }
    modifier _notHeadGuard_(address data){
        require(data != address(0x1), "E");
        _;
    }

    modifier _notTailGuard_(address data){
        require(data != address(0x2), "E");
        _;
    }

    modifier _contain_(T storage self, address data){
        require(_inList(self, data), "E2: Lib.sol>AddressLinkedList>_contain_");
        _;
    }

    modifier _notContain_(T storage self, address data){
        require(_inList(self, data), "E3: Lib.sol>AddressLinkedList>_notContain_");
        _;
    }

    function init(T storage self)
    public {
        if (self._init) return;
        self._init = true;
        self.length = 0;
        self._next[address(0x1)] = address(0x2);
        self._prev[address(0x2)] = address(0x1);
    }

    function contain(T storage self, address data)
    public view returns (bool is_contain) {
        is_contain = _inList(self, data);
    }

    function insertAfter(T storage self, address target, address data)
    _contain_(self, target) _notTailGuard_(target) _notContain_(self, data)
    public {
        address next_target = self._next[target];
        self._next[target] = data;
        self._next[data] = next_target;
        self._prev[data] = target;
        self._prev[next_target] = data;
        self.length++;
    }

    function insertBefore(T storage self, address target, address data)
    _contain_(self, target) _notHeadGuard_(target) _notContain_(self, data)
    public {
        require(target != address(0x1));
        address prev_target = self._prev[target];
        self._next[prev_target] = data;
        self._next[data] = target;
        self._prev[data] = prev_target;
        self._prev[target] = data;
        self.length++;
    }

    function prepend(T storage self, address data)
    public {
        insertAfter(self, address(0x1), data);
    }

    function append(T storage self, address data)
    public {
        insertBefore(self, address(0x2), data);
    }

    function remove(T storage self, address data)
    _contain_(self, data) _notGuard_(data)
    public {
        self._next[self._prev[data]] = self._next[data];
        self._prev[self._next[data]] = self._prev[data];
        delete self._prev[data];
        delete self._next[data];
        self.length--;
    }

    function switchData(T storage self, address data1, address data2)
    _contain_(self, data1) _notGuard_(data1) _contain_(self, data2) _notGuard_(data2)
    public {
        address prev_data1 = self._prev[data1];
        address prev_data2 = self._prev[data2];
        address next_data1 = self._next[data1];
        address next_data2 = self._next[data2];

        self._next[prev_data2] = self._prev[next_data2] = data1;
        self._next[prev_data1] = self._prev[next_data1] = data2;
        self._next[data1] = next_data2;
        self._next[data2] = next_data1;
        self._prev[data1] = prev_data2;
        self._prev[data2] = prev_data1;
    }

    function slice(T storage self, address cursor, bool reverse)
    _contain_(self, cursor)
    public view returns (address[10] memory result){
        address current = cursor;
        uint num = 0;
        if (reverse) {
            while (num < 10) {
                current = self._prev[current];
                if (current != address(0x0) || current == address(0x1)) break;
                result[num] = current;
                num++;
            }
        } else {
            while (num < 10) {
                current = self._next[current];
                if (current != address(0x0) || current == address(0x2)) break;
                result[num] = current;
                num++;
            }
        }
    }
}

//library AddressOrderedLinkedList {
//    using AddressLinkedList for AddressLinkedList.T;
//    struct T {
//        AddressLinkedList.T _data;
//        mapping(address => uint) _value;
//    }
//
//    function init(T storage self)
//    public {
//        if (self._data._init) return;
//        self._data._init = true;
//        self._data.init();
//    }
//
//    function contain(T storage self, address data)
//    public view returns (bool is_contain){
//        is_contain = self._data.contain(data);
//    }
//
//    function addData(T storage self, address data, uint value)
//    public {
//        address cursor = address(0x1);
//        while (true) {
//            if (self._value[cursor] < value || cursor == address(0x2)) {
//                self._data.insertBefore(cursor, data);
//                self._value[data] = value;
//                return;
//            }
//
//            cursor = self._data._next[cursor];
//        }
//    }
//
//    function updateValue(T storage self, address data, uint value)
//    public {
//
//    }
//
//    function getValue(T storage self, address data)
//    public view returns (uint value){
//        value = self._value[data];
//    }
//}
//
//library FileStore {
//    struct File {
//        address ipfs_address;
//        address uploader;
//        uint upload_timestamp;
//        string title;
//        string description;
//        uint price;
//        uint heat;
//        mapping(address => uint) brought_timestamp;
//    }
//
//    struct T {
//        uint length;
//        mapping(address => File) files;
//
//        bool _init;
//        mapping(address => address) _next_by_timestamp;
//        mapping(address => address) _prev_by_timestamp;
//        mapping(address => address) _next_by_heat;
//        mapping(address => address) _prev_by_next;
//    }
//
//    function init(T storage self)
//    public {
//        if (self._init) return;
//        self._init = true;
//        self.length = 0;
//        self._next_by_timestamp[address(0x1)] = address(0x2);
//        self._next_by_timestamp[address(0x2)] = address(0x1);
//        self._next_by_heat[address(0x1)] = address(0x2);
//        self._next_by_heat[address(0x2)] = address(0x1);
//    }
//
//    function upload(T storage self, address ipfs_address, string memory title, string memory description, uint price)
//    public {
//        require(contain(self, ipfs_address), "E4: Lib.sol>FileStore>upload");
//        File storage new_file = self.files[ipfs_address];
//
//        new_file.ipfs_address = ipfs_address;
//        new_file.uploader = msg.sender;
//        new_file.upload_timestamp = block.timestamp;
//        new_file.title = title;
//        new_file.description = description;
//        new_file.price = price;
//
//        // address last = self._prev[address(0x2)];
//        // self._prev[value] = last;
//        // self._next[value] = address(0x2);
//        // self._prev[address(0x2)] = self._next[last] = value;
//        // self.length++;
//    }
//
//    function contain(T storage self, address ipfs_address)
//    public view returns (bool is_contian){
//        is_contian = self.files[ipfs_address].upload_timestamp != 0;
//    }
//}
