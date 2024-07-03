#!/bin/bash
set -e

echo "Running tests..."

npx hardhat test

echo "Tests passed. Deploying the contract..."

npx hardhat run deploy.ts --network "$1"
