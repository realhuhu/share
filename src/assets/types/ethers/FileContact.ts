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

  export type FileBriefInfoStruct = {
    category: PromiseOrValue<string>;
    file_address: PromiseOrValue<string>;
    is_buy: PromiseOrValue<boolean>;
    name: PromiseOrValue<string>;
    title: PromiseOrValue<string>;
    owner: PromiseOrValue<string>;
    description: PromiseOrValue<string>;
    cover: PromiseOrValue<string>;
    price: PromiseOrValue<BigNumberish>;
    up_num: PromiseOrValue<BigNumberish>;
    down_num: PromiseOrValue<BigNumberish>;
    buyer_num: PromiseOrValue<BigNumberish>;
    comment_num: PromiseOrValue<BigNumberish>;
    up_and_down: PromiseOrValue<BigNumberish>;
    upload_timestamp: PromiseOrValue<BigNumberish>;
  };

  export type FileBriefInfoStructOutput = [
    string,
    string,
    boolean,
    string,
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
    BigNumber
  ] & {
    category: string;
    file_address: string;
    is_buy: boolean;
    name: string;
    title: string;
    owner: string;
    description: string;
    cover: string;
    price: BigNumber;
    up_num: BigNumber;
    down_num: BigNumber;
    buyer_num: BigNumber;
    comment_num: BigNumber;
    up_and_down: BigNumber;
    upload_timestamp: BigNumber;
  };

  export type FileDetailInfoStruct = {
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

  export type FileDetailInfoStructOutput = [
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
}

export interface FileContactInterface extends utils.Interface {
  functions: {
    "admin()": FunctionFragment;
    "renounceAdmin()": FunctionFragment;
    "transferAdmin(address)": FunctionFragment;
    "addCategory(string)": FunctionFragment;
    "getCategorySlice(address)": FunctionFragment;
    "uploadFile(string,string,string,string,address,string[3],uint256)": FunctionFragment;
    "getSelfFileBriefInfos(address,bool)": FunctionFragment;
    "getFileBriefInfos(address,address,uint256,bool)": FunctionFragment;
    "getFileDetailInfo(address)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "admin"
      | "renounceAdmin"
      | "transferAdmin"
      | "addCategory"
      | "getCategorySlice"
      | "uploadFile"
      | "getSelfFileBriefInfos"
      | "getFileBriefInfos"
      | "getFileDetailInfo"
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
    functionFragment: "addCategory",
    values: [PromiseOrValue<string>]
  ): string;
  encodeFunctionData(
    functionFragment: "getCategorySlice",
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
  encodeFunctionData(
    functionFragment: "getSelfFileBriefInfos",
    values: [PromiseOrValue<string>, PromiseOrValue<boolean>]
  ): string;
  encodeFunctionData(
    functionFragment: "getFileBriefInfos",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<boolean>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "getFileDetailInfo",
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
  decodeFunctionResult(
    functionFragment: "addCategory",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getCategorySlice",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "uploadFile", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "getSelfFileBriefInfos",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getFileBriefInfos",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getFileDetailInfo",
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

export interface FileContact extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: FileContactInterface;

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

    getSelfFileBriefInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileBriefInfoStructOutput[], string] & {
        file_infos: StoreContact.FileBriefInfoStructOutput[];
        next: string;
      }
    >;

    getFileBriefInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileBriefInfoStructOutput[], string, boolean] & {
        file_infos: StoreContact.FileBriefInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileDetailInfoStructOutput] & {
        detail_info: StoreContact.FileDetailInfoStructOutput;
      }
    >;
  };

  admin(overrides?: CallOverrides): Promise<string>;

  renounceAdmin(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  transferAdmin(
    new_admin: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

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

  getSelfFileBriefInfos(
    cursor: PromiseOrValue<string>,
    reverse: PromiseOrValue<boolean>,
    overrides?: CallOverrides
  ): Promise<
    [StoreContact.FileBriefInfoStructOutput[], string] & {
      file_infos: StoreContact.FileBriefInfoStructOutput[];
      next: string;
    }
  >;

  getFileBriefInfos(
    cursor: PromiseOrValue<string>,
    category: PromiseOrValue<string>,
    order: PromiseOrValue<BigNumberish>,
    reverse: PromiseOrValue<boolean>,
    overrides?: CallOverrides
  ): Promise<
    [StoreContact.FileBriefInfoStructOutput[], string, boolean] & {
      file_infos: StoreContact.FileBriefInfoStructOutput[];
      next: string;
      finished: boolean;
    }
  >;

  getFileDetailInfo(
    file_address: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<StoreContact.FileDetailInfoStructOutput>;

  callStatic: {
    admin(overrides?: CallOverrides): Promise<string>;

    renounceAdmin(overrides?: CallOverrides): Promise<void>;

    transferAdmin(
      new_admin: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

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

    getSelfFileBriefInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileBriefInfoStructOutput[], string] & {
        file_infos: StoreContact.FileBriefInfoStructOutput[];
        next: string;
      }
    >;

    getFileBriefInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [StoreContact.FileBriefInfoStructOutput[], string, boolean] & {
        file_infos: StoreContact.FileBriefInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<StoreContact.FileDetailInfoStructOutput>;
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

    addCategory(
      name: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    getCategorySlice(
      cursor: PromiseOrValue<string>,
      overrides?: CallOverrides
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

    getSelfFileBriefInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getFileBriefInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
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

    addCategory(
      name: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    getCategorySlice(
      cursor: PromiseOrValue<string>,
      overrides?: CallOverrides
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

    getSelfFileBriefInfos(
      cursor: PromiseOrValue<string>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getFileBriefInfos(
      cursor: PromiseOrValue<string>,
      category: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}
