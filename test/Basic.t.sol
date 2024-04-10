// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {StakedYethCurveLendOracle} from "../src/StakedYethCurveLendOracle.sol";

contract BasicTest is Test {
    StakedYethCurveLendOracle public oracle;

    function setUp() public {
        oracle = new StakedYethCurveLendOracle();
    }

    function test_output() public {
        console2.log("price() = ", oracle.price()/1e18);
        console2.log("price_w() = ", oracle.price_w()/1e18);
    }

}
