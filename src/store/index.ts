import {defineStore} from "pinia"
import {Ethereum} from "@/assets/eth/ethereum";

export const UseStore = defineStore("main", {
  state: () => ({
    ethereum: new Ethereum()
  }),
  getters: {},
  actions: {}
})

