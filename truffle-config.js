const path = require("path");

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
      
  },
    network_id: 5777
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
  