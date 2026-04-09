const hre = require("hardhat");

async function main() {
  const Market = await hre.ethers.getContractFactory("ComputeMarket");
  const market = await Market.deploy();

  await market.waitForDeployment();
  console.log("Compute Marketplace deployed to:", await market.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
