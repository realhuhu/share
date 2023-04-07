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
    address[] _user;

    modifier registered() {
        require(users[msg.sender]._registered, "E0");
        _;
    }

    modifier notRegistered() {
        require(!users[msg.sender]._registered, "E1");
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

    function selfInfo()
    registered public view returns (){

    }
}
