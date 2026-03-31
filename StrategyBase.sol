// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

abstract contract StrategyBase {
    address public vault;
    address public asset;

    constructor(address _vault, address _asset) {
        vault = _vault;
        asset = _asset;
    }

    modifier onlyVault() {
        require(msg.sender == vault, "Only vault");
        _;
    }

    function deposit() external virtual;
    function withdraw(uint256 _amount) external virtual;
    function harvest() external virtual;
}
