pragma solidity ^0.5.1;

import "./ownable.sol";

contract Prepare is Ownable{

mapping (address => int) public deposit;
mapping (address => uint) public balance;
mapping (address => int) public orderpresent;//空调调用标志
mapping (address => int) public initialPUQs;//实际所持用电权


//空调节点数据结构体
struct NodeInfo {
  int Power;
  address Nodeadr;
}

NodeInfo[] public Nodechain;

//加入提交初始用电权，交纳保证金
  function Deposit(int _Power) public returns (bool){
    NodeInfo memory n;
    n.Power = _Power;
    n.Nodeadr = msg.sender;

    balance[msg.sender] += uint(_Power * 1000);
    deposit[msg.sender] = _Power * 1000;
    orderpresent[msg.sender] = 0;

    Nodechain.push(n);
    return true;
  }
//提交初始用电权
function InitialPUQs(int _PUQs) public returns (bool){

    initialPUQs[msg.sender] = _PUQs;
    return true;
  }


          //显示余额
function balanceAmount() public view returns(uint) {
     return balance[msg.sender];
    }


}
