/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Signer, utils } from "ethers";
import type { Provider } from "@ethersproject/providers";
import type { FileContact, FileContactInterface } from "../FileContact";

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
        name: "name",
        type: "string",
      },
    ],
    name: "addCategory",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "cursor",
        type: "address",
      },
    ],
    name: "getCategorySlice",
    outputs: [
      {
        components: [
          {
            internalType: "address",
            name: "category_address",
            type: "address",
          },
          {
            internalType: "string",
            name: "name",
            type: "string",
          },
          {
            internalType: "uint256",
            name: "num",
            type: "uint256",
          },
        ],
        internalType: "struct StoreContact.Category[10]",
        name: "category_slice",
        type: "tuple[10]",
      },
      {
        internalType: "address",
        name: "next",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "ipfs_address",
        type: "string",
      },
      {
        internalType: "string",
        name: "name",
        type: "string",
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
        internalType: "address",
        name: "category",
        type: "address",
      },
      {
        internalType: "string[3]",
        name: "images",
        type: "string[3]",
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
  {
    inputs: [
      {
        internalType: "address",
        name: "cursor",
        type: "address",
      },
      {
        internalType: "bool",
        name: "reverse",
        type: "bool",
      },
    ],
    name: "getSelfFileBriefInfos",
    outputs: [
      {
        components: [
          {
            internalType: "address",
            name: "category",
            type: "address",
          },
          {
            internalType: "address",
            name: "file_address",
            type: "address",
          },
          {
            internalType: "bool",
            name: "is_buy",
            type: "bool",
          },
          {
            internalType: "string",
            name: "name",
            type: "string",
          },
          {
            internalType: "string",
            name: "title",
            type: "string",
          },
          {
            internalType: "string",
            name: "owner",
            type: "string",
          },
          {
            internalType: "string",
            name: "description",
            type: "string",
          },
          {
            internalType: "string",
            name: "cover",
            type: "string",
          },
          {
            internalType: "uint256",
            name: "price",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "up_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "down_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "buyer_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "comment_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "up_and_down",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "upload_timestamp",
            type: "uint256",
          },
        ],
        internalType: "struct StoreContact.FileBriefInfo[10]",
        name: "file_infos",
        type: "tuple[10]",
      },
      {
        internalType: "address",
        name: "next",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "cursor",
        type: "address",
      },
      {
        internalType: "address",
        name: "category",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "order",
        type: "uint256",
      },
      {
        internalType: "bool",
        name: "reverse",
        type: "bool",
      },
    ],
    name: "getFileBriefInfos",
    outputs: [
      {
        components: [
          {
            internalType: "address",
            name: "category",
            type: "address",
          },
          {
            internalType: "address",
            name: "file_address",
            type: "address",
          },
          {
            internalType: "bool",
            name: "is_buy",
            type: "bool",
          },
          {
            internalType: "string",
            name: "name",
            type: "string",
          },
          {
            internalType: "string",
            name: "title",
            type: "string",
          },
          {
            internalType: "string",
            name: "owner",
            type: "string",
          },
          {
            internalType: "string",
            name: "description",
            type: "string",
          },
          {
            internalType: "string",
            name: "cover",
            type: "string",
          },
          {
            internalType: "uint256",
            name: "price",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "up_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "down_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "buyer_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "comment_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "up_and_down",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "upload_timestamp",
            type: "uint256",
          },
        ],
        internalType: "struct StoreContact.FileBriefInfo[10]",
        name: "file_infos",
        type: "tuple[10]",
      },
      {
        internalType: "address",
        name: "next",
        type: "address",
      },
      {
        internalType: "bool",
        name: "finished",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "file_address",
        type: "address",
      },
    ],
    name: "getFileDetailInfo",
    outputs: [
      {
        components: [
          {
            internalType: "address",
            name: "owner",
            type: "address",
          },
          {
            internalType: "address",
            name: "category",
            type: "address",
          },
          {
            internalType: "address",
            name: "file_address",
            type: "address",
          },
          {
            internalType: "bool",
            name: "is_buy",
            type: "bool",
          },
          {
            internalType: "string",
            name: "name",
            type: "string",
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
            internalType: "string",
            name: "ipfs_address",
            type: "string",
          },
          {
            internalType: "string[3]",
            name: "images",
            type: "string[3]",
          },
          {
            internalType: "uint256",
            name: "price",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "up_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "down_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "buyer_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "comment_num",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "up_and_down",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "upload_timestamp",
            type: "uint256",
          },
        ],
        internalType: "struct StoreContact.FileDetailInfo",
        name: "detail_info",
        type: "tuple",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
] as const;

export class FileContact__factory {
  static readonly abi = _abi;
  static createInterface(): FileContactInterface {
    return new utils.Interface(_abi) as FileContactInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): FileContact {
    return new Contract(address, _abi, signerOrProvider) as FileContact;
  }
}
