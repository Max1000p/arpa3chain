// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Arpa3 is Ownable, ReentrancyGuard {
    
   //IERC20 public immutable arpa3Token;
   
    enum  WorkflowStatus { UserRecording, RecordPrivilege, VoteSessionStart, VoteSessionEnd }
    WorkflowStatus public workflowstatus;
    uint public counter;
    uint public number;
    struct Privilege{
        uint idP;
        uint amount;
        string description;
        uint nbVote;
        bool isActive;
    }

    Privilege[] privilegeArray;
    
    struct Proposal {
        address addresse;
        string name;
        string firstname;
        string service;
        uint nbvote;
    }

    Proposal[] proposalArray;

    struct Profil {
        string name;
        string firstname;
        uint nbVotePrivilege;
        uint allowedVotePrivilege;
        bool active;
    }

    mapping(address => Profil) public users;

    modifier onlyUsers() {
        require(users[msg.sender].active, "Account not recorded");
        _;
    }

    function addPrivilege(string calldata _description) external onlyUsers {
        require(workflowstatus == WorkflowStatus.RecordPrivilege, "Not allowed to record");
        require(users[msg.sender].active == true,"User not recorded");
        
        Privilege memory privilege;
        privilege.idP = counter;
        privilege.amount = 0;
        privilege.description = _description;
        privilege.isActive = false;
        privilegeArray.push(privilege);
    }

    function setNumber(uint _number) external {
        number = _number;
    }

    /// @notice Check if user is recorded on chain / Address and Proposal 
    function isAccountExist(address _address) external view returns(bool){
        return users[_address].active;
    }

}