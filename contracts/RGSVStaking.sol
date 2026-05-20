// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RGSVStaking {

    IERC20 public token;

    mapping(address => uint256) public stakes;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function stake(uint256 amount) external {

        token.transferFrom(
            msg.sender,
            address(this),
            amount
        );

        stakes[msg.sender] += amount;
    }

    function unstake(uint256 amount) external {

        require(
            stakes[msg.sender] >= amount,
            "Not enough stake"
        );

        stakes[msg.sender] -= amount;

        token.transfer(msg.sender, amount);
    }
}
