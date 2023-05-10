/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type { FileInterface, FileInterfaceInterface } from "../FileInterface";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "ipfs_address",
        type: "address",
      },
      {
        internalType: "string",
        name: "title",
        type: "string",
      },
      {
        internalType: "string",
        name: "description",
        type: "string",
      },
      {
        internalType: "bytes[][3]",
        name: "images",
        type: "bytes[][3]",
      },
      {
        internalType: "uint256",
        name: "price",
        type: "uint256",
      },
    ],
    name: "uploadFile",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

export class FileInterface__factory {
  static readonly abi = _abi;
  static createInterface(): FileInterfaceInterface {
    return new utils.Interface(_abi) as FileInterfaceInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): FileInterface {
    return new Contract(address, _abi, signerOrProvider) as FileInterface;
  }
}
