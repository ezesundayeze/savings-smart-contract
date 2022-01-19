// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// A smart contract for intermittent savings
contract Savings{
    //The amount of money in the savings account
    uint public totalBalance;
    // The savers
    mapping(address => uint) public savers;

    //Add event for when money is added to the account
    event Added(uint amount);
    event Withdrawn(uint amount);

    receive() external payable{
        //Add the amount of money received to the balance
        emit Added(msg.value);
        
    }

    //Add money to the account
    function add(uint amount) external payable{
        // add the amount to the saver's balance
        savers[msg.sender] += amount;
        // add the amount to the total balance
        totalBalance += amount;
    }

    //Withdraw money from the account
    function withdraw(uint amount) external payable{
        //Check if the amount is less than the total balance
        require(amount <= totalBalance);
        // Check if the sender has enough money in the account
        require(savers[msg.sender] >= amount);
        //Subtract the amount from the sender's balance
        savers[msg.sender] -= amount;
        //Subtract the amount from the total balance
        totalBalance -= amount;
        //Send the amount to the sender
        payable (address(this)).transfer(amount); 

        emit Withdrawn(amount);       
    }
}