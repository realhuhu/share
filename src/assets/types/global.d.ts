export {}
import {ExternalProvider} from "ethers"

declare global {
  type Nullable<T> = T | null
  type PageAnimation = "switch-left" | "switch-right" | "scale-pop" | "scale-push"
  type HomePagePath = "/home/resource" | "/home/reward" | "/home/favorite" | "/home/profile"
  type Address = `0x${string}`
  type MetaMaskError = {
    code: number,
    message: string,
    stack: string
  }

  interface Window {
    ethereum: ExternalProvider | undefined
  }
}
