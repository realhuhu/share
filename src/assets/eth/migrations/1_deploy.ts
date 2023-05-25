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
  // @ts-ignore
  const UintLib = artifacts.require("UintLib");
  // @ts-ignore
  const StringLib = artifacts.require("StringLib");
  // @ts-ignore
  const Bytes32Lib = artifacts.require("Bytes32Lib");

  const Implementation = artifacts.require("ImplementationContact");
  const OurShare = await artifacts.require("OurShare")

  await deployer.deploy(AddressLinkedList);
  deployer.link(AddressLinkedList, Implementation)
  deployer.link(AddressLinkedList, AddressOrderedMap)

  await deployer.deploy(AddressOrderedMap);
  deployer.link(AddressOrderedMap, Implementation)

  await deployer.deploy(UintLib);
  deployer.link(UintLib, Implementation)

  await deployer.deploy(StringLib);
  deployer.link(StringLib, Implementation)

  await deployer.deploy(Bytes32Lib);
  deployer.link(Bytes32Lib, Implementation)

  await deployer.deploy(Implementation);

  const implementation = await Implementation.deployed();

  if (network === "development") {
    await deployer.deploy(OurShare);
    const our_share = await OurShare.deployed();
    await our_share.setImplementation(implementation.address)
    const ImplementationInterface = await artifacts.require("ImplementationInterface").at(our_share.address)
    await ImplementationInterface.init()
    await ImplementationInterface.addCategory("电子书")
    await ImplementationInterface.addCategory("24考研")
    await ImplementationInterface.addCategory("mooc答案")
    await ImplementationInterface.addCategory("其它")

    fs.writeFileSync(path.join(__dirname, "output.json"), JSON.stringify({
      "address": our_share.address
    }))
  } else {
    const json = JSON.parse(fs.readFileSync(path.join(__dirname, "output.json")).toString())
    const our_share = await OurShare.at(json.address)
    await our_share.setImplementation(implementation.address)
  }
};
