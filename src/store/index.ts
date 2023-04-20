import {defineStore} from "pinia"
import {ethers} from "ethers";
import {Web3Provider} from "@ethersproject/providers";
import {Snackbar, Dialog} from "@varlet/ui"
import "@varlet/ui/es/snackbar/style/index"
import "@varlet/ui/es/dialog/style/index"

import {UserContract, UserContract__factory} from "@/assets/types/ethers";
import OutputAddress from "@/assets/eth/migrations/output.json";
import {assertNotEmpty} from "@/assets/lib/utils";
import {toRaw} from "vue";


type StoreType = ({
  ethereum_connected: false
  provider: null
  contracts_connected: false
  UserContract: null
  user: null
} | ({
  contracts_connected: false
  UserContract: null
  user: null
} | {
  contracts_connected: true
  UserContract: UserContract,
  user: User
}) & ({
  ethereum_connected: true
  provider: Web3Provider
})) & {
  correct_chain_id: string
  ethereum_type: "local" | "metamask" | "other"
  ethereum_chain_id: Nullable<string>
  show_register_modal: boolean
}
export const UseStore = defineStore("main", {
  state: (): StoreType => ({
    correct_chain_id: "0x539",
    ethereum_type: "local",//区块链钱包连接类型
    ethereum_chain_id: null,
    ethereum_connected: false,//是否已连接区块链
    provider: null,//Web3Provider
    UserContract: null,//用户合约
    contracts_connected: false,//是否已连接全部合约
    user: null,//用户信息
    show_register_modal: false//展示授权框
  }),
  getters: {},
  actions: {
    async useDefaultWallet() {
      console.log(1);
    },
    isCorrectChain() {
      return this.correct_chain_id === this.ethereum_chain_id
    },
    async connectEthereum() {
      if (window.ethereum === undefined) {
        this.ethereum_type = "local"
      } else if (window.ethereum.isMetaMask) {
        this.ethereum_type = "metamask"
      } else {
        this.ethereum_type = "other"
      }
      switch (this.ethereum_type) {
        case "local":
          await this.useDefaultWallet()
          break
        case "metamask":
          this.ethereum_chain_id = window.ethereum.chainId

          window.ethereum.on("chainChanged", (chain_id: string) => {
            this.ethereum_chain_id = chain_id

            if (chain_id === this.correct_chain_id) {
              this.connectMetaMask().then()
            } else {
              this.ethereum_connected = false
              this.provider = null
              this.UserContract = null
              this.contracts_connected = false
              this.user = null
            }
          })

          window.ethereum.on("accountsChanged", (address_list: Address[]) => {
            if (this.isCorrectChain()) {
              if (!this.ethereum_connected) {
                this.connectMetaMask().then(() => {
                  return this.refreshUser(address_list[0])
                })
              } else if (!this.contracts_connected) {
                this.connectContracts(toRaw(this.provider))
                this.refreshUser(address_list[0]).then()
              }
            }
          })

          await this.connectMetaMask()
          break
        case "other":
          const action = await Dialog({title: "不支持当前钱包，是否使用自带钱包？"})
          if (action === "confirm") await this.useDefaultWallet()
          break
      }
    },
    async connectMetaMask() {
      try {
        this.provider = new ethers.providers.Web3Provider(window.ethereum)
        const provider = toRaw(this.provider)
        const address_list: Address[] = await provider.send("eth_requestAccounts", [])
        this.ethereum_connected = true
        this.connectContracts(provider)
        await this.refreshUser(address_list[0])
        this.contracts_connected = true
      } catch (e) {
        this.provider = null
        // eslint-disable-next-line no-extra-parens
        const code = (<MetaMaskError>e).code
        switch (code) {
          case -32002:
            Snackbar({content: "请打开MetaMask登录", type: "warning", duration: 1000})
            break
          case 4001:
            Snackbar({content: "已取消连接MetaMask", type: "warning", duration: 1000})
            break
          case "CALL_EXCEPTION":
            Snackbar({content: "请切换到seu测试链" + code, type: "error", duration: 3000})
            console.log(e);
            break
          default:
            Snackbar({content: "未知的MetaMask错误:" + code, type: "error", duration: 1000})
            break
        }
        throw e
      }
    },
    connectContracts(provider: Web3Provider) {
      this.UserContract = UserContract__factory.connect(OutputAddress.user, provider.getSigner())
    },
    async refreshUser(address: Address) {
      const UserContract = assertNotEmpty(this.UserContract, "用户合约未初始化")
      const is_registered = await UserContract.isRegistered(address)
      if (is_registered) {
        this.user = {
          is_registered: true,
          address,
          raw_data: await UserContract.getSelfInfo()
        }
      } else {
        this.user = {
          is_registered: false,
          address,
          raw_data: null
        }
      }
    }
  }
})

