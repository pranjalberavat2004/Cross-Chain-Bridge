// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrossChainBridge {
    address public admin;
    mapping(address => mapping(uint256 => bool)) public processedNonces;

    event TokensLocked(address indexed sender, uint256 amount, string targetChain, uint256 nonce);
    event TokensUnlocked(address indexed receiver, uint256 amount, uint256 nonce);

    constructor() {
        admin = msg.sender;
    }

    function lockTokens(uint256 amount, string memory targetChain, uint256 nonce) external {
        require(!processedNonces[msg.sender][nonce], "Transfer already processed");
        processedNonces[msg.sender][nonce] = true;
        // Logic to lock tokens (could be extended to work with ERC20)
        emit TokensLocked(msg.sender, amount, targetChain, nonce);
    }

    function unlockTokens(address to, uint256 amount, uint256 nonce) external {
        require(msg.sender == admin, "Only admin can unlock tokens");
        require(!processedNonces[to][nonce], "Transfer already processed");
        processedNonces[to][nonce] = true;
        // Logic to unlock or mint tokens (extendable for ERC20 or native)
        emit TokensUnlocked(to, amount, nonce);
    }

    function changeAdmin(address newAdmin) external {
        require(msg.sender == admin, "Only current admin can change admin");
        admin = newAdmin;
    }
}

