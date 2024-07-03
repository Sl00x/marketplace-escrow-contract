import { ethers } from "hardhat"

const main = async () => {
    const contract =  await ethers.getContractFactory('Token');
    const initialSupply = ethers.parseUnits("1000", 18);
    const deployContract = await contract.deploy(initialSupply);
    const address = await deployContract.getAddress();
    
    console.table({contract: "Token", address})
}

main().then(() => {
    process.exit(0);
}).catch((error) => {
    console.error(error);
})