var AgencyControl = artifacts.require("./Agency/AgencyControl.sol");
//var Agency = artifacts.require("./Agency/Agency.sol");

module.exports = function(deployer) {
    deployer.deploy(AgencyControl);


//     // Deploy A, then deploy B, passing in A's newly deployed address
// deployer.deploy(Agency).then(function() {
//     return deployer.deploy(Agency, "This is agency name");
//   });
};
