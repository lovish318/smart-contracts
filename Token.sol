// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Lovish is ERC20, Ownable {

    uint maxSupply = 1500000000000000000000000000;

    constructor() ERC20("Lovish", "LK") {
    }
    function mint(address to, uint amount) public  onlyOwner {
        require(maxSupply > (totalSupply() + amount), "Token's max supply reached");
        return _mint(to,amount);
    } 
}