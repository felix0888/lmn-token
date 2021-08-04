const { ethers, run } = require("hardhat");

module.exports = async ({ deployments }) => {
  const implementation = await ethers.getContract("LmnTokenImplementation");
  try {
    await run("verify:verify", {
      address: implementation.address,
      contract: "contracts/LmnTokenImplementation.sol:LmnTokenImplementation",
    });
  } catch (e) {
    console.log(0, e);
  }

  const artifact = await deployments.getArtifact("LmnTokenImplementation");
  const interface = new ethers.utils.Interface(JSON.stringify(artifact.abi));
  const data = interface.encodeFunctionData("initialize", [
    "LmnToken", "LMN"
  ]);
  const proxy = await ethers.getContract("LmnTokenProxy");
  try {
    await run("verify:verify", {
      address: proxy.address,
      constructorArguments: [
        implementation.address,
        process.env.PROXY_ADMIN_ADDRESS,
        data,
      ],
      contract: "contracts/LmnTokenProxy.sol:LmnTokenProxy",
    });
  } catch (e) {
    console.log(1, e);
  }
};

module.exports.tags = ["Verify"];
