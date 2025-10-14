async function main() {
  console.log("Deploying ArtDIDRegistry to Besu...");
  
  const ArtDIDRegistry = await ethers.getContractFactory("ArtDIDRegistry");
  const registry = await ArtDIDRegistry.deploy();
  
  await registry.waitForDeployment();
  const address = await registry.getAddress();
  
  console.log("✅ ArtDIDRegistry deployed to:", address);
  return address;
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});