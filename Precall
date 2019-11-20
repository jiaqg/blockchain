pragma solidity ^0.5.1;

import "./prepare.sol";

contract Precall is Prepare{

mapping (address => int) public compenst;//补偿映射
mapping (address => int) public callcap;//每个空调的调用容量
mapping (address => int) public precallPUQs;//空调实际用电权


//排序函数
  function Order() public returns (uint){
    uint down = 0;
    uint up = 0;
    for (uint i = 0; i < Nodechain.length; i++){
        if(orderpresent[Nodechain[i].Nodeadr] == 0) {
          down++;
        }
        if(orderpresent[Nodechain[i].Nodeadr] == 1) {
          up++;
        }
      }

    NodeInfo[] memory tempNodechain1 = new NodeInfo[](down);
    NodeInfo[] memory tempNodechain2 = new NodeInfo[](up);

    uint d = 0;
    uint u = 0;

    for (uint i = 0; i < Nodechain.length; i++){

        if(orderpresent[Nodechain[i].Nodeadr] == 0) {
          tempNodechain1[d] = Nodechain[i];
          d++;
        }
        if(orderpresent[Nodechain[i].Nodeadr] == 1) {
          tempNodechain2[u] = Nodechain[i];
          u++;
        }
      }

      for (uint i = 0; i < up; i++){
            Nodechain[i] = tempNodechain2[i];
          }
      for (uint i = 0; i < down; i++){
            Nodechain[i+up] = tempNodechain1[i];
              }

             return Nodechain.length;

             for (uint i = 0; i < Nodechain.length; i++ ){
               compenst[Nodechain[i].Nodeadr] = 0;
               callcap[Nodechain[i].Nodeadr] = 0;
               orderpresent[Nodechain[i].Nodeadr] = 0;//将调用信息初始化
             }
          }



//预调用函数
function Prerescall(int responsecap, int responsepri) public{

uint number = 0;
int responsecap1 = responsecap;
int responsecap2 = responsecap;

for (uint k = 0; responsecap1 >= 0; k ++){
  responsecap1 -= initialPUQs[Nodechain[k].Nodeadr];

if ((responsecap1 >= 0) && (initialPUQs[Nodechain[k].Nodeadr] != 0)){
  orderpresent[Nodechain[k].Nodeadr] = 1;//调用标识
  compenst[Nodechain[k].Nodeadr] = initialPUQs[Nodechain[k].Nodeadr] * responsepri;//完全调用的用户
  callcap[Nodechain[k].Nodeadr] = initialPUQs[Nodechain[k].Nodeadr];//完全调用的容量
}
  number ++;
}//计算完全调用用户的用电权情况

for (uint i = 0; i < number-1; i++ ){
  responsecap2 -= initialPUQs[Nodechain[i].Nodeadr];
}
orderpresent[Nodechain[number-1].Nodeadr] = 1;
compenst[Nodechain[number-1].Nodeadr] = responsecap2 * responsepri;
callcap[Nodechain[number-1].Nodeadr] = responsecap2;
//计算未完全调用用户的用电权情况

for (uint i = 0; i < Nodechain.length; i++){
precallPUQs[Nodechain[i].Nodeadr] = initialPUQs[Nodechain[i].Nodeadr] - callcap[Nodechain[i].Nodeadr];
}

}//计算预调用后的实际用电权

function Precallinfo() public view returns(int, int, int, int, int, int, int, int) {
      return (precallPUQs[Nodechain[0].Nodeadr], precallPUQs[Nodechain[1].Nodeadr], precallPUQs[Nodechain[2].Nodeadr],
      precallPUQs[Nodechain[3].Nodeadr], precallPUQs[Nodechain[4].Nodeadr], precallPUQs[Nodechain[5].Nodeadr],
      precallPUQs[Nodechain[6].Nodeadr], precallPUQs[Nodechain[7].Nodeadr]);
      //return (callcap[Nodechain[0].Nodeadr], callcap[Nodechain[1].Nodeadr], callcap[Nodechain[2].Nodeadr]);
    }//用户的预调用信息
  }
