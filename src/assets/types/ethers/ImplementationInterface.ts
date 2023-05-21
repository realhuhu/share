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
import type { FunctionFragment, Result } from "@ethersproject/abi";
import type { Listener, Provider } from "@ethersproject/providers";
import type {
  TypedEventFilter,
  TypedEvent,
  TypedListener,
  OnEvent,
  PromiseOrValue,
} from "./common";

export declare namespace StoreContact {
  export type CategoryStruct = {
    category_address: PromiseOrValue<string>;
    name: PromiseOrValue<string>;
    num: PromiseOrValue<BigNumberish>;
  };

  export type CategoryStructOutput = [string, string, BigNumber] & {
    category_address: string;
    name: string;
    num: BigNumber;
  };

  export type FileInfoStruct = {
    owner: PromiseOrValue<string>;
    category: PromiseOrValue<string>;
    file_address: PromiseOrValue<string>;
    is_buy: PromiseOrValue<boolean>;
    name: PromiseOrValue<string>;
    title: PromiseOrValue<string>;
    description: PromiseOrValue<string>;
    ipfs_address: PromiseOrValue<string>;
    images: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>
    ];
    price: PromiseOrValue<BigNumberish>;
    up_num: PromiseOrValue<BigNumberish>;
    down_num: PromiseOrValue<BigNumberish>;
    buyer_num: PromiseOrValue<BigNumberish>;
    comment_num: PromiseOrValue<BigNumberish>;
    up_and_down: PromiseOrValue<BigNumberish>;
    upload_timestamp: PromiseOrValue<BigNumberish>;
  };

  export type FileInfoStructOutput = [
    string,
    string,
    string,
    boolean,
    string,
    string,
    string,
    string,
    [string, string, string],
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber
  ] & {
    owner: string;
    category: string;
    file_address: string;
    is_buy: boolean;
    name: string;
    title: string;
    description: string;
    ipfs_address: string;
    images: [string, string, string];
    price: BigNumber;
    up_num: BigNumber;
    down_num: BigNumber;
    buyer_num: BigNumber;
    comment_num: BigNumber;
    up_and_down: BigNumber;
    upload_timestamp: BigNumber;
  };

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
}

export interface ImplementationInterfaceInterface extends utils.Interface {
  functions: {
    "addCategory(string)": FunctionFragment;
    "getCategorySlice(address)": FunctionFragment;
    "getFileInfos(address,address,uint256,bool)": FunctionFragment;
    "getSelfFileInfos(address,bool)": FunctionFragment;
    "getSelfInfo()": FunctionFragment;
    "isRegistered(address)": FunctionFragment;
    "register(string)": FunctionFragment;
    "renounceAdmin()": FunctionFragment;
    "transferAdmin(address)": FunctionFragment;
    "updateAvatar(string)": FunctionFragment;
    "updateNickname(string)": FunctionFragment;
    "updateSignature(string)": FunctionFragment;
    "uploadFile(string,string,string,string,address,string[3],uint256)": FunctionFragment;
    "init()": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "addCategory"
      | "getCategorySlice"
      | "getFileInfos"
      | "getSelfFileInfos"
      | "getSelfInfo"
      | "isRegistered"
      | "register"
      | "renounceAdmin"
      | "transferAdmin"
      | "updateAvatar"
      | "updateNickname"
      | "updateSignature"
      | "uploadFile"
      | "init"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "addCategory",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "getCategorySlice",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "getFileInfos",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<boolean>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "getSelfFileInfos",
    values: [PromiseOrValue<string>, PromiseOrValue<boolean>]
  ): string;
  encodeFunctionData(
    functionFragment: "getSelfInfo",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "isRegistered",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "register",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "renounceAdmin",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "transferAdmin",
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
  encodeFunctionData(
    functionFragment: "uploadFile",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      [PromiseOrValue<string>, PromiseOrValue<string>, PromiseOrValue<string>],
      PromiseOrValue<BigNumberish>
    ]
  ): string;
  encodeFunctionData(functionFragment: "init", values?: undefined): string;

  decodeFunctionResult(
    functionFragment: "addCategory",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getCategorySlice",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getFileInfos",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getSelfFileInfos",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getSelfInfo",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isRegistered",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "register", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "renounceAdmin",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "transferAdmin",
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
  decodeFunctionResult(functionFragment: "uploadFile", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "init", data: BytesLike): Result;

  events: {};
}

export interface ImplementationInterface extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: ImplementationInterfaceInterface;

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
    addCategory(
      name: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    getCategorySlice(
      cursor: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.CategoryStructOutput[], string] & {
        category_slice: StoreContact.CategoryStructOutput[];
        next: string;
      }
    >;

    getFileInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileInfoStructOutput[], string, boolean] & {
        file_infos: StoreContact.FileInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getSelfFileInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileInfoStructOutput[], string] & {
        file_infos: StoreContact.FileInfoStructOutput[];
        next: string;
      }
    >;

    getSelfInfo(
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.UserSelfInfoStructOutput] & {
        self_info: StoreContact.UserSelfInfoStructOutput;
      }
    >;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<[boolean] & { is_registered: boolean }>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    renounceAdmin(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

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

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      price: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    init(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;
  };

  addCategory(
    name: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  getCategorySlice(
    cursor: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<
    [StoreContact.CategoryStructOutput[], string] & {
      category_slice: StoreContact.CategoryStructOutput[];
      next: string;
    }
  >;

  getFileInfos(
    cursor: PromiseOrValue<string>,
    category: PromiseOrValue<string>,
    order: PromiseOrValue<BigNumberish>,
    reverse: PromiseOrValue<boolean>,
    overrides?: CallOverrides
  ): Promise<
    [StoreContact.FileInfoStructOutput[], string, boolean] & {
      file_infos: StoreContact.FileInfoStructOutput[];
      next: string;
      finished: boolean;
    }
  >;

  getSelfFileInfos(
    cursor: PromiseOrValue<string>,
    reverse: PromiseOrValue<boolean>,
    overrides?: CallOverrides
  ): Promise<
    [StoreContact.FileInfoStructOutput[], string] & {
      file_infos: StoreContact.FileInfoStructOutput[];
      next: string;
    }
  >;

  getSelfInfo(
    overrides?: CallOverrides
  ): Promise<StoreContact.UserSelfInfoStructOutput>;

  isRegistered(
    user_address: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<boolean>;

  register(
    nickname: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  renounceAdmin(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  transferAdmin(
    new_admin: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

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

  uploadFile(
    ipfs_address: PromiseOrValue<string>,
    name: PromiseOrValue<string>,
    title: PromiseOrValue<string>,
    description: PromiseOrValue<string>,
    category: PromiseOrValue<string>,
    images: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>
    ],
    price: PromiseOrValue<BigNumberish>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  init(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  callStatic: {
    addCategory(
      name: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    getCategorySlice(
      cursor: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.CategoryStructOutput[], string] & {
        category_slice: StoreContact.CategoryStructOutput[];
        next: string;
      }
    >;

    getFileInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileInfoStructOutput[], string, boolean] & {
        file_infos: StoreContact.FileInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getSelfFileInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileInfoStructOutput[], string] & {
        file_infos: StoreContact.FileInfoStructOutput[];
        next: string;
      }
    >;

    getSelfInfo(
      overrides?: CallOverrides
    ): Promise<StoreContact.UserSelfInfoStructOutput>;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<boolean>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    renounceAdmin(overrides?: CallOverrides): Promise<void>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

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

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      price: PromiseOrValue<BigNumberish>,
      overrides?: CallOverrides
    ): Promise<void>;

    init(overrides?: CallOverrides): Promise<void>;
  };

  filters: {};

  estimateGas: {
    addCategory(
      name: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    getCategorySlice(
      cursor: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getFileInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getSelfFileInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getSelfInfo(overrides?: CallOverrides): Promise<BigNumber>;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    renounceAdmin(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
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

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      price: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    init(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    addCategory(
      name: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    getCategorySlice(
      cursor: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getFileInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getSelfFileInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getSelfInfo(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    isRegistered(
      user_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    register(
      nickname: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    renounceAdmin(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
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

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      price: PromiseOrValue<BigNumberish>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    init(
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;
  };
}
