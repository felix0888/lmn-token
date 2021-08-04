//SPDX-License-Identifier: Unlicense
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract LmnTokenImplementation is Initializable, ERC20Upgradeable, OwnableUpgradeable {
  using SafeMath for uint256;

  uint256 public price;

  function initialize(string calldata _name, string calldata _symbol) external initializer {
    __ERC20_init((_name), _symbol);
    __Ownable_init();
    price = 1;
  }

  function setPrice(uint256 _price) external onlyOwner {
    require(_price > 0, "LmnToken: Invalid price.");
    price = _price;
  }

  function mint() external payable {
    require(msg.value > 0, "LmnToken: Not enough ETH to mint.");
    _mint(msg.sender, price.mul(msg.value));
  }

  function burn(uint256 amount) external {
    require(amount > 0, "LmnToken: Not enough token amount to burn.");
    require(balanceOf(msg.sender) > 0, "LmnToken: Not enough balance.");
    _burn(msg.sender, amount);
    uint256 ethAmount = amount.mul(90).div(100).div(price);
    payable(msg.sender).transfer(ethAmount);
  }

  uint256[49] private __gap;
}