// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";
import "../src/ERC721.sol";

contract CounterTest is Test {
  Counter counter;
  ERC721 erc721;

  address bob = address(0x1);
  address alice = address(0x2);

  function testMintToken() public {
   erc721 = new ERC721();
   erc721.mint(bob, 0);
   address owner_of = erc721.ownerOf(0);
   assertEq(bob, owner_of);
  }

  function setUp() public {
    counter = new Counter(10);
  }

  function testGetCount() public view {
    int value = counter.getCount();
    assertEq(value,10);
  }
    
  function testIncrement() public {
    counter.incrementCounter();
    int value = counter.getCount();
    assertEq(value,11);
  }

  function testDecrement() public {
    counter.decrementCounter();
    int value = counter.getCount();
    emit log_named_int("This value is: ", value);
    assertEq(value,9);
  }
}
