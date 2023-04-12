/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-var-requires */
const fs = require("fs")
const path = require("path")

module.exports = async (
  deployer: Truffle.Deployer,
  network: "development",
  accounts: string[]
) => {
  const TestContract = artifacts.require("User");
  await deployer.deploy(TestContract);
  const instance = await TestContract.deployed();
  fs.writeFileSync(path.join(__dirname, "output.json"), JSON.stringify({
    "address": instance.address
  }))
};
