// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

interface IStYETH {
    function totalAssets() external view returns (uint256);
    function totalSupply() external view returns (uint256);
}

interface IStableSwap {
    function price_oracle() external view returns (uint256);
}

interface ICurveTricrypto {
    function price_oracle(uint256) external view returns (uint256);
}

contract StYethCurveLendOracle {
    IStYETH public constant ST_YETH = IStYETH(0x583019fF0f430721aDa9cfb4fac8F06cA104d0B4);
    IStableSwap public constant YETH_ETH = IStableSwap(0x69ACcb968B19a53790f43e57558F5E443A91aF22);
    ICurveTricrypto public constant TRI_CRV = ICurveTricrypto(0x4eBdF703948ddCEA3B11f675B4D1Fba9d2414A14);

    uint256 public constant RATE_MAX_SPEED = 166666666666666; // Max speed of rate change

    uint256 public cachedTimestamp;
    uint256 public cachedRate;

    function price() public view returns (uint256) {
        uint256 rate = rawPrice();
        uint256 cachedRateValue = cachedRate;

        if (cachedRateValue == 0) {
            return rate;
        }

        if (rate > cachedRateValue) {
            return min(rate, cachedRateValue * (1e18 + RATE_MAX_SPEED * (block.timestamp - cachedTimestamp)) / 1e18);
        } else {
            return max(rate, cachedRateValue * (1e18 - RATE_MAX_SPEED * (block.timestamp - cachedTimestamp)) / 1e18);
        }
    }

    function price_w() external returns (uint256) {
        uint256 rate = rawPrice();
        cachedRate = rate;
        cachedTimestamp = block.timestamp;
        return rate;
    }

    function rawPrice() internal view returns (uint256) {
        return
            (ST_YETH.totalAssets() * 1e18) / ST_YETH.totalSupply() * YETH_ETH.price_oracle() * TRI_CRV.price_oracle(0) / 1e36;
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }
}
