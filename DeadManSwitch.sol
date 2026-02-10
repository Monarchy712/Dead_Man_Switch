// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DeadManwitch
{
    enum ContractState {
        Active,
        Claimable,
        Claimed
    }

    address public owner;
    address public beneficiary;
    uint public totalAmt;
    uint public inactivityPeriod;
    uint public lastCheckIn;
    ContractState public state;


    constructor(address _beneficiary, uint _inactivityPeriod)
    {
        owner = msg.sender;
        lastCheckIn = block.timestamp;
        beneficiary = _beneficiary;
        inactivityPeriod = _inactivityPeriod;
    }

    function deposit() public payable {
        updateState();
        totalAmt += msg.value;
        require(state == ContractState.Active, "Contract not Active!");
        require(msg.sender == owner, "Only owner can deposit!");
        lastCheckIn = block.timestamp;
    }

    function updateState() internal {
        require(state != ContractState.Claimed, "Already Withdrawn!");
        if (block.timestamp>lastCheckIn+inactivityPeriod) state = ContractState.Claimable;
    }

    function checkIn() public{
        updateState();
        require(state == ContractState.Active, "Contract not Active!");
        require(msg.sender == owner, "Only owner can check in!");
        lastCheckIn = block.timestamp;
    }

    function claimFunds() public{
        updateState();
        require(state == ContractState.Claimable, "Funds not Claimable!");
        require(msg.sender==beneficiary,"You are not the beneficiary!");
        (bool success, ) = payable(beneficiary).call{value: totalAmt}("");
        require(success, "Transfer failed");
        state = ContractState.Claimed;
    }



}
