/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import BN from "bn.js";
import { EventData, PastEventOptions } from "web3-eth-contract";

export interface UserContract extends Truffle.Contract<UserInstance> {
  "new"(meta?: Truffle.TransactionDetails): Promise<UserInstance>;
}

type AllEvents = never;

export interface UserInstance extends Truffle.ContractInstance {
  supply(txDetails?: Truffle.TransactionDetails): Promise<BN>;

  symbol(txDetails?: Truffle.TransactionDetails): Promise<string>;

  methods: {
    supply(txDetails?: Truffle.TransactionDetails): Promise<BN>;

    symbol(txDetails?: Truffle.TransactionDetails): Promise<string>;
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
