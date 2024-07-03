// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EscrowTransaction {

    struct Transaction {
        address buyer;
        address seller;
        uint256 amount;
        bool buyerDeposited;
        bool sellerDeposited;
        bool buyerReleased;
        bool sellerReleased;
        bool buyerRefunded;
        bool sellerRefunded;
    }

    address public token;
    uint256 public transactionCount;
    mapping(uint256 => Transaction) public transactions;

    event FundsDeposited(address indexed buyer, uint256 amount);
    event FundsReleased(address indexed recipient, uint256 amount);
    event FundsRefunded(address indexed recipient, uint256 amount);

    constructor(address _token) {
        require(_token != address(0), "Token address cannot be zero");
        token = _token;
        transactionCount = 0;
    }

    function createEscrow(address _seller, uint256 _amount) external {
        require(_seller != address(0), "Seller address cannot be zero");
        require(_amount > 0, "Amount must be greater than zero");

        transactionCount++;
        transactions[transactionCount] = Transaction({
            buyer: msg.sender,
            seller: _seller,
            amount: _amount,
            buyerDeposited: false,
            sellerDeposited: false,
            buyerReleased: false,
            sellerReleased: false,
            buyerRefunded: false,
            sellerRefunded: false
        });
    }

    function deposit(uint256 _transactionId) external {
        require(transactions[_transactionId].buyer == msg.sender, "Only the buyer can deposit funds");
        require(!transactions[_transactionId].buyerDeposited, "Buyer has already deposited funds");

        IERC20(token).transferFrom(msg.sender, address(this), transactions[_transactionId].amount);
        transactions[_transactionId].buyerDeposited = true;

        emit FundsDeposited(msg.sender, transactions[_transactionId].amount);
    }

    function confirmDeposit(uint256 _transactionId) external {
        require(transactions[_transactionId].seller == msg.sender, "Only the seller can confirm deposit");
        require(!transactions[_transactionId].sellerDeposited, "Seller has already confirmed deposit");

        transactions[_transactionId].sellerDeposited = true;
    }

    function release(uint256 _transactionId) external {
        require(transactions[_transactionId].seller == msg.sender, "Only the seller can release funds");
        require(transactions[_transactionId].buyerDeposited && transactions[_transactionId].sellerDeposited, "Both parties must deposit funds");

        IERC20(token).transfer(transactions[_transactionId].seller, transactions[_transactionId].amount);
        transactions[_transactionId].sellerReleased = true;

        emit FundsReleased(transactions[_transactionId].seller, transactions[_transactionId].amount);
    }

    function refund(uint256 _transactionId) external {
        require(transactions[_transactionId].buyer == msg.sender, "Only the buyer can request a refund");
        require(transactions[_transactionId].buyerDeposited && transactions[_transactionId].sellerDeposited, "Both parties must deposit funds");

        IERC20(token).transfer(transactions[_transactionId].buyer, transactions[_transactionId].amount);
        transactions[_transactionId].buyerRefunded = true;

        emit FundsRefunded(transactions[_transactionId].buyer, transactions[_transactionId].amount);
    }
}
