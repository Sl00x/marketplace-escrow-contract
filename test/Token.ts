import { expect } from "chai";
import { ethers } from "ethers";
import hre from "hardhat";



describe("Token", function() {
    it("Should deploy MyToken and set the correct initial supply", async () => {
        const token = await hre.ethers.getContractFactory("Token");
        const initialSupply = ethers.parseUnits("10000", 18); // 1 million tokens with 18 decimals
        const myToken = await token.deploy(initialSupply);
        const ownerBalance = await myToken.balanceOf(await hre.ethers.getSigner(await myToken.getOwnerAddress()));
        expect(ownerBalance).to.equal(initialSupply);
    });

    it("Should transfer tokens between accounts", async function() {
        const MyToken = await hre.ethers.getContractFactory("Token");
        const initialSupply = ethers.parseUnits("10000", 18);
        const myToken = await MyToken.deploy(initialSupply);

        

        await myToken.transfer("0xcCaD9900570Df581B8ECEecc450521Cdc10Adb17", ethers.parseUnits("10", 18));
        const recipientBalance = await myToken.balanceOf("0xcCaD9900570Df581B8ECEecc450521Cdc10Adb17");
        expect(recipientBalance).to.equal(hre.ethers.parseUnits("10", 18));
    });
});
