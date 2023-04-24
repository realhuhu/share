import {defineStore} from "pinia"
import {ethers} from "ethers";
import {Web3Provider} from "@ethersproject/providers";
import {Snackbar, Dialog} from "@varlet/ui"
import "@varlet/ui/es/snackbar/style/index"
import "@varlet/ui/es/dialog/style/index"
import Identicon from "identicon.js"


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
  show_default_wallet_modal: boolean
  encrypted_private_key: Nullable<string>
}
export const UseStore = defineStore("main", {
  state: (): StoreType => ({
    correct_chain_id: "0x539",//seu测试链ID
    ethereum_type: "local",//区块链钱包连接类型
    ethereum_chain_id: null,//当前链ID
    provider: null,//Web3Provider
    ethereum_connected: false,//是否已连接钱包
    UserContract: null,//用户合约
    contracts_connected: false,//是否已连接全部合约
    user: null,//用户信息

    show_register_modal: false,//展示授权框
    show_default_wallet_modal: false,//展示自带钱包登录框

    encrypted_private_key: null
  }),
  getters: {},
  actions: {
    async useDefaultWallet() {
      this.show_default_wallet_modal = true
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
          const inter = setInterval(async () => {
            this.ethereum_chain_id = window.ethereum.chainId
            if (this.ethereum_chain_id) {
              //调取MetaMask登录，初始化provider
              const address_list = await this.connectMetaMask()
              //若正常登录MetaMask，尝试连接合约并初始化User
              if (address_list) await this.afterMetaMaskLogin(address_list[0])
              clearInterval(inter)
            }
          }, 50)

          window.ethereum.on("chainChanged", async (chain_id: string) => {
            //切换链时，修改provider
            this.provider = new ethers.providers.Web3Provider(window.ethereum)
            this.ethereum_chain_id = chain_id
            if (chain_id === this.correct_chain_id) {
              //切换到seu测试链时，连接合约并初始化User
              await this.afterMetaMaskLogin(window.ethereum.selectedAddress)
            } else {
              //切换到其它链时，清空合约相关数据
              this.UserContract = null
              this.contracts_connected = false
              this.user = null
            }
          })

          window.ethereum.on("accountsChanged", async (address_list: Address[]) => {
            if (this.ethereum_connected && !this.isCorrectChain()) {
              this.UserContract = null
              this.contracts_connected = false
              this.user = null
            } else {
              await this.afterMetaMaskLogin(address_list[0])
            }
          })
          break
        case "other":
          const action = await Dialog({title: "不支持当前钱包，是否使用自带钱包？"})
          if (action === "confirm") await this.useDefaultWallet()
          break
      }
    },
    async connectMetaMask(): Promise<Nullable<Address[]>> {
      try {
        this.provider = new ethers.providers.Web3Provider(window.ethereum)
        return await toRaw(this.provider).send("eth_requestAccounts", [])
      } catch (e) {
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
        return null
      }
    },
    async afterMetaMaskLogin(address: Address) {
      //标记已连接MetaMask
      this.ethereum_connected = true

      //如果链ID正确，连接合约并初始化User
      if (this.ethereum_chain_id === this.correct_chain_id) {
        this.connectContracts(toRaw(<Web3Provider>this.provider))
        await this.refreshUser(address)
        this.contracts_connected = true
      }
    },
    connectContracts(provider: Web3Provider) {
      this.UserContract = UserContract__factory.connect(OutputAddress.user, provider.getSigner())
    },
    async refreshUser(address: Address) {
      const UserContract = assertNotEmpty(this.UserContract, "用户合约未初始化")
      const is_registered = await UserContract.isRegistered(address)
      if (is_registered) {
        const raw_data = await UserContract.getSelfInfo()

        this.user = {
          is_registered: true,
          avatar_b64: "data:image/png;base64," + new Identicon(ethers.utils.hashMessage(raw_data.avatar), {margin: 0.2}).toString(),
          address,
          raw_data
        }
      } else {
        this.user = {
          is_registered: false,
          avatar_b64: null,
          address,
          raw_data: null
        }
      }
    }
  }
  // persist: {
  //   enabled: true,
  //   strategies: [
  //     {
  //       storage: localStorage,
  //       paths: ["encryptedPrivateKey"]
  //     }
  //   ]
  // }
})

