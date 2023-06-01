//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "./Admin.sol";
import "./Store.sol";


contract BaseContact is AdminContract, StoreContact {
    function _registered_(address user_address)
    internal view {
        require(users.user_info[user_address].login_timestamp != 0);
    }

    function _uploaded_(address file_address)
    internal view {
        require(files.file_info[file_address].file_address != address(0x0));
    }

    function _published_(address reward_address)
    internal view {
        require(rewards.reward_info[reward_address].reward_address != address(0x0));
    }

    function _file_commented_(address file_address, address comment_address)
    internal view {
        require(files.file_info[file_address].comment_info[comment_address].comment_address != address(0x0));
    }

    function _reward_commented_(address reward_address, address comment_address)
    internal view {
        require(rewards.reward_info[reward_address].comment_info[comment_address].comment_address != address(0x0));
    }

    function _file_sub_commented_(address file_address, address comment_address, address sub_comment_address)
    internal view {
        require(files.file_info[file_address].comment_info[comment_address].sub_comment_info[sub_comment_address].sub_comment_address != address(0x0));
    }

    function _reward_sub_commented_(address reward_address, address comment_address, address sub_comment_address)
    internal view {
        require(rewards.reward_info[reward_address].comment_info[comment_address].sub_comment_info[sub_comment_address].sub_comment_address != address(0x0));
    }
}
