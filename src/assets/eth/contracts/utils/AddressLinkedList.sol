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
    internal view returns (bool is_contain){
        is_contain = self._next[data] != address(0x0) || self._prev[data] != address(0x0);
    }

    modifier _notGuard_(address data){
        require(data != address(0x1) && data != address(0x2), "AddressLinkedList>_notGuard_");
        _;
    }
    modifier _notHeadGuard_(address data){
        require(data != address(0x1), "AddressLinkedList>_notHeadGuard_");
        _;
    }

    modifier _notTailGuard_(address data){
        require(data != address(0x2), "AddressLinkedList>_notTailGuard_");
        _;
    }

    modifier _contain_(T storage self, address data){
        require(_inList(self, data), "AddressLinkedList>_contain_");
        _;
    }

    modifier _notContain_(T storage self, address data){
        require(!_inList(self, data), "AddressLinkedList>_notContain_");
        _;
    }

    modifier _initialized_(T storage self){
        require(self._init, "AddressLinkedList>_initialized_");
        _;
    }

    function init(T storage self)
    public {
        if (self._init) return;
        self._init = true;
        self._next[address(0x1)] = address(0x2);
        self._prev[address(0x2)] = address(0x1);
        self.length = 0;
    }

    function getNext(T storage self, address data)
    _initialized_(self) _contain_(self, data) _notTailGuard_(data)
    public view returns (address next) {
        next = self._next[data];
    }

    function getPrev(T storage self, address data)
    _initialized_(self) _contain_(self, data) _notHeadGuard_(data)
    public view returns (address prev) {
        prev = self._prev[data];
    }

    function isContain(T storage self, address data)
    _initialized_(self)
    public view returns (bool is_contain) {
        is_contain = _inList(self, data);
    }

    function insertAfter(T storage self, address target, address data)
    _initialized_(self) _contain_(self, target) _notTailGuard_(target) _notContain_(self, data)
    public {
        address next_target = self._next[target];
        self._next[target] = data;
        self._next[data] = next_target;
        self._prev[data] = target;
        self._prev[next_target] = data;
        self.length++;
    }


    function insertBefore(T storage self, address target, address data)
    _initialized_(self) _contain_(self, target) _notHeadGuard_(target) _notContain_(self, data)
    public {
        require(target != address(0x1), "AddressLinkedList>insertBefore");
        address prev_target = self._prev[target];
        self._next[prev_target] = data;
        self._next[data] = target;
        self._prev[data] = prev_target;
        self._prev[target] = data;
        self.length++;
    }

    function remove(T storage self, address data)
    _initialized_(self) _contain_(self, data) _notGuard_(data)
    public {
        self._next[self._prev[data]] = self._next[data];
        self._prev[self._next[data]] = self._prev[data];
        delete self._prev[data];
        delete self._next[data];
        self.length--;
    }

    function prepend(T storage self, address data)
    _initialized_(self)
    public {
        insertAfter(self, address(0x1), data);
    }

    function append(T storage self, address data)
    _initialized_(self)
    public {
        insertBefore(self, address(0x2), data);
    }

    function moveAfter(T storage self, address target, address data)
    _initialized_(self) _contain_(self, target) _notTailGuard_(target) _contain_(self, data)
    public {
        if (self._prev[data] != target) {
            remove(self, data);
            insertAfter(self, target, data);
        }
    }

    function moveBefore(T storage self, address target, address data)
    _initialized_(self) _contain_(self, target) _notHeadGuard_(target) _contain_(self, data)
    public {
        if (self._next[data] != target) {
            remove(self, data);
            insertBefore(self, target, data);
        }
    }


    function switchData(T storage self, address data1, address data2)
    _initialized_(self) _contain_(self, data1) _notGuard_(data1) _contain_(self, data2) _notGuard_(data2)
    public {
        address prev_data1 = self._prev[data1];
        address prev_data2 = self._prev[data2];
        address next_data1 = self._next[data1];
        address next_data2 = self._next[data2];

        if (prev_data1 == data2) {
            self._next[prev_data2] = self._prev[data2] = data1;
            self._prev[next_data1] = self._next[data1] = data2;
            self._next[data2] = next_data1;
            self._prev[data1] = prev_data2;
        } else if (prev_data2 == data1) {
            self._prev[next_data2] = self._next[data2] = data1;
            self._next[prev_data1] = self._prev[data1] = data2;
            self._prev[data2] = prev_data1;
            self._next[data1] = next_data2;
        } else {
            self._next[prev_data2] = self._prev[next_data2] = data1;
            self._next[prev_data1] = self._prev[next_data1] = data2;
            self._next[data2] = next_data1;
            self._prev[data1] = prev_data2;
            self._prev[data2] = prev_data1;
            self._next[data1] = next_data2;
        }
    }

    function slice(T storage self, address cursor, bool reverse)
    _initialized_(self) _contain_(self, cursor)
    public view returns (address[10] memory result){
        address current = cursor;
        uint num = 0;

        if (reverse) {
            while (num < 10) {
                current = self._prev[current];
                if (current == address(0x0) || current == address(0x1)) break;
                result[num] = current;
                num++;
            }
        } else {
            while (num < 10) {
                current = self._next[current];
                if (current == address(0x0) || current == address(0x2)) break;
                result[num] = current;
                num++;
            }
        }
    }
}
