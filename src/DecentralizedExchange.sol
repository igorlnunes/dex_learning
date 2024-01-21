// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DecentralizedExchange {
    //setting global variables
    address public admin;
    address public tokenA;
    address public tokenB;
    uint256 public feeRate;

    constructor(address _tokenA, address _tokenB, uint256 _feeRate) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        feeRate = _feeRate;
    }

    function addLiquidity(
        uint amountA,
        uint amountB
    ) private returns (uint liquidity) {
        // suppost that the pair exist
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);

        uint256 balanceA = IERC20(tokenA).balanceOf(address(this));
        uint256 balanceB = IERC20(tokenB).balanceOf(address(this));
    }
}
