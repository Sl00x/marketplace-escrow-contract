import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    ganache: {
      url: 'http://127.0.0.1:8545',
      accounts: ['0x386082d89b3d0d85698965646bf28b1f2bed86bd5f62476f3478591be92081ba'] //private wallet key use to deploie
    }
  }
};

export default config;
