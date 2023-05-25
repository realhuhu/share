/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../common";
import type {
  MessageContact,
  MessageContactInterface,
} from "../MessageContact";

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
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b506104ee806100206000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c806375829def146100465780638bad0c0a14610062578063f851a4401461006c575b600080fd5b610060600480360381019061005b9190610378565b61008a565b005b61006a610193565b005b61007461022d565b60405161008191906103b4565b60405180910390f35b3373ffffffffffffffffffffffffffffffffffffffff1660008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614610118576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161010f9061042c565b60405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff1603610187576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161017e90610498565b60405180910390fd5b61019081610251565b50565b3373ffffffffffffffffffffffffffffffffffffffff1660008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614610221576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016102189061042c565b60405180910390fd5b61022b6000610251565b565b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff169050816000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167ff8ccb027dfcd135e000e9d45e6cc2d662578a8825d4c45b5e32e0adf67e79ec660405160405180910390a35050565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006103458261031a565b9050919050565b6103558161033a565b811461036057600080fd5b50565b6000813590506103728161034c565b92915050565b60006020828403121561038e5761038d610315565b5b600061039c84828501610363565b91505092915050565b6103ae8161033a565b82525050565b60006020820190506103c960008301846103a5565b92915050565b600082825260208201905092915050565b7f41646d696e436f6e74726163743e5f6f6e6c7941646d696e5f00000000000000600082015250565b60006104166019836103cf565b9150610421826103e0565b602082019050919050565b6000602082019050818103600083015261044581610409565b9050919050565b7f41646d696e436f6e74726163743e7472616e7366657241646d696e0000000000600082015250565b6000610482601b836103cf565b915061048d8261044c565b602082019050919050565b600060208201905081810360008301526104b181610475565b905091905056fea2646970667358221220fb26f4879af4d633b51801f9ef47391c0a66c1894bbfd9cabef7fbf75ebb069964736f6c63430008110033";

type MessageContactConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: MessageContactConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class MessageContact__factory extends ContractFactory {
  constructor(...args: MessageContactConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<MessageContact> {
    return super.deploy(overrides || {}) as Promise<MessageContact>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): MessageContact {
    return super.attach(address) as MessageContact;
  }
  override connect(signer: Signer): MessageContact__factory {
    return super.connect(signer) as MessageContact__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): MessageContactInterface {
    return new utils.Interface(_abi) as MessageContactInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): MessageContact {
    return new Contract(address, _abi, signerOrProvider) as MessageContact;
  }
}
