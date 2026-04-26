// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MintExample {
    error MintAmountZero();
    error InvalidMintAmount(uint256 amount);

    uint256 public constant MAX_MINT_PER_TX = 100;

    mapping(address => uint256) public balanceOf;

    function mint(uint256 amount) external {
        if (amount == 0) revert MintAmountZero();
        if (amount > MAX_MINT_PER_TX) revert InvalidMintAmount(amount);

        balanceOf[msg.sender] += amount;
    }
}

contract MintStringRevert {
    mapping(address => uint256) public balanceOf;

    function mint(uint256 amount) external {
        if (amount == 0) revert("Mint amount is zero");

        balanceOf[msg.sender] += amount;
    }
}
