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
        // TODO: MintExample.________________.selector 로 교체하세요.
        bytes4 expectedSelector = bytes4(0);

        vm.expectRevert(expectedSelector);

        // TODO: revert가 발생하는 mint amount로 교체하세요.
        token.mint(1);
    }

    function test_RevertWhen_MintAmountIsZero_WithFullRevertData() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                // TODO: MintExample.________________.selector 로 교체하세요.
                bytes4(0)
            )
        );

        // TODO: revert가 발생하는 mint amount로 교체하세요.
        token.mint(1);
    }

    function test_RevertWhen_MintAmountExceedsLimit_WithErrorArgument() public {
        // TODO: token.MAX_MINT_PER_TX() + 1 로 교체하세요.
        uint256 invalidAmount = 0;

        vm.expectRevert(
            abi.encodeWithSelector(
                // TODO: MintExample.________________.selector 로 교체하세요.
                bytes4(0),
                invalidAmount
            )
        );

        token.mint(invalidAmount);
    }

    function test_MintIncreasesBalance() public {
        // TODO: 성공하는 mint amount로 교체하세요.
        token.mint(0);

        // TODO: 기대 balance로 교체하세요.
        assertEq(token.balanceOf(address(this)), 0);
    }

    function test_StringRevertVersion() public {
        // TODO: 실제 revert string으로 교체하세요.
        vm.expectRevert(bytes(""));

        // TODO: revert가 발생하는 mint amount로 교체하세요.
        stringRevertToken.mint(1);
    }
}
