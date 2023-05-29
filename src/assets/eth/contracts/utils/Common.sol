// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

library Common {

    function upAndDown(uint up_and_down, uint up_num, uint down_num, bool is_up)
    external pure returns (uint _up_and_down, uint _up_num, uint _down_num){
        if (up_and_down == 0) {//未操作
            if (is_up) {
                _up_and_down = 1;

                _up_num = up_num + 1;
                _down_num = down_num;
            } else {
                _up_and_down = 2;

                _up_num = up_num;
                _down_num = down_num + 1;
            }
        } else if (up_and_down == 1) {//已点赞
            if (is_up) {
                _up_and_down = 0;

                _up_num = up_num - 1;
                _down_num = down_num;
            } else {
                _up_and_down = 2;

                _up_num = up_num - 1;
                _down_num = down_num + 1;
            }
        } else if (up_and_down == 2) {//已点踩
            if (is_up) {
                _up_and_down = 1;

                _up_num = up_num + 1;
                _down_num = down_num - 1;
            } else {
                _up_and_down = 0;

                _up_num = up_num;
                _down_num = down_num - 1;
            }
        }
    }
}
