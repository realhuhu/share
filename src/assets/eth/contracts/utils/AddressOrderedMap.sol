// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./AddressLinkedList.sol";

library AddressOrderedMap {
    using AddressLinkedList for AddressLinkedList.T;

    struct T {
        AddressLinkedList.T _keys;
        mapping(address => uint) _values;
    }

    struct Item {
        address key;
        uint value;
    }

    function init(T storage self)
    public {
        self._keys.init();
    }

    function update(T storage self, Item memory item)
    public {
        if (self._keys.isContain(item.key)) {
            address current = item.key;
            uint before = self._values[item.key];
            if (before > item.value) {
                while (true) {
                    current = self._keys._next[current];
                    if (current == address(0x2) || self._values[current] <= item.value) {
                        self._keys.moveBefore(current, item.key);
                        self._values[item.key] = item.value;
                        break;
                    }
                }
                self._values[item.key] = item.value;
            } else if (before < item.value) {
                while (true) {
                    current = self._keys._prev[current];
                    if (current == address(0x1) || self._values[current] >= item.value) {
                        self._keys.moveAfter(current, item.key);
                        self._values[item.key] = item.value;
                        break;
                    }
                }
            }
        } else {
            address current = address(0x1);
            while (true) {
                if (current == address(0x2)) {
                    self._keys.append(item.key);
                    self._values[item.key] = item.value;
                    break;
                }

                if (item.value >= self._values[self._keys._next[current]]) {
                    self._keys.insertAfter(current, item.key);
                    self._values[item.key] = item.value;
                    break;
                }

                current = self._keys._next[current];
            }
        }
    }

    function remove(T storage self, address key)
    public {
        self._keys.remove(key);
        delete self._values[key];
    }

    function isContain(T storage self, address key)
    public view returns (bool is_contain) {
        is_contain = self._keys.isContain(key);
    }

    function getLength(T storage self)
    public view returns (uint length){
        length = self._keys.length;
    }

    function getNext(T storage self, address key)
    public view returns (address next){
        next = self._keys.getNext(key);
    }

    function getPrev(T storage self, address key)
    public view returns (address prev){
        prev = self._keys.getPrev(key);
    }

    function getKeys(T storage self, address cursor, bool reverse)
    public view returns (address[10] memory keys) {
        address[10] memory results = self._keys.slice(cursor, reverse);
        address current;
        for (uint i = 0; i < 10; i++) {
            current = results[i];
            if (current == address(0x0)) break;
            keys[i] = current;
        }

    }

    function getValues(T storage self, address cursor, bool reverse)
    public view returns (uint[10] memory values) {
        address[10] memory keys = getKeys(self, cursor, reverse);
        uint current;
        for (uint i = 0; i < 10; i++) {
            current = self._values[keys[i]];
            if (current == 0) break;
            values[i] = current;
        }
    }

    function getValue(T storage self, address key)
    public view returns (uint value) {
        value = self._values[key];
    }

    function slice(T storage self, address cursor, bool reverse)
    public view returns (Item[10] memory items) {
        address[10] memory keys = getKeys(self, cursor, reverse);
        address current;
        for (uint i = 0; i < 10; i++) {
            current = keys[i];
            if (current == address(0x0)) break;
            items[i].key = current;
            items[i].value = self._values[current];
        }
    }
}
