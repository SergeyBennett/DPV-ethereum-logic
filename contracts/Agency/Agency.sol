pragma solidity ^0.4.18;

import "./AgencyControl.sol";
import "./CertificateRegistry.sol";
import "../User/UserCertificateRegistry.sol";


contract Agency is AgencyControl {

    string public name;

    mapping(address => bool) private agents;

    CertificateRegistry[] registries;

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

    function createCertificate(address owner, string value) public {
        UserCertificateRegistry recipient = UserCertificateRegistry(owner);
        recipient.createCertificate(value);
        //recipient.createCertificate(certName, value);
    }
    
    function deleteCertificate(address owner, string certName) public {
        UserCertificateRegistry recipient = UserCertificateRegistry(owner);
        recipient.deleteCertificate(certName);
    }

    // function getCertificateValue(address owner) public {

    // }

}