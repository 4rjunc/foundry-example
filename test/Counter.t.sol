// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/Counter.sol";
import "src/ERC721.sol";

contract CounterTest is Test {
  Counter counter;
  MyNFT nft;

  address bob = address(0x1);
  address alice = address(0x2);

  function testMintToken() public {
   nft = new MyNFT();
   nft.mint(bob, 0);
   address owner_of = nft.ownerOf(0);
   assertEq(bob, owner_of);
  }

  function testTransferToken() public {
    nft = new MyNFT();
    nft.mint(bob, 0);

    vm.startPrank(bob);
    nft.safeTransferFrom(bob, alice, 0);
    address owner_of = nft.ownerOf(0);
    assertEq(alice, owner_of);
  }

  function testGetBalance() public {
    nft = new MyNFT();

    nft.mint(bob, 0);
    nft.mint(bob, 1);
    nft.mint(bob, 2);
    nft.mint(bob, 3);
    nft.mint(bob, 4);

    uint balance = nft.balanceOf(bob);
    assertEq(balance, 5);
  }

  function testOnlyOwnerBurn() public {
    nft = new MyNFT();
    nft.mint(bob, 0);

    vm.startPrank(alice);
    vm.expectRevert("not owner");
    nft.burn(0);

    emit log_address(alice);
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
