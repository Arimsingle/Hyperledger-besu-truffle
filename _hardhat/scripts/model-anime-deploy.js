const { ethers } = require("hardhat");

async function main() {

  // We get the contract to deploy
  const ModelAnime = await ethers.getContractFactory("ModelAnime");
  const modelAnime = await ModelAnime.deploy();

  await modelAnime.deployed();

  console.log("ModelAnime deployed to:", modelAnime.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
