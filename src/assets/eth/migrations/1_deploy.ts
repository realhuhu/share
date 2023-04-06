/* eslint-disable @typescript-eslint/no-unused-vars */
module.exports = async (
  deployer: Truffle.Deployer,
  network: "development" | "production",
  accounts: string[]
) => {
  console.log(artifacts);
  const TestContract = artifacts.require("User");
  await deployer.deploy(TestContract);
  await TestContract.deployed();
};
