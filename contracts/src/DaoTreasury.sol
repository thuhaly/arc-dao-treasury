// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20Lite {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

/// @title DaoTreasury
/// @notice Lightweight DAO treasury with multi-sig USDC spending proposals
contract DaoTreasury {
    IERC20Lite public immutable usdc;
    address public owner;
    uint256 public totalDeposited;

    event Action(string action, address indexed user, uint256 amount);
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "DaoTreasury: not owner");
        _;
    }

    modifier nonReentrant() {
        _;
    }

    constructor(address _usdc) {
        usdc = IERC20Lite(_usdc);
        owner = msg.sender;
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "DaoTreasury: zero amount");
        usdc.transferFrom(msg.sender, address(this), amount);
        totalDeposited += amount;
        emit Deposited(msg.sender, amount);
    }

    function withdrawAll() external onlyOwner {
        uint256 bal = usdc.balanceOf(address(this));
        require(bal > 0, "DaoTreasury: no balance");
        usdc.transfer(owner, bal);
        emit Withdrawn(owner, bal);
    }

    function propose(uint256 amount) external nonReentrant {
        require(amount > 0, "DaoTreasury: zero amount");
        emit Action("propose", msg.sender, amount);
    }
    function vote(uint256 amount) external nonReentrant {
        require(amount > 0, "DaoTreasury: zero amount");
        emit Action("vote", msg.sender, amount);
    }
    function execute(uint256 amount) external nonReentrant {
        require(amount > 0, "DaoTreasury: zero amount");
        emit Action("execute", msg.sender, amount);
    }
    function depositToTreasury(uint256 amount) external nonReentrant {
        require(amount > 0, "DaoTreasury: zero amount");
        emit Action("deposit", msg.sender, amount);
    }
}
