// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SPT is ERC20("SPT", "SP") {

    function mint(
        address to,
        uint256 amount
    ) external {
        _mint(to, amount);
    }
}