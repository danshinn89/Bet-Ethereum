const path = require("path");


const HDWalletProvider = require("@truffle/hdwallet-provider");
const MetaMaskAccountIndex = 0;

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),

  networks: {
    development: {
      port: 7545,
      host: "127.0.0.1",
      network_id: "*"
    },
   
  ganache: {
    provider: function() {
      return new HDWalletProvider("", "http://127.0.0.1:7545", MetaMaskAccountIndex)
      
  },
    network_id: 5777
  },

  goerli: {
    provider: function() {
      return new HDWalletProvider("", "https://goerli.infura.io/v3/13f1920c404a4b338cd42ecf6ce3a485", MetaMaskAccountIndex)
    },
    network_id: 5
  },
  
    ropsten: {
    provider: function() {
      return new HDWalletProvider("", "https://ropsten.infura.io/v3/13f1920c404a4b338cd42ecf6ce3a485", MetaMaskAccountIndex)
    },
    network_id: 3
    },

    compilers: {
      solc: {
        version: "0.6.0"

    },
    contracts_directory: './contracts',
    contracts_build_directory: './build/contracts',
    }
  }
}
  
