const { ethers } = require("hardhat");

async function main() {
  // Replace with your actual deployed address
  const contractAddress = "0x9a3DBCa554e9f6b9257aAa24010DA8377C57c17e";
  
  const ArtDIDRegistry = await ethers.getContractFactory("ArtDIDRegistry");
  const contract = ArtDIDRegistry.attach(contractAddress);
  
  // Test setting a record
  console.log("Setting CID record...");
  const tx = await contract.setRecord("QmTest123456789");
  await tx.wait();
  console.log("Record set!");
  
  // Test reading the record
  const cid = await contract.getRecord("0xfe3b557e8fb62b89f4916b721be55ceb828dbd73");
  console.log("Retrieved CID:", cid);
}

main().catch(console.error);