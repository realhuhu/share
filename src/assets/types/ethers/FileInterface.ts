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

export declare namespace Types {
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
    file_address: PromiseOrValue<string>;
    category_address: PromiseOrValue<string>;
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
    file_address: string;
    category_address: string;
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
    file_address: PromiseOrValue<string>;
    category_address: PromiseOrValue<string>;
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
    file_address: string;
    category_address: string;
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

  export type UserBriefInfoStruct = {
    user_address: PromiseOrValue<string>;
    avatar: PromiseOrValue<string>;
    nickname: PromiseOrValue<string>;
    experience: PromiseOrValue<BigNumberish>;
  };

  export type UserBriefInfoStructOutput = [
    string,
    string,
    string,
    BigNumber
  ] & {
    user_address: string;
    avatar: string;
    nickname: string;
    experience: BigNumber;
  };

  export type FileChildrenCommentStruct = {
    target_address: PromiseOrValue<string>;
    comment_address: PromiseOrValue<string>;
    sub_comment_address: PromiseOrValue<string>;
    content: PromiseOrValue<string>;
    author: Types.UserBriefInfoStruct;
    up_num: PromiseOrValue<BigNumberish>;
    down_num: PromiseOrValue<BigNumberish>;
    up_and_down: PromiseOrValue<BigNumberish>;
    comment_timestamp: PromiseOrValue<BigNumberish>;
  };

  export type FileChildrenCommentStructOutput = [
    string,
    string,
    string,
    string,
    Types.UserBriefInfoStructOutput,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber
  ] & {
    target_address: string;
    comment_address: string;
    sub_comment_address: string;
    content: string;
    author: Types.UserBriefInfoStructOutput;
    up_num: BigNumber;
    down_num: BigNumber;
    up_and_down: BigNumber;
    comment_timestamp: BigNumber;
  };

  export type FileRootCommentStruct = {
    comment_address: PromiseOrValue<string>;
    children_comments: [
      Types.FileChildrenCommentStruct,
      Types.FileChildrenCommentStruct
    ];
    content: PromiseOrValue<string>;
    images: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>
    ];
    author: Types.UserBriefInfoStruct;
    up_num: PromiseOrValue<BigNumberish>;
    down_num: PromiseOrValue<BigNumberish>;
    up_and_down: PromiseOrValue<BigNumberish>;
    comment_num: PromiseOrValue<BigNumberish>;
    comment_timestamp: PromiseOrValue<BigNumberish>;
  };

  export type FileRootCommentStructOutput = [
    string,
    [
      Types.FileChildrenCommentStructOutput,
      Types.FileChildrenCommentStructOutput
    ],
    string,
    [string, string, string],
    Types.UserBriefInfoStructOutput,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber,
    BigNumber
  ] & {
    comment_address: string;
    children_comments: [
      Types.FileChildrenCommentStructOutput,
      Types.FileChildrenCommentStructOutput
    ];
    content: string;
    images: [string, string, string];
    author: Types.UserBriefInfoStructOutput;
    up_num: BigNumber;
    down_num: BigNumber;
    up_and_down: BigNumber;
    comment_num: BigNumber;
    comment_timestamp: BigNumber;
  };
}

export interface FileInterfaceInterface extends utils.Interface {
  functions: {
    "addCategory(string)": FunctionFragment;
    "getCategorySlice(address)": FunctionFragment;
    "uploadFile(string,string,string,string,address,string[3],uint256)": FunctionFragment;
    "getSelfFileBriefInfos(address,bool)": FunctionFragment;
    "getFileBriefInfos(address,address,uint256,bool)": FunctionFragment;
    "getFileDetailInfo(address)": FunctionFragment;
    "upAndDown(address,bool)": FunctionFragment;
    "addComment(address,string,string[3])": FunctionFragment;
    "addSubComment(address,address,address,string)": FunctionFragment;
    "getRootComments(address,address,uint256,bool)": FunctionFragment;
  };

  getFunction(
    nameOrSignatureOrTopic:
      | "addCategory"
      | "getCategorySlice"
      | "uploadFile"
      | "getSelfFileBriefInfos"
      | "getFileBriefInfos"
      | "getFileDetailInfo"
      | "upAndDown"
      | "addComment"
      | "addSubComment"
      | "getRootComments"
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
  encodeFunctionData(
    functionFragment: "upAndDown",
    values: [PromiseOrValue<string>, PromiseOrValue<boolean>]
  ): string;
  encodeFunctionData(
    functionFragment: "addComment",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      [PromiseOrValue<string>, PromiseOrValue<string>, PromiseOrValue<string>]
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "addSubComment",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>
    ]
  ): string;
  encodeFunctionData(
    functionFragment: "getRootComments",
    values: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<BigNumberish>,
      PromiseOrValue<boolean>
    ]
  ): string;

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
  decodeFunctionResult(functionFragment: "upAndDown", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "addComment", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "addSubComment",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getRootComments",
    data: BytesLike
  ): Result;

  events: {};
}

export interface FileInterface extends BaseContract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  interface: FileInterfaceInterface;

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
      [Types.CategoryStructOutput[], string, boolean] & {
        category_slice: Types.CategoryStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category_address: PromiseOrValue<string>,
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
      [Types.FileBriefInfoStructOutput[], string, boolean] & {
        file_infos: Types.FileBriefInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getFileBriefInfos(
      cursor: PromiseOrValue<string>,
      category_address: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [Types.FileBriefInfoStructOutput[], string, boolean] & {
        file_infos: Types.FileBriefInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [Types.FileDetailInfoStructOutput] & {
        detail_info: Types.FileDetailInfoStructOutput;
      }
    >;

    upAndDown(
      file_address: PromiseOrValue<string>,
      is_up: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    addComment(
      file_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    addSubComment(
      file_address: PromiseOrValue<string>,
      target_address: PromiseOrValue<string>,
      comment_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<ContractTransaction>;

    getRootComments(
      file_address: PromiseOrValue<string>,
      cursor: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [Types.FileRootCommentStructOutput[], string, boolean] & {
        root_comments: Types.FileRootCommentStructOutput[];
        next: string;
        finished: boolean;
      }
    >;
  };

  addCategory(
    name: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  getCategorySlice(
    cursor: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<
    [Types.CategoryStructOutput[], string, boolean] & {
      category_slice: Types.CategoryStructOutput[];
      next: string;
      finished: boolean;
    }
  >;

  uploadFile(
    ipfs_address: PromiseOrValue<string>,
    name: PromiseOrValue<string>,
    title: PromiseOrValue<string>,
    description: PromiseOrValue<string>,
    category_address: PromiseOrValue<string>,
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
    [Types.FileBriefInfoStructOutput[], string, boolean] & {
      file_infos: Types.FileBriefInfoStructOutput[];
      next: string;
      finished: boolean;
    }
  >;

  getFileBriefInfos(
    cursor: PromiseOrValue<string>,
    category_address: PromiseOrValue<string>,
    order: PromiseOrValue<BigNumberish>,
    reverse: PromiseOrValue<boolean>,
    overrides?: CallOverrides
  ): Promise<
    [Types.FileBriefInfoStructOutput[], string, boolean] & {
      file_infos: Types.FileBriefInfoStructOutput[];
      next: string;
      finished: boolean;
    }
  >;

  getFileDetailInfo(
    file_address: PromiseOrValue<string>,
    overrides?: CallOverrides
  ): Promise<Types.FileDetailInfoStructOutput>;

  upAndDown(
    file_address: PromiseOrValue<string>,
    is_up: PromiseOrValue<boolean>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  addComment(
    file_address: PromiseOrValue<string>,
    content: PromiseOrValue<string>,
    images: [
      PromiseOrValue<string>,
      PromiseOrValue<string>,
      PromiseOrValue<string>
    ],
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  addSubComment(
    file_address: PromiseOrValue<string>,
    target_address: PromiseOrValue<string>,
    comment_address: PromiseOrValue<string>,
    content: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<ContractTransaction>;

  getRootComments(
    file_address: PromiseOrValue<string>,
    cursor: PromiseOrValue<string>,
    order: PromiseOrValue<BigNumberish>,
    reverse: PromiseOrValue<boolean>,
    overrides?: CallOverrides
  ): Promise<
    [Types.FileRootCommentStructOutput[], string, boolean] & {
      root_comments: Types.FileRootCommentStructOutput[];
      next: string;
      finished: boolean;
    }
  >;

  callStatic: {
    addCategory(
      name: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    getCategorySlice(
      cursor: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<
      [Types.CategoryStructOutput[], string, boolean] & {
        category_slice: Types.CategoryStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category_address: PromiseOrValue<string>,
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
      [Types.FileBriefInfoStructOutput[], string, boolean] & {
        file_infos: Types.FileBriefInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getFileBriefInfos(
      cursor: PromiseOrValue<string>,
      category_address: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [Types.FileBriefInfoStructOutput[], string, boolean] & {
        file_infos: Types.FileBriefInfoStructOutput[];
        next: string;
        finished: boolean;
      }
    >;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<Types.FileDetailInfoStructOutput>;

    upAndDown(
      file_address: PromiseOrValue<string>,
      is_up: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<void>;

    addComment(
      file_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      overrides?: CallOverrides
    ): Promise<void>;

    addSubComment(
      file_address: PromiseOrValue<string>,
      target_address: PromiseOrValue<string>,
      comment_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<void>;

    getRootComments(
      file_address: PromiseOrValue<string>,
      cursor: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<
      [Types.FileRootCommentStructOutput[], string, boolean] & {
        root_comments: Types.FileRootCommentStructOutput[];
        next: string;
        finished: boolean;
      }
    >;
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

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category_address: PromiseOrValue<string>,
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
      category_address: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    upAndDown(
      file_address: PromiseOrValue<string>,
      is_up: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    addComment(
      file_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    addSubComment(
      file_address: PromiseOrValue<string>,
      target_address: PromiseOrValue<string>,
      comment_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<BigNumber>;

    getRootComments(
      file_address: PromiseOrValue<string>,
      cursor: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
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

    uploadFile(
      ipfs_address: PromiseOrValue<string>,
      name: PromiseOrValue<string>,
      title: PromiseOrValue<string>,
      description: PromiseOrValue<string>,
      category_address: PromiseOrValue<string>,
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
      category_address: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getFileDetailInfo(
      file_address: PromiseOrValue<string>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    upAndDown(
      file_address: PromiseOrValue<string>,
      is_up: PromiseOrValue<boolean>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    addComment(
      file_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      images: [
        PromiseOrValue<string>,
        PromiseOrValue<string>,
        PromiseOrValue<string>
      ],
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    addSubComment(
      file_address: PromiseOrValue<string>,
      target_address: PromiseOrValue<string>,
      comment_address: PromiseOrValue<string>,
      content: PromiseOrValue<string>,
      overrides?: Overrides & { from?: PromiseOrValue<string> }
    ): Promise<PopulatedTransaction>;

    getRootComments(
      file_address: PromiseOrValue<string>,
      cursor: PromiseOrValue<string>,
      order: PromiseOrValue<BigNumberish>,
      reverse: PromiseOrValue<boolean>,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}
