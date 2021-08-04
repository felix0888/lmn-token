const { ethers } = require("hardhat");

module.exports = async ({ deployments }) => {
  const { deploy } = deployments;
  const [ deployer ] = await ethers.getSigners();

  console.log("Deploying contracts with the account: ", deployer.address);

  const implementation = await deploy("LmnTokenImplementation", {
    from: deployer.address
  });
  console.log("LmnTokenImplementation address: ", implementation.address);

  const artifact = await deployments.getArtifact("LmnTokenImplementation");
  const interface = new ethers.utils.Interface(JSON.stringify(artifact.abi));
  const data = interface.encodeFunctionData("initialize", [
    "Laminar Token", "LMN"
  ]);
  const proxy = await(deploy("LmnTokenProxy", {
    from: deployer.address,
    args: [
      implementation.address,
      process.env.PROXY_ADMIN_ADDRESS,
      data
    ]
  }));
  console.log("LmnTokenProxy address: ", proxy.address);
};

module.exports.tags = ["Deploy"];
