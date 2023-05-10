/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import BN from "bn.js";
import { EventData, PastEventOptions } from "web3-eth-contract";

export interface ImplementationContactContract
  extends Truffle.Contract<ImplementationContactInstance> {
  "new"(
    meta?: Truffle.TransactionDetails
  ): Promise<ImplementationContactInstance>;
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

export interface ImplementationContactInstance
  extends Truffle.ContractInstance {
  admin(txDetails?: Truffle.TransactionDetails): Promise<string>;

  getSelfInfo(
    txDetails?: Truffle.TransactionDetails
  ): Promise<{
    ID: BN;
    coins: BN;
    heart: BN;
    experience: BN;
    follower_num: BN;
    following_num: BN;
    login_timestamp: BN;
    uploaded_file_num: BN;
    major: string;
    avatar: string;
    nickname: string;
    signature: string;
  }>;

  isRegistered(
    user_address: string,
    txDetails?: Truffle.TransactionDetails
  ): Promise<boolean>;

  register: {
    (nickname: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(
      nickname: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      nickname: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      nickname: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

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

  updateAvatar: {
    (avatar: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(avatar: string, txDetails?: Truffle.TransactionDetails): Promise<void>;
    sendTransaction(
      avatar: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      avatar: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  updateNickname: {
    (nickname: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(
      nickname: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      nickname: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      nickname: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  updateSignature: {
    (signature: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(
      signature: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      signature: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      signature: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  uploadFile: {
    (
      ipfs_address: string,
      title: string,
      description: string,
      images: string[][],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      ipfs_address: string,
      title: string,
      description: string,
      images: string[][],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      ipfs_address: string,
      title: string,
      description: string,
      images: string[][],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      ipfs_address: string,
      title: string,
      description: string,
      images: string[][],
      price: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  init: {
    (txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(txDetails?: Truffle.TransactionDetails): Promise<void>;
    sendTransaction(txDetails?: Truffle.TransactionDetails): Promise<string>;
    estimateGas(txDetails?: Truffle.TransactionDetails): Promise<number>;
  };

  methods: {
    admin(txDetails?: Truffle.TransactionDetails): Promise<string>;

    getSelfInfo(
      txDetails?: Truffle.TransactionDetails
    ): Promise<{
      ID: BN;
      coins: BN;
      heart: BN;
      experience: BN;
      follower_num: BN;
      following_num: BN;
      login_timestamp: BN;
      uploaded_file_num: BN;
      major: string;
      avatar: string;
      nickname: string;
      signature: string;
    }>;

    isRegistered(
      user_address: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<boolean>;

    register: {
      (nickname: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(
        nickname: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        nickname: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        nickname: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

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

    updateAvatar: {
      (avatar: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(
        avatar: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        avatar: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        avatar: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    updateNickname: {
      (nickname: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(
        nickname: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        nickname: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        nickname: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    updateSignature: {
      (signature: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(
        signature: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        signature: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        signature: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    uploadFile: {
      (
        ipfs_address: string,
        title: string,
        description: string,
        images: string[][],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        ipfs_address: string,
        title: string,
        description: string,
        images: string[][],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        ipfs_address: string,
        title: string,
        description: string,
        images: string[][],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        ipfs_address: string,
        title: string,
        description: string,
        images: string[][],
        price: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    init: {
      (txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(txDetails?: Truffle.TransactionDetails): Promise<void>;
      sendTransaction(txDetails?: Truffle.TransactionDetails): Promise<string>;
      estimateGas(txDetails?: Truffle.TransactionDetails): Promise<number>;
    };
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