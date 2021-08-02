//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract LmnTokenImplementation is Initializable, ERC20Upgradeable, OwnableUpgradeable {
  using SafeMath for uint256;

  uint256 public price;

  function initialize(string memory _name, string memory _symbol) external initializer {
    __ERC20_init((_name), symbol_);
    __Ownable_init();
    price = 1;
  }

  function setPrice(uint256 _price) external onlyOwner {
    require(_price > 0, "LmnToken: Invalid price.");
    price = _price;
  }

  function mint() external payable {
    require(msg.value > 0, "LmnToken: Not enough ETH to mint.");
    _mint(msg.sender, amount.mul(msg.value));
  }

  function burn(uint256 amount) external {
    require(amount > 0, "LmnToken: Not enough token amount to burn.");
    require(balanceOf(msg.sender), "LmnToken: Not enough balance.");
    _burn(msg.sender, amount);
    uint256 ethAmount = amount.mul(95).div(price).div(100);
    payable(msg.sender).transfer(ethAmount);
  }

  uint256[49] private __gap;
}