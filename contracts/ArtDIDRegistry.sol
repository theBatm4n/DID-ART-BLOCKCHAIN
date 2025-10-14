// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ArtDIDRegistry{

    // DID identifier -> Artwork CID
    mapping(string => string) public didRecords;

    //Event for tracking record changes 
    event RecordSet(string indexed did, string cid, address indexed identity, uint256 timestamp);

    function setRecord(string memory cid) public{
        string memory did = generateDID(cid);

        //Check if already registered
        require(bytes(didRecords[did]).length == 0, "Artwork already registered");

        didRecords[did] = cid;
        emit RecordSet(did, cid, msg.sender, block.timestamp);
    }

    function generateDID(string memory cid) public pure returns (string memory) {
        bytes32 hash = keccak256(abi.encodePacked(cid));
        return toHexString(hash);
    } 

    function getRecord(string memory did) public view returns(string memory){
        return didRecords[did];
    }

    function hasRecord(string memory did) public view returns (bool){
        return bytes(didRecords[did]).length > 0;
    }

    //Convert bytes32 to hex string
    function toHexString(bytes32 value) internal pure returns (string memory) {
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(64); 
        
        for (uint256 i = 0; i < 32; i++) {
            str[i * 2] = alphabet[uint8(value[i] >> 4)];
            str[i * 2 + 1] = alphabet[uint8(value[i] & 0x0f)];
        }
        return string(str);
    }
}