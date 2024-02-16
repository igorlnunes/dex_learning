// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Factory} from "../src/Factory_Unizuap.sol";
import {Token} from "../src/ERC20_Unizuap.sol";
import {Exchange} from "../src/Exchange_Unizuap.sol";

contract Factory_Unizuap is Test {
  Token public token;
  Token public token_new;
  Factory public factory;
  Exchange public exchange;
  address exchangeAddress;
  address newExchangeAddr;
  address exchangeAddressRevert;

  function setUp() public {
    token = new Token("Test", "TST", 31337);
    factory = new Factory();
    
    exchangeAddress = factory.createExchange(address(token));
  }

  function testCreateExchange() public { 
    assertEq(exchangeAddress, factory.getExchange(address(token)));
  }

  function testNameAndSymbolExchange() public {
    exchange = new Exchange(exchangeAddress);
    assertEq(exchange.name(), "Swap-v1");
    assertEq(exchange.symbol(), "SW-V1");
  }

  function testAddrZero() public {
    vm.expectRevert("invalid token address");
    exchange = new Exchange(address(0));
  }

  function testExistingExchangeAddr() public {
    vm.expectRevert("exchange already exists");
    exchangeAddressRevert = factory.createExchange(address(token));
  }

  function testGetExchange() public {
    token_new = new Token("NewToken", "NTN", 31337);

    newExchangeAddr = factory.createExchange(address(token_new));

    assertEq(exchangeAddress, factory.getExchange(address(token)));
    assertEq(newExchangeAddr, factory.getExchange(address(token_new)));
  }
}