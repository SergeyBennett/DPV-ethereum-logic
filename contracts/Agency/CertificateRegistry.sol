pragma solidity ^0.4.18;

import "../Auxiliary/Mortal.sol";

contract CertificateRegistry is Owned {

    //TODO Hash compression to bytes32

    //mapping (string => address) hashToAddress;

    mapping (address => string) addressToHash;

    function CertificateRegistry() public {
        
    }

    function createCertificate (address owner, string IpfsHash) external onlyOwner {
        require(bytes(addressToHash[owner]).length == 0);
        addressToHash[owner] = IpfsHash;
    }

    function deleteCertificate (address owner) external onlyOwner {
        require(bytes(addressToHash[owner]).length != 0);
        addressToHash[owner] = "";
    }

    function editCertificate (address owner, string newIpfsHash) external onlyOwner {
        require(bytes(addressToHash[owner]).length != 0);
        addressToHash[owner] = newIpfsHash;
    }

    function existsCertificate (address owner) external view onlyOwner {
        bytes(addressToHash[owner]).length != 0;
    }

    /*

    function createCertificate(string ipfsHash,address owner) public {
        assert(compareStrings(ipfsHash, ""));
        assert(hashToAddress[ipfsHash] != address(0));
        hashToAddress[ipfsHash] = owner;
    }


    function getOwner(string ipfsHash) public view returns (address) {
        return hashToAddress[ipfsHash];
    }

    */
    
    function compareStrings (string a, string b) private pure returns (bool) {
        return keccak256(a) == keccak256(b);
    }
}