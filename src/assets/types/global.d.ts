export {}
import {ExternalProvider} from "ethers"
import {Types} from "@/assets/types/ethers/ImplementationContact";


declare global {
  type Nullable<T> = T | null
  type PageAnimation = "switch-left" | "switch-right" | "scale-pop" | "scale-push"
  type HomePagePath = "/home/resource" | "/home/reward" | "/home/favorite" | "/home/profile"
  type Address = `0x${string}`
  type Images = [string, string, string]

  type MetaMaskError = {
    code: number | string,
    message: string,
    stack: string
  }


  type User = ({
    is_registered: true
    raw_data: Types.UserSelfInfoStructOutput
    avatar_b64: string
  } | {
    is_registered: false
    raw_data: null
    avatar_b64: null
  }) & {
    address: Address
  }

  interface Window {
    ethereum: ExternalProvider | undefined
  }
}
