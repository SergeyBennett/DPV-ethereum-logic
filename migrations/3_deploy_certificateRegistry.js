var UserCertificateRegistry = artifacts.require("./User/UserCertificateRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(UserCertificateRegistry);
};
