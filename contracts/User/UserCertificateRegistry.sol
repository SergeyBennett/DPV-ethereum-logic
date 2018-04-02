pragma solidity ^0.4.18;

import "../Auxiliary/Mortal.sol";

contract UserCertificateRegistry is Owned {



    mapping (address => string) issuerToHash;
    mapping (address => bool) trustedAddresses;
    mapping (address => mapping (string => string)) issuerToCertificates;




    function UserCertificateRegistry() public {
        trustAddress (owner);
    }

    function createCertificate (address owner,string certName, string IpfsHash) external onlyTrusted {
        require(bytes(issuerToHash[owner]).length == 0);
        issuerToHash[owner] = IpfsHash;
        issuerToCertificates[owner][certName] = IpfsHash;
    }

    function deleteCertificate (address owner, string certName) external onlyTrusted {
        require(bytes(issuerToHash[owner]).length != 0);
        issuerToHash[owner] = "";
        issuerToCertificates[owner][certName] = "";
    }

    function editCertificate (address owner, string certName, string newIpfsHash) external {
        require(bytes(issuerToHash[owner]).length != 0);
        issuerToHash[owner] = newIpfsHash;
        issuerToCertificates[owner][certName] = newIpfsHash;
    }

    function existsCertificate (address owner) public {
        bytes(issuerToHash[owner]).length != 0;
    }

    function existsCertificate (address owner, string certName) public {
        bytes(issuerToCertificates[owner][certName]).length != 0;
    }








    function trustAddress (address toTrust) public onlyOwner {
        require(!trustedAddresses[toTrust]);
        trustedAddresses[toTrust] = true;

    }

    function unTrustAddress (address toUntrust) public onlyOwner {
        require(trustedAddresses[toUntrust]);
        trustedAddresses[toUntrust] = false;
    }

    modifier onlyTrusted () {
        require(trustedAddresses[msg.sender]);
        _;
    }
    
    function compareStrings (string a, string b) private pure returns (bool) {
        return keccak256(a) == keccak256(b);
    }
}