/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../common";
import type { OurShare, OurShareInterface } from "../OurShare";

const _abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
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
    stateMutability: "payable",
    type: "fallback",
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
  {
    stateMutability: "payable",
    type: "receive",
  },
  {
    inputs: [],
    name: "getImplementation",
    outputs: [
      {
        internalType: "address",
        name: "implementation",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "implementation",
        type: "address",
      },
    ],
    name: "setImplementation",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b50336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506106a8806100606000396000f3fe60806040526004361061004e5760003560e01c806375829def146100775780638bad0c0a146100a0578063aaf10f42146100b7578063d784d426146100e2578063f851a4401461010b57610065565b366100655761006361005e610136565b610164565b005b610075610070610136565b610164565b005b34801561008357600080fd5b5061009e60048036038101906100999190610532565b61018a565b005b3480156100ac57600080fd5b506100b5610293565b005b3480156100c357600080fd5b506100cc610136565b6040516100d9919061056e565b60405180910390f35b3480156100ee57600080fd5b5061010960048036038101906101049190610532565b61032d565b005b34801561011757600080fd5b506101206103e7565b60405161012d919061056e565b60405180910390f35b6000807f83b120dcec6431b431aa375a0c3da636d7b0d85fae5f77576b0a2964d76e3c139050805491505090565b3660008037600080366000845af43d6000803e8060008114610185573d6000f35b3d6000fd5b3373ffffffffffffffffffffffffffffffffffffffff1660008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614610218576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161020f906105e6565b60405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff1603610287576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161027e90610652565b60405180910390fd5b6102908161040b565b50565b3373ffffffffffffffffffffffffffffffffffffffff1660008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614610321576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610318906105e6565b60405180910390fd5b61032b600061040b565b565b3373ffffffffffffffffffffffffffffffffffffffff1660008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16146103bb576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016103b2906105e6565b60405180910390fd5b60007f83b120dcec6431b431aa375a0c3da636d7b0d85fae5f77576b0a2964d76e3c1390508181555050565b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b60008060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff169050816000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167ff8ccb027dfcd135e000e9d45e6cc2d662578a8825d4c45b5e32e0adf67e79ec660405160405180910390a35050565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006104ff826104d4565b9050919050565b61050f816104f4565b811461051a57600080fd5b50565b60008135905061052c81610506565b92915050565b600060208284031215610548576105476104cf565b5b60006105568482850161051d565b91505092915050565b610568816104f4565b82525050565b6000602082019050610583600083018461055f565b92915050565b600082825260208201905092915050565b7f41646d696e436f6e74726163743e5f6f6e6c7941646d696e5f00000000000000600082015250565b60006105d0601983610589565b91506105db8261059a565b602082019050919050565b600060208201905081810360008301526105ff816105c3565b9050919050565b7f41646d696e436f6e74726163743e7472616e7366657241646d696e0000000000600082015250565b600061063c601b83610589565b915061064782610606565b602082019050919050565b6000602082019050818103600083015261066b8161062f565b905091905056fea2646970667358221220cc5aedfa85c6ca43a000b44bed117daaa3f88e1c01446c6a5cf85f1377fca94864736f6c63430008110033";

type OurShareConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: OurShareConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class OurShare__factory extends ContractFactory {
  constructor(...args: OurShareConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<OurShare> {
    return super.deploy(overrides || {}) as Promise<OurShare>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): OurShare {
    return super.attach(address) as OurShare;
  }
  override connect(signer: Signer): OurShare__factory {
    return super.connect(signer) as OurShare__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): OurShareInterface {
    return new utils.Interface(_abi) as OurShareInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): OurShare {
    return new Contract(address, _abi, signerOrProvider) as OurShare;
  }
}
