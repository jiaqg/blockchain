pragma solidity ^0.5.1;

import "./doubleauction.sol";

contract Check is Doubleauction{

  mapping (address => int) realP;//实际负荷映射
  mapping (address => uint) usertype;//用户行为映射

  function RealtimeP (int _actualP) public{
    address m = msg.sender;
    realP[m] = _actualP;
  }
  function Checkfun() public {
    for (uint i=0; i <= Nodechain.length; i++){
      if (transPUQs[Nodechain[i].Nodeadr] < realP[Nodechain[i].Nodeadr]){
        usertype[Nodechain[i].Nodeadr] = 1;
      }
      if(transPUQs[Nodechain[i].Nodeadr] >= realP[Nodechain[i].Nodeadr]){
        usertype[Nodechain[i].Nodeadr] = 0;
      }
    }
  }

  function Clear() public {
    for(uint j=0; j <= Nodechain.length; j++){
      if (usertype[Nodechain[j].Nodeadr] == 0){
          balance[Nodechain[j].Nodeadr] += uint(compenst[Nodechain[j].Nodeadr]);
          balance[Nodechain[j].Nodeadr] += uint(deposit[Nodechain[j].Nodeadr]);
        }
      }
    }
  }
