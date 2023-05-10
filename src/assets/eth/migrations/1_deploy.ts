/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-var-requires */
/* eslint-disable @typescript-eslint/ban-ts-comment */
const fs = require("fs")
const path = require("path")

module.exports = async (
  deployer: Truffle.Deployer,
  network: "development" | "update"
  // accounts: string[]
) => {
  // @ts-ignore
  const AddressLinkedList = artifacts.require("AddressLinkedList");
  // @ts-ignore
  const AddressOrderedMap = artifacts.require("AddressOrderedMap");
  const Implementation = artifacts.require("ImplementationContact");
  const OurShare = await artifacts.require("OurShare")

  await deployer.deploy(AddressLinkedList);
  deployer.link(AddressLinkedList, Implementation)
  deployer.link(AddressLinkedList, AddressOrderedMap)

  await deployer.deploy(AddressOrderedMap);
  deployer.link(AddressOrderedMap, Implementation)

  await deployer.deploy(Implementation);

  const implementation = await Implementation.deployed();

  if (network === "development") {
    await deployer.deploy(OurShare);
    const our_share = await OurShare.deployed();
    await our_share.setImplementation(implementation.address)

    await (await artifacts.require("ImplementationInterface").at(our_share.address)).init()

    fs.writeFileSync(path.join(__dirname, "output.json"), JSON.stringify({
      "address": our_share.address
    }))
  } else {
    const json = JSON.parse(fs.readFileSync(path.join(__dirname, "output.json")).toString())
    const our_share = await OurShare.at(json.address)
    await our_share.setImplementation(implementation.address)
  }
};
