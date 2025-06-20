const hre = require("hardhat");

async function main() {
  const Bridge = await hre.ethers.getContractFactory("CrossChainBridge");
  const bridge = await Bridge.deploy();

  await bridge.deployed();

  console.log(`CrossChainBridge deployed to: ${bridge.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
