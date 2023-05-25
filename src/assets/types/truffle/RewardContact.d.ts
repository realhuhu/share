/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import BN from "bn.js";
import { EventData, PastEventOptions } from "web3-eth-contract";

export interface RewardContactContract
  extends Truffle.Contract<RewardContactInstance> {
  "new"(meta?: Truffle.TransactionDetails): Promise<RewardContactInstance>;
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

export interface RewardContactInstance extends Truffle.ContractInstance {
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

  RewardContract_init: {
    (txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(txDetails?: Truffle.TransactionDetails): Promise<void>;
    sendTransaction(txDetails?: Truffle.TransactionDetails): Promise<string>;
    estimateGas(txDetails?: Truffle.TransactionDetails): Promise<number>;
  };

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

    RewardContract_init: {
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
