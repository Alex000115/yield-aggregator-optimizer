# Yield Aggregator Optimizer

A professional-grade DeFi vault designed to maximize returns on stablecoins or native assets. This repository implements the "Strategy" pattern, where the main vault contract holds user funds and a separate strategy contract interacts with protocols like Aave, Compound, and MakerDAO to find the best yield.

## Core Features
* **Auto-Compounding:** Automatically reinvests earned rewards back into the principal.
* **Protocol Switching:** Logic to move funds between lending markets based on real-time APR.
* **Share-Based Accounting:** Users receive "Vault Tokens" representing their share of the pool's growth.
* **Flat Architecture:** Single-directory layout for the Vault, Strategy, and Controller logic.

## Workflow
1. **Deposit:** User sends USDC to the Vault and receives `yUSDC`.
2. **Deploy:** The Vault sends funds to the active Strategy.
3. **Harvest:** A keeper bot calls `harvest()` to collect rewards and rebalance.
4. **Withdraw:** User burns `yUSDC` to receive their principal plus accumulated yield.

## Setup
1. `npm install`
2. Deploy `Vault.sol` and a compatible `AaveStrategy.sol`.
