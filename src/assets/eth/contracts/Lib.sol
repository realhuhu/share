// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

library AddressLinkedList {
    struct T {
        mapping(address => address) _next;
        mapping(address => address) _prev;
        bool _init;
        uint length;
    }

    function init(T storage self)
    public {
        if (self._init) return;
        self._init = true;
        self.length = 0;
        self._next[address(0x1)] = address(0x2);
        self._prev[address(0x2)] = address(0x1);
    }

    function contain(T storage self, address value)
    public view returns (bool is_contain){
        is_contain = self._next[value] != address(0x0) || self._prev[value] != address(0x0);
    }

    function append(T storage self, address value)
    public {
        require(!contain(self, value), "E3: Lib.sol>AddressLinkedList>append");
        address last = self._prev[address(0x2)];
        self._prev[value] = last;
        self._next[value] = address(0x2);
        self._prev[address(0x2)] = self._next[last] = value;
        self.length++;
    }

    function remove(T storage self, address value)
    public {
        require(contain(self, value), "E2: Lib.sol>AddressLinkedList>remove");
        self._next[self._prev[value]] = self._next[value];
        self._prev[self._next[value]] = self._prev[value];
        self._prev[value] = self._next[value] = address(0x0);
        self.length--;
    }

    function slice(T storage self, address cursor, bool reverse)
    public view returns (address[10] memory result){
        require(contain(self, cursor), "E2: Lib.sol>AddressLinkedList>slice");
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

library FileStore{
    struct File{
        address ipfs_address;
        address uploader;
        uint timestamp;
        string title;
        string description;
        uint price;
        uint heat;
    }
    struct T{
        mapping(address=>File) files;
        mapping (address=>address) _next_by_timestamp;
    }  
}