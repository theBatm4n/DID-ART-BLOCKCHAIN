const { ethers } = require("hardhat");

async function main() {
  const contractAddress = "0x2E1f232a9439C3D459FcEca0BeEf13acc8259Dd8";
  
  const ArtDIDRegistry = await ethers.getContractFactory("ArtDIDRegistry");
  const contract = ArtDIDRegistry.attach(contractAddress);
  
  const testCID = "QmTestArtwork1234";
  
  console.log("\n1. Generating DID...");
  const did = await contract.generateDID(testCID);
  console.log("   CID:", testCID);
  console.log("   DID:", did);
  
  console.log("\n2. Checking if registered...");
  const existsBefore = await contract.hasRecord(did);
  console.log("   Already registered:", existsBefore);
  
  console.log("\n3. Registering artwork...");
  const tx = await contract.setRecord(testCID);
  await tx.wait();
  console.log("   ✅ Artwork registered!");
  
  console.log("\n4. Retrieving record...");
  const retrievedCID = await contract.getRecord(did);
  console.log("   Retrieved CID:", retrievedCID);
  console.log("   ✅ Match:", retrievedCID === testCID);
}

main().catch(console.error);