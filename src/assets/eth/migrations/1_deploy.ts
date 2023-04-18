/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-var-requires */
/* eslint-disable @typescript-eslint/ban-ts-comment */
const fs = require("fs")
const path = require("path")

module.exports = async (
  deployer: Truffle.Deployer,
  network: "development",
  accounts: string[]
) => {
  // @ts-ignore
  const Lib = artifacts.require("AddressLinkedList");


  const User = artifacts.require("UserContract");
  await deployer.deploy(Lib);
  deployer.link(Lib, User)
  await deployer.deploy(User);
  const instance = await User.deployed();
  fs.writeFileSync(path.join(__dirname, "output.json"), JSON.stringify({
    "user": instance.address
  }))
};
