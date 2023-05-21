/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import BN from "bn.js";
import { EventData, PastEventOptions } from "web3-eth-contract";

export interface UserInterfaceContract
  extends Truffle.Contract<UserInterfaceInstance> {
  "new"(meta?: Truffle.TransactionDetails): Promise<UserInterfaceInstance>;
}

type AllEvents = never;

export interface UserInterfaceInstance extends Truffle.ContractInstance {
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

  isRegistered(
    user_address: string,
    txDetails?: Truffle.TransactionDetails
  ): Promise<boolean>;

  getSelfInfo(
    txDetails?: Truffle.TransactionDetails
  ): Promise<{
    major: string;
    avatar: string;
    nickname: string;
    signature: string;
    ID: BN;
    coins: BN;
    heart: BN;
    experience: BN;
    follower_num: BN;
    following_num: BN;
    login_timestamp: BN;
    uploaded_file_num: BN;
  }>;

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

  methods: {
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

    isRegistered(
      user_address: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<boolean>;

    getSelfInfo(
      txDetails?: Truffle.TransactionDetails
    ): Promise<{
      major: string;
      avatar: string;
      nickname: string;
      signature: string;
      ID: BN;
      coins: BN;
      heart: BN;
      experience: BN;
      follower_num: BN;
      following_num: BN;
      login_timestamp: BN;
      uploaded_file_num: BN;
    }>;

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
