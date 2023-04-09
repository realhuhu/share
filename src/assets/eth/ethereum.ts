import {ethers} from "ethers";
import {ExternalProvider, Web3Provider} from "@ethersproject/providers";
import {Networkish} from "@ethersproject/networks";
import {flat} from "@/assets/lib/utils";

export class Ethereum {
  type: "local" | "metamask" | "other" = "local"
  provider: Nullable<Web3Provider> = null
  address: Nullable<Address> = null
  constructor() {
    if (window.ethereum === undefined) return

    const ethereum: ExternalProvider = window.ethereum

    if (ethereum.isMetaMask) {
      this.type = "metamask"
    } else {
      this.type = "other"
    }
  }

  connectMetaMask = (ethereum: ExternalProvider, network?: Networkish) => {
    this.provider = new ethers.providers.Web3Provider(ethereum, network)
    return flat<Address[], MetaMaskError>(this.provider.send("eth_requestAccounts", []))
  }
}
