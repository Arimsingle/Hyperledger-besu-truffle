const { expect } = require("chai");

describe("Contractor", function () {
    it("Check initails value", async function () {
        const ModelAnime = await ethers.getContractFactory("ModelAnime");
        const modelAnime = await ModelAnime.deploy();
        await modelAnime.deployed();
        const [owner] = await ethers.getSigners();

        const ownerBalance = await modelAnime.showBalance(owner.address);
        expect(+ownerBalance).to.equal(1000000000000000000);

        const ownerNonce = await modelAnime.showNonce(owner.address);
        expect(+ownerNonce).to.equal(0);

    });
});
