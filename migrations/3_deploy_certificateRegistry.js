var CertificateRegistry = artifacts.require("./User/UserCertificateRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(CertificateRegistry);
};
