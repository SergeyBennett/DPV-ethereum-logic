pragma solidity ^0.4.21;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/User/UserCertificateRegistry.sol";


contract TestUserCertificateRegistry {
    UserCertificateRegistry private registry = new UserCertificateRegistry();

    // Testing the CreateCertificate() function
    function testCreateCertificate() public {

        address expected = address(this);
        address result = registry.createCertificate("Test", "Test hash");

        Assert.equal(expected, result, "Certificate from this address should be created");
    }

    // Testing the EditCertificate() function
    function testEditCertificate() public {

        address expected = address(this);
        address result = registry.createCertificate("Test", "New test hash");

        Assert.equal(expected, result, "Certificate from this address should be edited");
    }

    // Testing the ExistsCertificate() function (should return false)
    // function testExistsCertificate () public {

    //     bool expected = true;
    //     bool result = registry.existsCertificate(address(this), "New test hash");

    //     Assert.equal(expected, result, "Certificate with this address and name should exist");
    // }

    // Testing the DeleteCertificate() function
    function testDeleteCertificate() public {
        
        address expected = address(this);
        address result = registry.createCertificate("Test", "New test hash");

        Assert.equal(expected, result, "Certificate from this address should be edited");
    }

    // Testing the ExistsCertificate() function (should return true)
    // function testNotExistsCertificate () public {

    //     bool expected = false;
    //     bool result = registry.existsCertificate(address(this), "New test hash");

    //     Assert.equal(expected, result, "Certificate with this address and name should not exist");
    // }
}