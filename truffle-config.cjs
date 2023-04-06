module.exports = {
  contracts_directory: "./src/assets/eth/contracts",
  contracts_build_directory: "./src/assets/eth/contracts/build",
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
