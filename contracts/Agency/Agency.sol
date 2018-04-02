pragma solidity ^0.4.18;

import "./AgencyControl.sol";
import "./CertificateRegistry.sol";
import "../User/UserCertificateRegistry.sol";

contract Agency is AgencyControl {

    string public Name;

    mapping(address => bool) private Agents;

    CertificateRegistry[] registries;

    function Agency (string name) public {
        Name = name;
    }

    function addAgent(address newAgent) external onlyCEO {
        require(!Agents[newAgent]);
        Agents[newAgent] = true;
    }

    function deleteAgent(address agent) external onlyCEO {
        require(Agents[agent]);
        Agents[agent] = true;
    }

    function existsAgent(address agent) external view onlyCLevel returns (bool) {
        return Agents[agent];
    }

    modifier onlyAgent() {
        require(Agents[msg.sender]);
        _;
    }



    function createCertificate(address owner, string certName, string value) public {
        UserCertificateRegistry recipient = UserCertificateRegistry(owner);
        recipient.createCertificate(certName, value);
    }

    function deleteCertificate(address owner, string certName) public {
        UserCertificateRegistry recipient = UserCertificateRegistry(owner);
        recipient.deleteCertificate(certName);
    }

    // function getCertificateValue(address owner) public {

    // }

}