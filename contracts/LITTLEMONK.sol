// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LittleMonk is ERC20 {
    address private immutable _owner;
    uint256 public constant TOKENS_PER_ADDRESS = 500_000 * 10**18;
    uint256 public constant TOTAL_ADDRESSES = 1000;

    constructor(address[] memory recipients) ERC20("LITTLEMONK", "MONK") {
        _owner = msg.sender;
        
        // Mint total supply (1 billion)
        _mint(address(this), 1_000_000_000 * 10**18);
        
        // Automatically distribute to recipients
        for(uint256 i = 0; i < recipients.length; i++) {
            _transfer(address(this), recipients[i], TOKENS_PER_ADDRESS);
        }
        
        // Send remaining tokens to owner
        _transfer(address(this), _owner, balanceOf(address(this)));
    }
}