// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/ERC20_Unizuap.sol";

contract Token_Unizuap is Test {
  Token public token;

  function setUp() public {
    token = new Token("Test", "TST", 31337);
  }

  function testNameAndSymbol() public {
    assertEq(token.name(), "Test");
    assertEq(token.symbol(),"TST");
  }

  function testMintTokensAsCreated() public {
    assertEq(token.totalSupply(), 31337);
    assertEq(token.balanceOf(address(this)), 31337);
  }
}