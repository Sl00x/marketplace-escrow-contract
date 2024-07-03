# Smart Contract Deployment Setup with Solidity and Ganache

To set up and deploy your smart contracts locally using Ganache and Hardhat, follow these steps:

1. **Install Dependencies:**
  Ensure you have all the necessary packages installed by running:
  
  `npm install`
  
  or
  
  `yarn`


2. **Launch Ganache:**
  Start Ganache using the command:
  
  `ganache`
  
  
  Ganache will run on the default port `8545`. Make sure Ganache is up and running before proceeding.

3. **Update Hardhat Configuration:**
Modify the `hardhat.config.js` file in your project root to include Ganache network configuration:
```javascript
import { HardhatUserConfig } from "hardhat/config";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    ganache: {
      url: 'http://127.0.0.1:8545',
      accounts: ['PRIVATE_KEY_HERE'] // Replace with your Ganache private key
    }
  }
};

export default config;
```


Deploy with Script (Including Tests):
Run the deployment script deploy.sh which also runs your contract tests before deployment:

`npm run deploye:ganache`

or

`npm run deploye:hardhat`

Note: The deployment script ensures that your contract passes all tests before attempting to deploy. If tests fail, deployment will not proceed.

Deploy Without Tests:
Directly deploy your smart contract without running tests:

`npx hardhat run deploy.ts --network ganache`

or

`npx hardhat run deploy.ts --network hardhat`

Replace [ganache | hardhat | other if you add custom network] with the appropriate network you want to deploy to.

Additional Notes:
Ensure Ganache is running and accessible via http://127.0.0.1:8545.
Replace 'PRIVATE_KEY_HERE' in hardhat.config.js with your actual Ganache private key.
Use appropriate commands (bash or npx hardhat) depending on whether you want to include tests during deployment.

This setup allows you to develop and deploy Ethereum smart contracts locally using Ganache and Hardhat efficiently.
