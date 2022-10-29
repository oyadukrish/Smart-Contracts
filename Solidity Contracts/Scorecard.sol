// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract Scorecard {
    
    struct student {
        string first;
        string last;
        
    }

    struct subjectScores{
        string subjectName;
        string scoreValue;
    }

    event details(uint studId,string name1, string name2);

    address public tutor;
    mapping(uint=>student) public students;
    mapping(uint=>subjectScores) public scores;
    uint[] public studentList=new uint[](7);

    constructor() {
        tutor = msg.sender;
    }

    modifier checkingOwnership() {
        require(tutor==msg.sender,"You are not authorized to manipulate data in this contract");
        _;
    }

    student public stud;
    subjectScores public score;

    function newStudent(uint studentId, string memory firstName,string memory lastName) public checkingOwnership {
        stud = student(firstName,lastName);
        students[studentId] = stud;
        studentList.push(studentId);
        emit details(studentId,stud.first,stud.last);
    }

    function newScore(uint studentId, string memory subject, string memory mark) public payable  checkingOwnership {
        for(uint i=0;i<=studentList.length;i++){
            if(studentList[i] == studentId){
                score = subjectScores(subject,mark);
                scores[studentId] = score;
                
                break;
            }
            else {
                console.log("The ID entered does not exist");
            }
        }
        
    }
    
}