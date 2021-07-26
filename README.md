# Laminar Token - Upgradeable ERC20 Token Smart Contract

## Summary

Please implement an upgradeable ERC20 smart contract using Solidity and deploy them on testnet.
You may use http://faucet.[NAME].network to get some ETH.

#### Requirements:
- Have an owner account that can upgrade the smart contract
- Implements ERC20
- Anyone can send ETH to this smart contract to mint same amount of ERC20 tokens
- Have a kill switch that permanently kills upgrade functionality. Only owner can perform this action.
- Deploy this smart contract to testnet
- Make a transaction to send ETH to mint ERC20 token
- Upgrade the smart contract to add a feature that allow user to burn ERC20 token and get 90% of the ETH back
- Perform kill switch to kill upgrade functionality
- Make another transaction to burn ERC20 to receive ETH
- Submit all the relevant code, including pre-upgraded contract and all the executed transactions' hash, preferably etherscan links to the transactions
  * Transaction deploys smart contract
  * Transaction sends ETH to mint ERC20 token
  * Transaction performs upgrade
  * Transaction performs kill switch
  * Transaction that burn ERC20 token and receive ETH

## Configuration

### Install Hardhat

```npm install```

```npx hardhat node```

## Test!💥

### Run Tests

```npx hardhat test```
