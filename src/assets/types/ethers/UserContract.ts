/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumber,
  BigNumberish,
  BytesLike,
  CallOverrides,
  ContractTransaction,
  Overrides,
  PopulatedTransaction,
  Signer,
  utils,
} from "ethers";
import type {
  FunctionFragment,
  Result,
  EventFragment,
} from "@ethersproject/abi";
import type { Listener, Provider } from "@ethersproject/providers";
import type {
  TypedEventFilter,
  TypedEvent,
  TypedListener,
  OnEvent,
  PromiseOrValue,
} from "./common";

export declare namespace StoreContact {
  export type UserSelfInfoStruct = {
    major: PromiseOrValue<string>;
    avatar: PromiseOrValue<string>;
    nickname: PromiseOrValue<string>;
    signature: PromiseOrValue<string>;
    ID: PromiseOrValue<BigNumberish>;
    coins: PromiseOrValue<BigNumberish>;
    heart: PromiseOrValue<BigNumberish>;
    experience: PromiseOrValue<BigNumberish>;
    follower_num: PromiseOrValue<BigNumberish>;
    following_num: PromiseOrValue<BigNumberish>;
    login_timestamp: PromiseOrValue<BigNumberish>;
    uploaded_file_num: PromiseOrValue<BigNumberish>;
  };

  export type UserSelfInfoStructOutput = [
    string,
    string,
    string,
    string,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber
  ] & {
    major: string;
    avatar: string;
    nickname: string;
    signature: string;
    ID: BigNumber;
    coins: BigNumber;
    heart: BigNumber;
    experience: BigNumber;
    follower_num: BigNumber;
    following_num: BigNumber;
    login_timestamp: BigNumber;
    uploaded_file_num: BigNumber;
  };

  export type UserSimpleInfoStruct = {
    major: PromiseOrValue<string>;
    avatar: PromiseOrValue<string>;
    nickname: PromiseOrValue<string>;
    signature: PromiseOrValue<string>;
    heart: PromiseOrValue<BigNumberish>;
    medal_num: PromiseOrValue<BigNumberish>;
    experience: PromiseOrValue<BigNumberish>;
    follower_num: PromiseOrValue<BigNumberish>;
    uploaded_file_num: PromiseOrValue<BigNumberish>;
  };

  export type UserSimpleInfoStructOutput = [
    string,
    string,
    string,
    string,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber
  ] & {
    major: string;
    avatar: string;
    nickname: string;
    signature: string;
    heart: BigNumber;
    medal_num: BigNumber;
    experience: BigNumber;
    follower_num: BigNumber;
    uploaded_file_num: BigNumber;
  };
}

export interface UserContractInterface extends utils.Interface {
  functions: {
    "admin()": FunctionFragment;
    "renounceAdmin()": FunctionFragment;
    "transferAdmin(address)": FunctionFragment;
    "register(string)": FunctionFragment;
    "isRegistered(address)": FunctionFragment;
    "getSelfInfo()": FunctionFragment;
    "getOtherSimpleInfo(address)": FunctionFragment;
    "updateAvatar(string)": FunctionFragment;
    "updateNickname(string)": FunctionFragment;
    "updateSignature(string)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "admin"
      | "renounceAdmin"
      | "transferAdmin"
      | "register"
      | "isRegistered"
      | "getSelfInfo"
      | "getOtherSimpleInfo"
      | "updateAvatar"
      | "updateNickname"
      | "updateSignature"
  ): FunctionFragment;

  encodeFunctionData(functionFragment: "admin", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "renounceAdmin",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "transferAdmin",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "register",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "isRegistered",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "getSelfInfo",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "getOtherSimpleInfo",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "updateAvatar",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "updateNickname",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "updateSignature",
    values: [PromiseOrValue<string>]
  ): string;

  decodeFunctionResult(functionFragment: "admin", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "renounceAdmin",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferAdmin",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "register", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "isRegistered",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getSelfInfo",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getOtherSimpleInfo",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "updateAvatar",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "updateNickname",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "updateSignature",
    data: BytesLike
  ): Result;

  events: {
    "AdminTransferred(address,address)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "AdminTransferred"): EventFragment;
}

export interface AdminTransferredEventObject {
  old_admin: string;
  new_admin: string;
}
export type AdminTransferredEvent = TypedEvent<
  [string, string],
  AdminTransferredEventObject
>;

export type AdminTransferredEventFilter =
  TypedEventFilter<AdminTransferredEvent>;

export interface UserContract extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: UserContractInterface;

  queryFilter<TEvent extends TypedEvent>(
    event: TypedEventFilter<TEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TEvent>>;

  listeners<TEvent extends TypedEvent>(
    eventFilter?: TypedEventFilter<TEvent>
  ): Array<TypedListener<TEvent>>;
  listeners(eventName?: string): Array<Listener>;
  removeAllListeners<TEvent extends TypedEvent>(
    eventFilter: TypedEventFilter<TEvent>
  ): this;
  removeAllListeners(eventName?: string): this;
  off: OnEvent<this>;
  on: OnEvent<this>;
  once: OnEvent<this>;
  removeListener: OnEvent<this>;

  functions: {
    admin(overrides?: CallOverrides): Promise<[string]>;

    renounceAdmin(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[boolean] & { is_registered: boolean }>;

    getSelfInfo(
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.UserSelfInfoStructOutput] & {
        self_info: StoreContact.UserSelfInfoStructOutput;
      }
    >;

    getOtherSimpleInfo(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.UserSimpleInfoStructOutput] & {
        simple_info: StoreContact.UserSimpleInfoStructOutput;
      }
    >;

    updateAvatar(
      avatar: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    updateNickname(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    updateSignature(
      signature: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;
  };

  admin(overrides?: CallOverrides): Promise<string>;

  renounceAdmin(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  transferAdmin(
    new_admin: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  register(
    nickname: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  isRegistered(
    user_address: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  getSelfInfo(
    overrides?: CallOverrides
  ): Promise<StoreContact.UserSelfInfoStructOutput>;

  getOtherSimpleInfo(
    user_address: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<StoreContact.UserSimpleInfoStructOutput>;

  updateAvatar(
    avatar: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  updateNickname(
    nickname: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  updateSignature(
    signature: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    admin(overrides?: CallOverrides): Promise<string>;

    renounceAdmin(overrides?: CallOverrides): Promise<void>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    getSelfInfo(
      overrides?: CallOverrides
    ): Promise<StoreContact.UserSelfInfoStructOutput>;

    getOtherSimpleInfo(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<StoreContact.UserSimpleInfoStructOutput>;

    updateAvatar(
      avatar: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    updateNickname(
      nickname: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    updateSignature(
      signature: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;
  };

  filters: {
    "AdminTransferred(address,address)"(
      old_admin?: PromiseOrValue<string> | null,
      new_admin?: PromiseOrValue<string> | null
    ): AdminTransferredEventFilter;
    AdminTransferred(
      old_admin?: PromiseOrValue<string> | null,
      new_admin?: PromiseOrValue<string> | null
    ): AdminTransferredEventFilter;
  };

  estimateGas: {
    admin(overrides?: CallOverrides): Promise<BigNumber>;

    renounceAdmin(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getSelfInfo(overrides?: CallOverrides): Promise<BigNumber>;

    getOtherSimpleInfo(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    updateAvatar(
      avatar: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    updateNickname(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    updateSignature(
      signature: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    admin(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    renounceAdmin(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getSelfInfo(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    getOtherSimpleInfo(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    updateAvatar(
      avatar: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    updateNickname(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    updateSignature(
      signature: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;
  };
}
