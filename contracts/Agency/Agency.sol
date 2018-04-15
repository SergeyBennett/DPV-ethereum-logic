pragma solidity 0.4.18;

import "./AgencyControl.sol";
import "./CertificateRegistry.sol";
import "../User/UserCertificateRegistry.sol";


contract Agency is AgencyControl {

    string public name;

    mapping(address => bool) private agents;

    //CertificateRegistry[] registries;

    function Agency (string name) public {
        name = name;
    }

    function addAgent(address newAgent) external onlyCEO {
        require(!agents[newAgent]);
        agents[newAgent] = true;
    }

    function deleteAgent(address agent) external onlyCEO {
        require(agents[agent]);
        agents[agent] = true;
    }

    function existsAgent(address agent) external view onlyCLevel returns (bool) {
        return agents[agent];
    }

    modifier onlyAgent() {
        require(agents[msg.sender]);
        _;
    }

    function createCertificate(address ownerRegistry, string certName, string value) public {
        UserCertificateRegistry recipient = UserCertificateRegistry(ownerRegistry);
        recipient.createCertificate(certName, value);
    }

    function deleteCertificate(address ownerRegistry, string certName) public {
        UserCertificateRegistry recipient = UserCertificateRegistry(ownerRegistry);
        recipient.deleteCertificate(certName);
    }

    // function getCertificateValue(address owner) public {

    // }

}