// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

interface IERC1155{
    function balanceOf(address account, uint256 id) external view returns (uint256);
    function safeTransferFrom(address from, address to, uint256 id, uint256 value, bytes calldata data) external;
}

contract SwappingNft is Ownable {
    IERC20 public ERC20Token;
    IERC1155 public nftToken; 
    uint256 tokenPrice = 1000 wei;
    address payable admin;
   

    constructor(IERC20 _ERC20Token, IERC1155 _nftToken){
        ERC20Token = _ERC20Token;
        nftToken = _nftToken;
        admin=payable(msg.sender);
    }

    function buyToken(uint256 _howManyToken) public payable{
        require(_howManyToken*tokenPrice>=msg.value,"Value must be paid equal to token price");
        
        admin.transfer(msg.value);
        ERC20Token.transferFrom(admin,msg.sender ,_howManyToken*10e18);
    }

    function getFungibleNFT(uint256 _noOfNFTWant, uint256 _id) public {

        require(_noOfNFTWant>0,"Please enter some amount");
        require(ERC20Token.balanceOf(msg.sender)>=_noOfNFTWant,"You don't have enough token balance");
        require(nftToken.balanceOf(admin,_id)>=_noOfNFTWant,"You don't have enough token balance");
        
        ERC20Token.transferFrom(msg.sender,admin,_noOfNFTWant*10e18);
        nftToken.safeTransferFrom(admin,msg.sender,_id,_noOfNFTWant,"0xhello");
    }

    function getTwentyTokenBack(uint256 _noOfNFTWant, uint256 _id) public {

        require(_noOfNFTWant>0,"Please enter some amount");
        require(nftToken.balanceOf(msg.sender,_id)>=_noOfNFTWant,"You don't have enough token balance");
        
        nftToken.safeTransferFrom(msg.sender,admin,_id,_noOfNFTWant,"0xhello");
        ERC20Token.transferFrom(admin,msg.sender,_noOfNFTWant*10e18);
    }
}

// 0x6C0d6b01eC84C8bE04387F63E7E0Fc316da38662 mytoken20
// 0xd9360406E707fB10F6DdCbDb42CD9544Aec4A158 mytokennft1155
// main 0x947154098BD8b6b9cC96CC349C89DCb8EC80c7da



