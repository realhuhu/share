import {defineStore} from "pinia"
import {Web3Provider} from "@ethersproject/providers";
import {UserContract, UserContract__factory} from "@/assets/types/ethers";
import OutputAddress from "@/assets/eth/migrations/output.json";


type StoreType = {
  ethereum_type: "local" | "metamask" | "other",
  address: Nullable<Address>
  UserContract: Nullable<UserContract>
  initialized: boolean

  showRegisterModal: boolean
}
export const UseStore = defineStore("main", {
  state: (): StoreType => ({
    ethereum_type: "local",
    address: null,
    UserContract: null,
    initialized: false,
    showRegisterModal: false
  }),
  getters: {},
  actions: {
    init() {
      if (window.ethereum === undefined) return
      if (window.ethereum.isMetaMask) {
        this.ethereum_type = "metamask"
      } else {
        this.ethereum_type = "other"
      }
    },
    connectContract(provider: Web3Provider) {
      this.UserContract = UserContract__factory.connect(OutputAddress.user, provider.getSigner())
      this.initialized = true
    }
  }
})

