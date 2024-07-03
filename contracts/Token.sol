// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "hardhat/console.sol";

contract Token is ERC20 {

    address public owner;

    constructor(uint256 supply) ERC20("Token", "DRSC") {
        _mint(msg.sender, supply);
        owner = msg.sender;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(amount <= balanceOf(msg.sender), "ERC20: transfer amount exceeds balance");

        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(amount <= balanceOf(sender), "ERC20: transfer amount exceeds balance");
        require(amount <= allowance(sender, _msgSender()), "ERC20: transfer amount exceeds allowance");

        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()));
        return true;
    }

    function getOwnerAddress() public view returns(address) {
        return owner;
    }
}
