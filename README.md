# Curve Lending External Oracle Provider
This is an investigation on external oracle providers to establish a Curve Lending market.

In this example, we create a st-yETH/crvUSD price feed based on:
* st-yETH 4626 rate (totalAssets/totalSupply)
* yETH/ETH StableSwap Curve pool 
* ETH/USDC TricryptoUSDC Curve pool
* USDC/crvUSD StableSwap Curve pool 

The feed also uses `RATE_MAX_SPEED`, similar to Curve Lending native oracle.
