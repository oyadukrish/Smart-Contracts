// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract rent{
    string public carName;
    uint public rentStartTime;
    uint public rentEndTime;
    uint public totalTimeUsed;
    address payable public ownerAddress;
    uint public balance;
    address public requester = msg.sender;
    constructor() payable{
        ownerAddress = payable(msg.sender);
    }
    
    modifier checkingOwnership() {
        requester=msg.sender;
        require(requester!=ownerAddress,"You cannot rent a car since you are the owner");
        _;
    }
    mapping(string=>bool) public carStatus;
    function renting(string  memory car) public checkingOwnership{
        require(keccak256(bytes(car)) == keccak256(bytes("A"))||keccak256(bytes(car)) == keccak256(bytes("B"))|| keccak256(bytes(car)) == keccak256(bytes("C")), "The entered car does not exist");
        carStatus[car]=true;
        rentStartTime = block.timestamp;
    }
    function stopRent (string memory vehicle) public checkingOwnership{
        require(carStatus[vehicle]==true,"The entered vehicle has not been rented");
        carStatus[vehicle]=false;
        rentEndTime = block.timestamp;
        totalTimeUsed = (rentEndTime-rentStartTime);
    }
    function payRent() payable public {
        balance=address(msg.sender).balance;
        require(msg.sender.balance>totalTimeUsed,"This account doesnt have sufficient balance");
        ownerAddress.transfer(totalTimeUsed);
    }
}