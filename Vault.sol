// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Vault is ERC20, Ownable, ReentrancyGuard {
    IERC20 public immutable asset;
    address public strategy;

    constructor(address _asset, string memory _name, string memory _symbol) 
        ERC20(_name, _symbol) 
        Ownable(msg.sender) 
    {
        asset = IERC20(_asset);
    }

    function setStrategy(address _strategy) external onlyOwner {
        strategy = _strategy;
    }

    function deposit(uint256 _amount) external nonReentrant {
        uint256 shares = totalSupply() == 0 ? _amount : (_amount * totalSupply()) / totalAssets();
        asset.transferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, shares);
        
        // Push funds to strategy
        if (strategy != address(0)) {
            asset.transfer(strategy, _amount);
        }
    }

    function withdraw(uint256 _shares) external nonReentrant {
        uint256 amount = (_shares * totalAssets()) / totalSupply();
        _burn(msg.sender, _shares);
        
        // Pull funds from strategy if needed
        asset.transfer(msg.sender, amount);
    }

    function totalAssets() public view returns (uint256) {
        uint256 vaultBalance = asset.balanceOf(address(this));
        // Logic to include strategy balance would go here
        return vaultBalance; 
    }
}
