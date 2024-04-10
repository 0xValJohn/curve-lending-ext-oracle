# MVP for Curve Lending External Oracle Provider
This is an investigation on external oracle providers to establish a Curve Lending market.

In this example, we attempt to create an st-yETH/crvUSD price feed based on:
* st-yETH 4626 rate (totalAssets/totalSupply)
* yETH/ETH StableSwap Curve pool (price_oracle)
* Chainlink ETH/USD and crvUSD/USD feeds

# Open Questions
* Can we do without the rate limit (price_w)?
* Is the Chainlink heartbeat / deviation threshold creating issues with the LLAMMA soft liquidation?
* Is price_oracle safe and secure? How easily can it be manipulated?