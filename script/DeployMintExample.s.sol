// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {MintExample} from "../src/MintExample.sol";

contract DeployMintExample is Script {
    function run() public returns (MintExample token) {
        vm.startBroadcast();

        token = new MintExample();

        vm.stopBroadcast();
    }
}
