/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type { UserContract, UserContractInterface } from "../UserContract";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "old_admin",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "new_admin",
        type: "address",
      },
    ],
    name: "AdminTransferred",
    type: "event",
  },
  {
    inputs: [],
    name: "admin",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "renounceAdmin",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "new_admin",
        type: "address",
      },
    ],
    name: "transferAdmin",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "nickname",
        type: "string",
      },
    ],
    name: "register",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "user_address",
        type: "address",
      },
    ],
    name: "isRegistered",
    outputs: [
      {
        internalType: "bool",
        name: "is_registered",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getSelfInfo",
    outputs: [
      {
        components: [
          {
            internalType: "uint256",
            name: "ID",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "coins",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "heart",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "experience",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "follower_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "following_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "login_timestamp",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "uploaded_file_num",
            type: "uint256",
          },
          {
            internalType: "string",
            name: "major",
            type: "string",
          },
          {
            internalType: "string",
            name: "avatar",
            type: "string",
          },
          {
            internalType: "string",
            name: "nickname",
            type: "string",
          },
          {
            internalType: "string",
            name: "signature",
            type: "string",
          },
        ],
        internalType: "struct StoreContact.UserSelfInfo",
        name: "self_info",
        type: "tuple",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "avatar",
        type: "string",
      },
    ],
    name: "updateAvatar",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "nickname",
        type: "string",
      },
    ],
    name: "updateNickname",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "signature",
        type: "string",
      },
    ],
    name: "updateSignature",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

export class UserContract__factory {
  static readonly abi = _abi;
  static createInterface(): UserContractInterface {
    return new utils.Interface(_abi) as UserContractInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): UserContract {
    return new Contract(address, _abi, signerOrProvider) as UserContract;
  }
}
