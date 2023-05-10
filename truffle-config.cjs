require("ts-node").register({
  files: true,
});


module.exports = {
  networks: {
    development: {
      url: "https://testnet.seutools.com/rpc",
      network_id: "*"
    },
    update: {
      url: "https://testnet.seutools.com/rpc",
      network_id: "*"
    }
  },
  contracts_directory: "./src/assets/eth/contracts",
  contracts_build_directory: "./src/assets/eth/build",
  migrations_directory: "./src/assets/eth/migrations",
  compilers: {
    solc: {
      version: "^0.8.0",
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
}
