// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Tether_Token{
    string public name = "tether token dummmy";
    string public symbol = "T";
    uint public decimal =18;
    uint256 public totalsupply=100000000000000000000;
    
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint _value
    );

    event Approve(
        address indexed _owner,
        address indexed _spender,
        uint _value
    );

    mapping(address=>uint256) balance;
    mapping(address=>mapping(address=>uint256)) allowance;

    constructor(){
        balance[msg.sender]=totalsupply;
    }

    function transfer(address _to, uint256 _value) public returns(bool success){
        require(balance[msg.sender]>=_value);
        balance[msg.sender]-=_value;
        balance[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool success){
        allowance[msg.sender][_spender]=_value;
        emit Approve(msg.sender,_spender,_value);
        return true;
    }

    function transferfrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(_value<=balance[_from],"Value should be less than your balance");
        require(_value<=allowance[_from][msg.sender],"Value should be less than allowance");
        balance[_from] -= _value;
        balance[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from,_to,_value);
        return true;
    }


}

