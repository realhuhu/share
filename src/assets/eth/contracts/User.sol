// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract User {
    uint public supply = 10;

    struct UserInfo {
        bool _registered;
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

    modifier not_registered() {
        require(!users[msg.sender]._registered, "123");
        _;
    }


    function register(string memory nickname)
    not_registered public returns (UserInfo memory) {
        address[] memory following;
        address[] memory follower;

        UserInfo memory user_info = UserInfo({
            _registered:true,
            avatar:"",
            nickname:nickname,
            signature:"",
            following:following,
            follower:follower,
            ID:0,
            major:""
        });

        users[msg.sender]=user_info;

        return user_info;
    }
}
