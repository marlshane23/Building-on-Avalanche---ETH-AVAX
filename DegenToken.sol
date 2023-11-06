// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DegenToken is ERC20, Ownable {
    constructor() ERC20("Degen", "DGN") Ownable() {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transfer(address recipient, uint256 amount) override public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeem(uint256 choice) public returns (bool) {
        uint256 cost;
        if (choice == 1) {
            cost = 100; // Cost for Points
        } else if (choice == 2) {
            cost = 200; // Cost for Token
        } else if (choice == 3) {
            cost = 300; // Cost for Gems
        } else {
            revert("Invalid choice");
        }

        require(balanceOf(msg.sender) >= cost, "Insufficient balance");

        emit RedeemItems(msg.sender, choice);

        _burn(msg.sender, cost); // Burn the redeemed tokens.

        return true;
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

     function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to burn");
        _burn(msg.sender, amount);
    }

    function showItems() public pure returns (string memory) {
        return "1: Points - 100 tokens\n2: Token - 200 tokens\n3: Gems - 300 tokens";
    }

    event RedeemItems(address indexed player, uint256 amount);

}

