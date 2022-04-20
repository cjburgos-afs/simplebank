//SPDX-License-Identifier:UNLICENSED
pragma solidity >= 0.8.13;

contract SimpleBank {
    
    address public owner;
    mapping(address => bool) holders;
    mapping(address => uint) balances;

    event NewRegistration(address holder);
    event NewDepositToAddress(address account, uint amt, uint newBalance);
    event NewWithdrawalFromAddress(address account, uint amt, uint newBalance);

    modifier onlyHolder() {
        require(
            holders[msg.sender] == true,
            "Only registered addresses can call this function");
            _;
    }

    modifier notHolder() {
        require(
            holders[msg.sender] == false,
            "Only new addresses can open an account"
        );
        _;
    }
    constructor () {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(
            msg.sender == owner,
            "Caller is not owner"
        );
        _;
    }

    function register() notHolder public returns (bool) {
        holders[msg.sender] = true;
        emit NewRegistration(msg.sender);
        return holders[msg.sender];
    }

    function deposit() isOwner onlyHolder public payable {
        if(msg.value > 0){
            balances[msg.sender] += msg.value;
            emit NewDepositToAddress(msg.sender, msg.value, balances[msg.sender]);
        }

    }

    function withdraw(uint _wamt) isOwner onlyHolder public returns (uint _bal) {
        if(balances[msg.sender] >= _wamt) {
            balances[msg.sender] -= _wamt;
            payable(msg.sender).transfer(_wamt);
            emit NewWithdrawalFromAddress(msg.sender, _wamt, balances[msg.sender]);
            return balances[msg.sender];
        }
    }

    function balance() public view returns (uint) {
        return balances[msg.sender];
    }

    function bankDeposits() public view returns (uint) {
        return address(this).balance;
    }

}