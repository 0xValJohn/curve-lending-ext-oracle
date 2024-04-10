// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

interface ISTYETH {
    function totalAssets() external view returns (uint256);
    function totalSupply() external view returns (uint256);
}

interface IYETHETH {
    function price_oracle() external view returns (uint256);
}

interface IPriceOracle {
    function latestAnswer() external view returns (int256);
}

contract StakedYethCurveLendOracle {
    ISTYETH public constant ST_YETH = ISTYETH(0x583019fF0f430721aDa9cfb4fac8F06cA104d0B4);
    IYETHETH public constant YETH_ETH = IYETHETH(0x69ACcb968B19a53790f43e57558F5E443A91aF22);
    IPriceOracle public constant CL_ETH_USD = IPriceOracle(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    IPriceOracle public constant CL_CRVUSD_USD = IPriceOracle(0xEEf0C605546958c1f899b6fB336C20671f9cD49F);

    function price() public view returns (uint256) {
        return (ST_YETH.totalAssets() * 1e18) / ST_YETH.totalSupply() * YETH_ETH.price_oracle()
            * uint256(CL_ETH_USD.latestAnswer()) / (uint256(CL_CRVUSD_USD.latestAnswer()) * 1e18);
    }

    function price_w() external returns (uint256) {
        return price();
    }
}