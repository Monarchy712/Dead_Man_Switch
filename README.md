# Dead Man Switch

A Solidity smart contract that securely transfers locked funds to a designated beneficiary if the owner remains inactive beyond a defined time threshold.

## Overview

This contract implements a time-based inactivity mechanism ("dead man's switch") where:

- The owner deposits funds into the contract
- The owner must periodically signal activity
- If inactivity exceeds the predefined threshold, the beneficiary can withdraw the locked funds

## Key Features

- Time-based inactivity logic
- Secure access control (owner / beneficiary roles)
- Clean state transitions
- Disciplined fund flow management
- Minimal and security-focused design

## Why It Matters

Even simple smart contract architectures demand careful attention to:

- State consistency
- Authorization checks
- Reentrancy considerations
- Logical correctness under edge cases

## Tech Stack

- Solidity
- Ethereum-compatible network
