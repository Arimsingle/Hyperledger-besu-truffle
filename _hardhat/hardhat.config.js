require("@nomiclabs/hardhat-waffle");
require('@nomiclabs/hardhat-ethers')
require('hardhat-deploy')
const privateKey = [
  "0x8f2a55949038a9610f50fb23b5883af3b4ecb3c3bb792cbcefbd1542c692be63",
  "0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3",
  "0xae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f",
];

task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();
  for (const account of accounts) {
    console.log(account.address);
  }
});


module.exports = {
  solidity: {
    version: "0.7.1",
  },
  networks: {
    localhost: {
      url: "http://localhost:8545/"
    },
    hardhat: {
    },
    besu: {
      url: "http://localhost:8545/",
      // accounts: privateKey,
      // chainId: 1337,
    }
  },
};

