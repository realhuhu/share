// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract User {
    uint public supply = 10;

    struct UserInfo {
        string avatar; // 头像
        string nickname; // 昵称
        string signature; //签名
        address[] following; //我的关注
        address[] follower; //关注我的
        uint ID; // 校园卡ID
        string major; // 专业
    }

    mapping(address => UserInfo) users;
    mapping(address=>bool) _user;

    modifier registered() {
        require(_user[msg.sender], "E0");
        _;
    }

    modifier notRegistered() {
        require(!_user[msg.sender], "E1");
        _;
    }


    function register(string memory nickname)
    notRegistered public returns (UserInfo memory user_info) {
        address[] memory following;
        address[] memory follower;

        user_info = UserInfo({
            avatar: "",
            nickname: nickname,
            signature: "",
            following: following,
            follower: follower,
            ID: 0,
            major: ""
        });

        users[msg.sender] = user_info;
    }
}
