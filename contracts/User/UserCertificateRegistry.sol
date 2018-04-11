pragma solidity 0.4.21;

import "../Auxiliary/Mortal.sol";


contract UserCertificateRegistry is Owned {

    mapping (address => string) private issuerToHash;
    mapping (address => bool) private trustedAddresses;
    mapping (address => mapping (string => string)) private issuerToCertificates;

    function UserCertificateRegistry() public {

        addToTrusted(owner);

    }

    function createCertificate (string certName, string ipfsHash) external onlyTrusted returns (address) {
        address issuer = msg.sender;

        require(bytes(issuerToHash[issuer]).length == 0);
        issuerToHash[issuer] = ipfsHash;
        issuerToCertificates[issuer][certName] = ipfsHash;
    }

    function deleteCertificate (string certName) external onlyTrusted returns (address) {
        address issuer = msg.sender;

        require(bytes(issuerToHash[issuer]).length != 0);
        issuerToHash[issuer] = "";
        issuerToCertificates[issuer][certName] = "";
    }

    function editCertificate (string certName, string newIpfsHash) external onlyTrusted returns (address) {
        address issuer = msg.sender;

        require(bytes(issuerToHash[issuer]).length != 0);
        issuerToHash[issuer] = newIpfsHash;
        issuerToCertificates[issuer][certName] = newIpfsHash;
    }

    function existsCertificate (address issuer) public view returns (bool) {
        return bytes(issuerToHash[issuer]).length != 0;
    }

    function existsCertificate (address issuer, string certName) public view {
        bytes(issuerToCertificates[issuer][certName]).length != 0;
    }

    function getCertificates (string certName) public view returns(string) {
        return issuerToCertificates[msg.sender][certName];
    }

    function addToTrusted(address toTrust) public onlyOwner returns (address) {
        require(!trustedAddresses[toTrust]);
        trustedAddresses[toTrust] = true;
        return toTrust;
    }

    function removeFromTrusted(address toUntrust) public onlyOwner returns (address) {
        require(trustedAddresses[toUntrust]);
        trustedAddresses[toUntrust] = false;
        return toUntrust;
    }

    modifier onlyTrusted () {
        require(trustedAddresses[msg.sender]);
        _;
    }
    
    function compareStrings (string a, string b) private pure returns (bool) {
        return keccak256(a) == keccak256(b);
    }
}