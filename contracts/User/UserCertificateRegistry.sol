pragma solidity ^0.4.18;

import "../Auxiliary/Mortal.sol";

contract UserCertificateRegistry is Owned {



    mapping (address => string) issuerToHash;
    mapping (address => bool) trustedAddresses;
    mapping (address => mapping (string => string)) issuerToCertificates;




    function UserCertificateRegistry() public {
        trustAddress (owner);
    }

    function createCertificate (string certName, string IpfsHash) external onlyTrusted {
        address issuer = msg.sender;

        require(bytes(issuerToHash[issuer]).length == 0);
        issuerToHash[issuer] = IpfsHash;
        issuerToCertificates[issuer][certName] = IpfsHash;
    }

    function deleteCertificate (string certName) external onlyTrusted {
        address issuer = msg.sender;

        require(bytes(issuerToHash[issuer]).length != 0);
        issuerToHash[issuer] = "";
        issuerToCertificates[issuer][certName] = "";
    }

    function editCertificate (string certName, string newIpfsHash) external {
        address issuer = msg.sender;

        require(bytes(issuerToHash[issuer]).length != 0);
        issuerToHash[issuer] = newIpfsHash;
        issuerToCertificates[issuer][certName] = newIpfsHash;
    }

    function existsCertificate (address issuer) view public returns (bool) {
        return bytes(issuerToHash[issuer]).length != 0;
    }

    function existsCertificate (address issuer, string certName) view public {
        bytes(issuerToCertificates[issuer][certName]).length != 0;
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