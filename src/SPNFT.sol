// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SPNFT is ERC721("SPNFT", "SPNT") {
    uint256 _seq;

    constructor() {
        _seq = 0;
    }

    function mint(
        address to
    ) external returns (uint256) {
        uint256 newTokenId = _seq++;
        _mint(to, newTokenId);
        return newTokenId;
    }
}