// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Exchange} from "../src/Exchange_Unizuap.sol";
import {Token} from "../src/ERC20_Unizuap.sol";

contract Exchange_Unizuap is Test {
    Exchange public exchange;
    Exchange public exchangeClone;
    Token public token;

    uint256 getBalance;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");

    function setUp() public {
        token = new Token("Test", "TST", 1 ether);
        exchange = new Exchange(address(token));
    }

    function testDeployExchange() public {
        assertEq(exchange.name(), "Swap-v1");
        assertEq(exchange.symbol(), "SW-V1");
        assertEq(exchange.totalSupply(), 0);
    }

    function testAddLiquidity() public {
        //Arrange
        token.approve(address(exchange), 200 wei);
        //Act
        exchange.addLiquidity{value: 100 wei}(200 wei);
        //Assert
        assertEq(exchange.getReserve(), 200 wei);
        assertEq(exchange.getBalance(), 100 wei);
    }

    function testMintsLPTokens() public {
        //Arrange
        token.approve(address(exchange), 200 wei);
        //Act
        exchange.addLiquidity{value: 100 wei}(200 wei);
        //Assert
        assertEq(exchange.balanceOf(address(this)), 100 wei);
        assertEq(exchange.totalSupply(), 100 wei);
    }

    function testAllowsZeroAmounts() public {
        //Arrange
        token.approve(address(exchange), 0 wei);
        //Act
        exchange.addLiquidity{value: 0 wei}(0 wei);
        //Assert
        assertEq(exchange.balanceOf(address(this)), 0 wei);
        assertEq(exchange.totalSupply(), 0 wei);
    }

    function testAddLiquidityAndGetAmounts() public {
        //Arrange
        token.approve(address(exchange), 600 wei);
        //Act
        exchange.addLiquidity{value: 50 wei}(200 wei);
        exchange.addLiquidity{value: 100 wei}(400 wei);
        //Assert
        assertEq(exchange.getBalance(), 150 wei);
        assertEq(exchange.getReserve(), 600 wei);
    }

    function testPreservesExchangeRates() public {
        //Arrange
        token.approve(address(exchange), 300 wei);
        //Act
        exchange.addLiquidity{value: 100 wei}(200 wei);
        vm.expectRevert("insufficient token amount");
        exchange.addLiquidity{value: 500 wei}(200 wei);
        //Assert
        assertEq(exchange.getBalance(), 100 wei);
        assertEq(exchange.getReserve(), 200 wei);
    }

}
