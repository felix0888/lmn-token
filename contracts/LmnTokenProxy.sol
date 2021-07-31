//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/proxy/TransparentUpgradeableProxy.sol";

contract LmnTokenProxy {
  bool public isUpgradeable;
  constructor(address logic, address admin, bytes memory data) TransparentUpgradeableProxy(logic, admin, data) public {
    isUpgradeable = true;
  }

  function killUpgrade() external ifAdmin {
    require(!isUpgradeable, "LmnToken: Kill switch is already activated.");
    killUpgrade();
  }

  function _upgradeTo(address newImplementation) internal override(UpgradeableProxy) {
    require(isUpgradeable, "Upgrade feature is disabled.");
    UpgradeableProxy._upgradeTo(newImplementation);
  }

  uint256[49] private __gap;
}