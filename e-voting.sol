// Voting.sol
pragma solidity ^0.8.0;

contract Voting {
    address public admin;
    mapping(address => bool) public voters;
    mapping(bytes32 => uint256) public votes;
    bool public votingOpen;

    event Voted(address indexed voter, bytes32 candidate);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyVotingOpen() {
        require(votingOpen, "Voting is closed");
        _;
    }

    constructor() {
        admin = msg.sender;
        votingOpen = true;
    }

    function registerVoter(address _voter) external onlyAdmin {
        voters[_voter] = true;
    }

    function startVoting() external onlyAdmin {
        votingOpen = true;
    }

    function closeVoting() external onlyAdmin {
        votingOpen = false;
    }

    function vote(bytes32 _candidate) external onlyVotingOpen {
        require(voters[msg.sender], "You are not a registered voter");
        votes[_candidate]++;
        emit Voted(msg.sender, _candidate);
    }
}
