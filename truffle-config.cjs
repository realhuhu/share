require("ts-node").register({
  files: true,
});


module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 9545,
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
