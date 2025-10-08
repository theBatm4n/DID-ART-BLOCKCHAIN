// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ArtDIDRegistry{

    //Mapping from address to DID record
    mapping(address => string) public didRecords;

    //Event for tracking record changes 
    event RecordSet(address indexed identity, string cid, uint256 timestamp);

    function setRecord(string memory cid) public{
        didRecords[msg.sender] = cid;
        emit RecordSet(msg.sender, cid, block.timestamp);
    }

    function getRecord(address identity) public view returns(string memory){
        return didRecords[identity];
    }

    function hasRecord(address identity) public view returns (bool){
        return bytes(didRecords[identity]).length > 0;
    }
}