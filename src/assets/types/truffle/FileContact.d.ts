/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import BN from "bn.js";
import { EventData, PastEventOptions } from "web3-eth-contract";

export interface FileContactContract
  extends Truffle.Contract<FileContactInstance> {
  "new"(meta?: Truffle.TransactionDetails): Promise<FileContactInstance>;
}

export interface AdminTransferred {
  name: "AdminTransferred";
  args: {
    old_admin: string;
    new_admin: string;
    0: string;
    1: string;
  };
}

type AllEvents = AdminTransferred;

export interface FileContactInstance extends Truffle.ContractInstance {
  admin(txDetails?: Truffle.TransactionDetails): Promise<string>;

  renounceAdmin: {
    (txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(txDetails?: Truffle.TransactionDetails): Promise<void>;
    sendTransaction(txDetails?: Truffle.TransactionDetails): Promise<string>;
    estimateGas(txDetails?: Truffle.TransactionDetails): Promise<number>;
  };

  transferAdmin: {
    (new_admin: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(
      new_admin: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      new_admin: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      new_admin: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  addCategory: {
    (name: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(name: string, txDetails?: Truffle.TransactionDetails): Promise<void>;
    sendTransaction(
      name: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      name: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  getCategorySlice(
    cursor: string,
    txDetails?: Truffle.TransactionDetails
  ): Promise<{
    0: { category_address: string; name: string; num: BN }[];
    1: string;
  }>;

  uploadFile: {
    (
      ipfs_address: string,
      title: string,
      description: string,
      category: string,
      images: string[],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      ipfs_address: string,
      title: string,
      description: string,
      category: string,
      images: string[],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      ipfs_address: string,
      title: string,
      description: string,
      category: string,
      images: string[],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      ipfs_address: string,
      title: string,
      description: string,
      category: string,
      images: string[],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  getSelfFileInfos(
    cursor: string,
    reverse: boolean,
    txDetails?: Truffle.TransactionDetails
  ): Promise<{
    0: {
      file_address: string;
      ipfs_address: string;
      owner: string;
      title: string;
      description: string;
      category: string;
      images: string[];
      upload_timestamp: BN;
      price: BN;
      buyer_num: BN;
    }[];
    1: string;
  }>;

  methods: {
    admin(txDetails?: Truffle.TransactionDetails): Promise<string>;

    renounceAdmin: {
      (txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(txDetails?: Truffle.TransactionDetails): Promise<void>;
      sendTransaction(txDetails?: Truffle.TransactionDetails): Promise<string>;
      estimateGas(txDetails?: Truffle.TransactionDetails): Promise<number>;
    };

    transferAdmin: {
      (new_admin: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(
        new_admin: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        new_admin: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        new_admin: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    addCategory: {
      (name: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(name: string, txDetails?: Truffle.TransactionDetails): Promise<void>;
      sendTransaction(
        name: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        name: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    getCategorySlice(
      cursor: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<{
      0: { category_address: string; name: string; num: BN }[];
      1: string;
    }>;

    uploadFile: {
      (
        ipfs_address: string,
        title: string,
        description: string,
        category: string,
        images: string[],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        ipfs_address: string,
        title: string,
        description: string,
        category: string,
        images: string[],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        ipfs_address: string,
        title: string,
        description: string,
        category: string,
        images: string[],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        ipfs_address: string,
        title: string,
        description: string,
        category: string,
        images: string[],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    getSelfFileInfos(
      cursor: string,
      reverse: boolean,
      txDetails?: Truffle.TransactionDetails
    ): Promise<{
      0: {
        file_address: string;
        ipfs_address: string;
        owner: string;
        title: string;
        description: string;
        category: string;
        images: string[];
        upload_timestamp: BN;
        price: BN;
        buyer_num: BN;
      }[];
      1: string;
    }>;
  };

  getPastEvents(event: string): Promise<EventData[]>;
  getPastEvents(
    event: string,
    options: PastEventOptions,
    callback: (error: Error, event: EventData) => void
  ): Promise<EventData[]>;
  getPastEvents(event: string, options: PastEventOptions): Promise<EventData[]>;
  getPastEvents(
    event: string,
    callback: (error: Error, event: EventData) => void
  ): Promise<EventData[]>;
}
