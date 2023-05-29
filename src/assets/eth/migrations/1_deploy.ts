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
  // @ts-ignore
  const UserLib = artifacts.require("UserLib");
  // @ts-ignore
  const FileLib = artifacts.require("FileLib");
  // @ts-ignore
  const CategoryLib = artifacts.require("CategoryLib");
  // @ts-ignore
  const Common = artifacts.require("Common");

  const Implementation = artifacts.require("ImplementationContact");
  const OurShare = await artifacts.require("OurShare")


  await deployer.deploy(Common);

  await deployer.deploy(AddressLinkedList);

  deployer.link(AddressLinkedList, AddressOrderedMap)
  await deployer.deploy(AddressOrderedMap);

  await deployer.deploy(UintLib);
  await deployer.deploy(StringLib);
  await deployer.deploy(Bytes32Lib);

  deployer.link(AddressLinkedList, UserLib)
  deployer.link(AddressOrderedMap, UserLib)
  await deployer.deploy(UserLib);

  deployer.link(AddressLinkedList, FileLib)
  deployer.link(AddressOrderedMap, FileLib)
  deployer.link(Bytes32Lib, FileLib)
  deployer.link(UserLib, FileLib)
  deployer.link(Common, FileLib)
  await deployer.deploy(FileLib);

  deployer.link(AddressLinkedList, CategoryLib)
  deployer.link(AddressOrderedMap, CategoryLib)
  deployer.link(Bytes32Lib, CategoryLib)
  await deployer.deploy(CategoryLib);

  deployer.link(UintLib, Implementation)
  deployer.link(StringLib, Implementation)
  deployer.link(Bytes32Lib, Implementation)
  deployer.link(UserLib, Implementation)
  deployer.link(FileLib, Implementation)
  deployer.link(CategoryLib, Implementation)

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
