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
  const via = {
    USER: 0,
    FILE: 1,
    REWARD: 2,
    MESSAGE: 3
  }

  // @ts-ignore
  const AddressLinkedList = artifacts.require("AddressLinkedList")
  // @ts-ignore
  const AddressOrderedMap = artifacts.require("AddressOrderedMap")
  // @ts-ignore
  const UintLib = artifacts.require("UintLib")
  // @ts-ignore
  const StringLib = artifacts.require("StringLib")
  // @ts-ignore
  const Bytes32Lib = artifacts.require("Bytes32Lib")
  // @ts-ignore
  const UserUtils = artifacts.require("UserUtils")
  // @ts-ignore
  const UserLib = artifacts.require("UserLib")
  // @ts-ignore
  const FileUtils = artifacts.require("FileUtils")
  // @ts-ignore
  const FileLib = artifacts.require("FileLib")
  // @ts-ignore
  const CategoryLib = artifacts.require("CategoryLib")
  // @ts-ignore
  const RewardUtils = artifacts.require("RewardUtils")
  // @ts-ignore
  const RewardLib = artifacts.require("RewardLib")
  // @ts-ignore
  const MessageLib = artifacts.require("MessageLib")
  // @ts-ignore
  const CommonLib = artifacts.require("CommonLib")

  const UserContract = await artifacts.require("UserContract")
  const FileContact = await artifacts.require("FileContact")
  const RewardContact = await artifacts.require("RewardContact")
  const MessageContact = await artifacts.require("MessageContact")
  const OurShare = await artifacts.require("OurShare")

  await deployer.deploy(UintLib)
  await deployer.deploy(StringLib)
  await deployer.deploy(Bytes32Lib)
  await deployer.deploy(CommonLib)
  await deployer.deploy(AddressLinkedList)
  deployer.link(AddressLinkedList, AddressOrderedMap)
  await deployer.deploy(AddressOrderedMap)

  deployer.link(AddressLinkedList, UserUtils)
  deployer.link(AddressOrderedMap, UserUtils)
  await deployer.deploy(UserUtils)

  deployer.link(AddressLinkedList, UserLib)
  deployer.link(AddressOrderedMap, UserLib)
  deployer.link(UserUtils, UserLib)
  await deployer.deploy(UserLib)

  deployer.link(AddressLinkedList, FileUtils)
  deployer.link(AddressOrderedMap, FileUtils)
  deployer.link(UserLib, FileUtils)
  await deployer.deploy(FileUtils)

  deployer.link(AddressLinkedList, FileLib)
  deployer.link(AddressOrderedMap, FileLib)
  deployer.link(Bytes32Lib, FileLib)
  deployer.link(UserLib, FileLib)
  deployer.link(CommonLib, FileLib)
  deployer.link(FileUtils, FileLib)
  await deployer.deploy(FileLib)

  deployer.link(AddressLinkedList, CategoryLib)
  deployer.link(AddressOrderedMap, CategoryLib)
  deployer.link(Bytes32Lib, CategoryLib)
  await deployer.deploy(CategoryLib)

  deployer.link(AddressLinkedList, RewardUtils)
  deployer.link(AddressOrderedMap, RewardUtils)
  deployer.link(UserLib, RewardUtils)
  deployer.link(FileLib, RewardUtils)
  await deployer.deploy(RewardUtils)

  deployer.link(AddressLinkedList, RewardLib)
  deployer.link(AddressOrderedMap, RewardLib)
  deployer.link(Bytes32Lib, RewardLib)
  deployer.link(UserLib, RewardLib)
  deployer.link(FileLib, RewardLib)
  deployer.link(CommonLib, RewardLib)
  deployer.link(RewardUtils, RewardLib)
  await deployer.deploy(RewardLib)

  deployer.link(AddressLinkedList, MessageLib)
  deployer.link(AddressOrderedMap, MessageLib)
  deployer.link(Bytes32Lib, MessageLib)
  deployer.link(UserLib, MessageLib)
  deployer.link(FileLib, MessageLib)
  deployer.link(RewardLib, MessageLib)
  await deployer.deploy(MessageLib)

  deployer.link(UserLib, UserContract)
  await deployer.deploy(UserContract)
  const UserImplementation = await UserContract.deployed()

  deployer.link(Bytes32Lib, FileContact)
  deployer.link(UserLib, FileContact)
  deployer.link(FileLib, FileContact)
  deployer.link(CategoryLib, FileContact)
  deployer.link(MessageLib, FileContact)
  await deployer.deploy(FileContact)
  const FileImplementation = await FileContact.deployed()

  deployer.link(UserLib, RewardContact)
  deployer.link(RewardLib, RewardContact)
  deployer.link(MessageLib, RewardContact)
  await deployer.deploy(RewardContact)
  const RewardImplementation = await RewardContact.deployed()

  deployer.link(MessageLib, MessageContact)
  await deployer.deploy(MessageContact)
  const MessageImplementation = await MessageContact.deployed()


  if (network === "development") {
    await deployer.deploy(OurShare)
    const OurShareContact = await OurShare.deployed()
    await OurShareContact.setImplementation(
      UserImplementation.address,
      FileImplementation.address,
      RewardImplementation.address,
      MessageImplementation.address
    )
    const ImplementationInterface = await artifacts.require("ImplementationInterface").at(OurShareContact.address)
    await ImplementationInterface.UserContract_init(via.USER)
    await ImplementationInterface.FileContract_init(via.FILE)
    await ImplementationInterface.RewardContact_init(via.REWARD)
    await ImplementationInterface.MessageContact_init(via.MESSAGE)
    await ImplementationInterface.addCategory(via.FILE, "电子书")
    await ImplementationInterface.addCategory(via.FILE, "24考研")
    await ImplementationInterface.addCategory(via.FILE, "mooc答案")
    await ImplementationInterface.addCategory(via.FILE, "其它")

    fs.writeFileSync(path.join(__dirname, "output.json"), JSON.stringify({
      "address": OurShareContact.address
    }))
  } else {
    const json = JSON.parse(fs.readFileSync(path.join(__dirname, "output.json")).toString())
    const OurShareContact = await OurShare.at(json.address)
    await OurShareContact.setImplementation(
      UserImplementation.address,
      FileImplementation.address,
      RewardImplementation.address,
      MessageImplementation.address
    )
  }
}
