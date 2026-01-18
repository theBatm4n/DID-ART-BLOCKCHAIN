// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ArtDIDRegistry{

    struct ArtworkRecord {
        string cid;
        uint256 created_at;
        uint256 updated_at;
        address creator;
    }

    // DID identifier -> Artwork CID
    mapping(bytes32 => ArtworkRecord) public didRecords;

    //Event for tracking record changes 
    event RecordSet(
        bytes32 indexed did, 
        string cid, 
        address indexed identity, 
        uint256 created_at,
        uint256 updated_at
    );

    event RecordUpdated(
        bytes32 indexed did,
        string newCid,
        address indexed updater,
        uint256 updated_at
    );

    
    function setRecord(string memory cid) public returns (bytes32) {
        require(bytes(cid).length > 0, "CID cannot be empty");
        bytes32 did = generateDID(cid);
        require(bytes(didRecords[did].cid).length == 0, "Artwork already registered");
        
        didRecords[did] = ArtworkRecord({
            cid: cid,
            created_at: block.timestamp,
            updated_at: block.timestamp,
            creator: msg.sender
        });
        
        emit RecordSet(did, cid, msg.sender, block.timestamp, block.timestamp);
        return did;
    }

    function updateRecord(string memory oldCid, string memory newCid) public {
        bytes32 did = generateDID(oldCid);
        require(bytes(didRecords[did].cid).length > 0, "Record not found");
        require(didRecords[did].creator == msg.sender, "Only creator can update");
        
        didRecords[did].cid = newCid;
        didRecords[did].updated_at = block.timestamp;
        
        emit RecordUpdated(did, newCid, msg.sender, block.timestamp);
    }

    function generateDID(string memory cid) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(cid));
    } 

    function getRecord(bytes32 did) public view returns (
        string memory cid,
        uint256 created_at,
        uint256 updated_at,
        address creator
    ) {
        ArtworkRecord memory record = didRecords[did];
        return (record.cid, record.created_at, record.updated_at, record.creator);
    }
    
    function getFullRecord(bytes32 did) public view returns (ArtworkRecord memory) {
        return didRecords[did];
    }

    function hasRecord(bytes32 did) public view returns (bool){
        return bytes(didRecords[did].cid).length > 0;
    }
}