// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "./Token.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
/** 
 * @title Reward
 * @dev Implements reward claim
 */
contract Reward {

    uint public lastWithdrawn;
    uint public withdrawableAmount;
    address public TokenAddress;

    constructor(address _tokenAddress) {
        TokenAddress=_tokenAddress;
        lastWithdrawn = block.timestamp;
        withdrawableAmount = 0;
    }

    /** 
     * @dev Giver 'owner' right to claim rewards. May only be called by 'owner'.
     * @param amount  -> reward claim amount
     */

    function claimReward(uint amount) public{
        uint daysPassedFromLastCLaim = (block.timestamp - lastWithdrawn)/60/60/24;
        if(daysPassedFromLastCLaim > 0){
            withdrawableAmount = withdrawableAmount + daysPassedFromLastCLaim * 15000;
        }
        require( withdrawableAmount > 0, "No rewards to claim" );
        require(withdrawableAmount <= amount, "Reward Balance low");
        ERC20(TokenAddress).approve(msg.sender,amount);
        ERC20(TokenAddress).transferFrom(address(this),msg.sender,amount);
        // tokenContract.mint(msg.sender,100);
        withdrawableAmount=withdrawableAmount-amount;
        lastWithdrawn=block.timestamp;
    }
}