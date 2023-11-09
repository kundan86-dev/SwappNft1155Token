// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract MyToken is ERC20 {
    constructor()  ERC20("MYTOKEN","MYTKN"){
     _mint(msg.sender, 100000*10**decimals());

    }
}