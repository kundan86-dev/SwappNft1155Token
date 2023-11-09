// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract My1155Token is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private tokenId;

    constructor() ERC1155(""){}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mintt(address account, uint256 amount) public onlyOwner
    {
        tokenId.increment();
      uint256 newId=tokenId.current();
        _mint(account, newId, amount, " ");
    }

    function safeTransferFromm(address from, address to, uint256 newId,uint256 amount) public {
        _safeTransferFrom(from, to, newId, amount, "");
    }
    
    function burnn(address from ,uint256 newId,uint amount) public{
        _burn(from, newId, amount);
    } 

}
