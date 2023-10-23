# Building on Avalanche - ETH + AVAX

The DegenToken contract is an ERC20 token contract with additional functionalities. It is built using the Solidity programming language and utilizes the OpenZeppelin library for secure and standardized contract development

## Description
The DegenToken contract is a unique project that combines the standard functionalities of an ERC20 token with additional features that cater to a specific use case. Built using the Solidity programming language, this contract secure OpenZeppelin library to ensure the highest standards of security and efficiency.

The contract creates an ERC20 token named “Degen” with the symbol “DGN”. The contract owner has exclusive privileges to mint new tokens, which can then be transferred between addresses. What sets this contract apart is its redeem feature, which allows token holders to redeem their tokens for various items, each with a specific cost in tokens. This feature introduces a use case for the token beyond simple transfer of value, making it particularly suitable for gaming or reward-based platforms.

## Getting Started
### Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenToken.sol). Copy and paste the following code into the file:
```
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

    function burn(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
    }

    function showItems() public pure returns (string memory) {
        return "1: Points - 100 tokens\n2: Token - 200 tokens\n3: Gems - 300 tokens";
    }

    event RedeemItems(address indexed player, uint256 amount);

}
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18", and then click on the "Compile DegenToken.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenToken" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the functions.

## Authors
Marl Shane G. Esteron
