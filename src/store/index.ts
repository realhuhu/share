import {toRaw} from "vue";
import {defineStore} from "pinia"
import {ethers} from "ethers";
import {Web3Provider} from "@ethersproject/providers";
import {Snackbar, Dialog} from "@varlet/ui"
import "@varlet/ui/es/snackbar/style/index"
import "@varlet/ui/es/dialog/style/index"
import Identicon from "identicon.js"

import {ImplementationInterface, ImplementationInterface__factory} from "@/assets/types/ethers";
import OutputAddress from "@/assets/eth/migrations/output.json";
import {assertNotEmpty} from "@/assets/lib/utils";
import {head_address, ipfs_url, via, zero_address} from "@/assets/lib/settings";
import {create, IPFSHTTPClient} from "ipfs-http-client"

type StoreType = ({
  ethereum_connected: false
  provider: null
  contracts_connected: false
  contract: null
  user: null
  categories: null
} | ({
  contracts_connected: false
  contract: null
  user: null
  categories: null
} | {
  contracts_connected: true
  contract: ImplementationInterface,
  user: User
  categories: { category_address: string, name: string; num: number; }[]
}) & ({
  ethereum_connected: true
  provider: Web3Provider
})) & {
  correct_chain_id: string
  ethereum_type: "local" | "metamask" | "other"
  ipfs: IPFSHTTPClient,
  ethereum_chain_id: Nullable<string>
  show_register_modal: boolean
  show_default_wallet_modal: boolean
  encrypted_private_key: Nullable<string>
  is_mobile: boolean,
}
export const UseStore = defineStore("main", {
  state: (): StoreType => ({
    correct_chain_id: "0x539",//seu测试链ID
    ethereum_type: "local",//区块链钱包连接类型
    ethereum_chain_id: null,//当前链ID
    provider: null,//Web3Provider
    ethereum_connected: false,//是否已连接钱包
    contract: null,//用户合约
    contracts_connected: false,//是否已连接全部合约
    user: null,//用户信息
    categories: null,

    show_register_modal: false,//展示授权框
    show_default_wallet_modal: false,//展示自带钱包登录框

    encrypted_private_key: null,
    ipfs: create({url: ipfs_url}),
    is_mobile: window.innerWidth < 768
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
            if (window.ethereum.chainId) {
              //调取MetaMask登录，初始化provider
              const address_list = await this.connectMetaMask()
              if (address_list) {
                this.ethereum_chain_id = window.ethereum.chainId
                //若正常登录MetaMask，尝试连接合约并初始化User
                if (address_list) await this.afterMetaMaskLogin(address_list[0])
              }
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
              this.contract = null
              this.contracts_connected = false
              this.user = null
            }
          })

          window.ethereum.on("accountsChanged", async (address_list: string[]) => {
            if (this.ethereum_connected && !this.isCorrectChain()) {
              this.contract = null
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
    async connectMetaMask(): Promise<Nullable<string[]>> {
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
    async afterMetaMaskLogin(address: string) {
      //标记已连接MetaMask
      this.ethereum_connected = true

      //如果链ID正确，连接合约并初始化User
      if (this.ethereum_chain_id === this.correct_chain_id) {
        await this.connectContracts(toRaw(<Web3Provider>this.provider))
        await this.refreshUser(address)
        this.contracts_connected = true
      }
    },
    async getCategories() {
      const contract = assertNotEmpty(this.contract, "用户合约未初始化")
      const categories: { category_address: string, name: string; num: number; }[] = []
      let cursor = head_address
      while (cursor !== zero_address) {
        const {category_slice, next} = await contract.getCategorySlice(via.FILE, cursor)
        cursor = next
        for (const category of category_slice) {
          cursor = category.category_address
          if (cursor === zero_address) break;
          categories.push({
            category_address: category.category_address,
            name: category.name,
            num: category.num.toNumber()
          })
        }
      }

      this.categories = [
        {category_address: zero_address, name: "全部", num: categories.map(x => x.num).reduce((a, b) => a + b)},
        ...categories
      ]
    },
    async connectContracts(provider: Web3Provider) {
      this.contract = ImplementationInterface__factory.connect(OutputAddress.address, provider.getSigner())
      await this.getCategories()
    },
    async refreshUser(address: string) {
      const contract = assertNotEmpty(this.contract, "用户合约未初始化")
      const is_registered = await contract.isRegistered(via.USER, address)
      if (is_registered) {
        const raw_data = await contract.getSelfInfo(via.USER)

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
})

