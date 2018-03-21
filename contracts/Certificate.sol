pragma solidity ^0.4.18;

contract CertificateBase {

    //IPFS has is initially encoded in base58
    //

    mapping(string => address) hashToAddress;

    function CertificateBase() public {

    }

    function createContract(string ipfsHash,address owner) public {
        assert(compareStrings(ipfsHash, ""));
        assert(hashToAddress[ipfsHash]!=address(0));
        hashToAddress[ipfsHash] = owner;
    }

    function compareStrings (string a, string b) private pure returns (bool) {
       return keccak256(a) == keccak256(b);
    }

    function getOwner(string ipfsHash) public view returns (address) {
        return hashToAddress[ipfsHash];
    }

}