
pragma solidity 0.7.4;
pragma experimental ABIEncoderV2; // to return the array of struct

contract Wallet {
	address [] public approvers;
	uint public quorum;
	struct Transfer {
		uint id;
		uint amount;
		address payable to;
		uint approvals; // number of approval received
		bool sent; // boolean to know if this transfer have been sent already
	}

	Transfer [] public transfers;   // an array of struct named transfers
	mapping (address => mapping(uint => bool)) public approvals;
	// mapping of who approved what

	constructor(address [] memory _approvers, uint _quorum) {
		approvers = _approvers;
		quorum = _quorum;
	}

	function getApprovers() external view returns (address [] memory) {
		return approvers; // getter function of solidity returns a single element
	}

	function getTransfers() external view returns (Transfer[] memory) {
		return transfers; // getter function of solidity returns a single element
	}

	function createTransfer (uint amount, address payable to)  external onlyApprover (){
		transfers.push(Transfer(
			transfers.length,
			amount,
			to,
			0,
			false
		));
	}

