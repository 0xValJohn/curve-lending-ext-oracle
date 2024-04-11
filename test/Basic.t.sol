// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {StYethCurveLendOracle} from "../src/StYethCurveLendOracle.sol";

contract BasicTest is Test {
    StYethCurveLendOracle public oracle;

    function setUp() public {
        oracle = new StYethCurveLendOracle();
    }

    function test_output() public {
        console2.log("price_w() = ", oracle.price_w()/1e18);
    }

}
