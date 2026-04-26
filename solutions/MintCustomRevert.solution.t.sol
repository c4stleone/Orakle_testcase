// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {MintExample, MintStringRevert} from "../src/MintExample.sol";

contract MintCustomRevertTest is Test {
    MintExample internal token;
    MintStringRevert internal stringRevertToken;

    function setUp() public {
        token = new MintExample();
        stringRevertToken = new MintStringRevert();
    }

    function test_RevertWhen_MintAmountIsZero_WithCustomErrorSelector4Bytes() public {
        bytes4 expectedSelector = MintExample.MintAmountZero.selector;

        vm.expectRevert(expectedSelector);
        token.mint(0);
    }

    function test_RevertWhen_MintAmountIsZero_WithFullRevertData() public {
        vm.expectRevert(abi.encodeWithSelector(MintExample.MintAmountZero.selector));
        token.mint(0);
    }

    function test_RevertWhen_MintAmountExceedsLimit_WithErrorArgument() public {
        uint256 invalidAmount = token.MAX_MINT_PER_TX() + 1;

        vm.expectRevert(abi.encodeWithSelector(MintExample.InvalidMintAmount.selector, invalidAmount));
        token.mint(invalidAmount);
    }

    function test_MintIncreasesBalance() public {
        token.mint(1);

        assertEq(token.balanceOf(address(this)), 1);
    }

    function test_StringRevertVersion() public {
        vm.expectRevert(bytes("Mint amount is zero"));
        stringRevertToken.mint(0);
    }
}
