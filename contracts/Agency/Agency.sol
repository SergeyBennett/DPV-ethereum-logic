pragma solidity ^0.4.18;

import "./AgencyControl.sol";
import "./CertificateRegistry.sol";

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



    function createCertificate(address owner) public {
        require(!existsCertificate(owner));
        
    }

    function deleteCertificate(address owner) public {
        
    }

    function createCertificate(address owner) public {
        
    }

    function existsCertificate(address owner) public returns (bool){

        //TODO 
        return true;
    }

    function getCertificateValue(address owner) public {

    }

}