export {}
import {ExternalProvider} from "ethers"
import {UserContract as UserContractType} from "@/assets/types/ethers";

declare global {
  type Nullable<T> = T | null
  type PageAnimation = "switch-left" | "switch-right" | "scale-pop" | "scale-push"
  type HomePagePath = "/home/resource" | "/home/reward" | "/home/favorite" | "/home/profile"
  type Address = `0x${string}`

  type MetaMaskError = {
    code: number | string,
    message: string,
    stack: string
  }

  type BaseUser = UserContractType.UserSelfInfoStructOutput & {
    avatar_b64?: string
  }
  type User = ({
    is_registered: true
    raw_data: BaseUser
  } | {
    is_registered: false
    raw_data: null
  }) & {
    address: Address
  }

  interface Window {
    ethereum: ExternalProvider | undefined
  }
}
