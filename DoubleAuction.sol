pragma solidity ^0.5.1;

import "./precall.sol";

contract Doubleauction is Precall{

   struct Buyer {
    uint price;
    uint amount;
	address owner;
	}//买家

  struct Seller {
    uint price;
    uint amount;
	address owner;
	}//卖家

  struct Dealunit{
    address buyerad;
    address sellerad;
    uint clearingp;
    uint clearinga;
    uint paya;
    uint id;
  }//成交的单元

 struct B{
        uint b;
    }
 struct S{
        uint s;
    }

B[] public Bchain;
S[] public Schain;
Buyer[] public Buyerchain; //买家序列
Seller[] public Sellerchain; //卖家序列
Dealunit[] public Dealchain; //成交序列

mapping (address => int) public transPUQs;//空调交易后用电权
mapping (address => int) public trasamount; //用户的交易量映射
mapping (address => int) public trastoken; //用户的交易金额映射



 event Sent(address from , address to, uint amount); //触发交易事件


 function subBuyer(uint _price, uint _amount) public returns (uint) {
       Buyer memory b;

       b.price = _price;
       b.amount = _amount;
       b.owner = msg.sender;

       trasamount[msg.sender] = 0;
       trastoken[msg.sender] = 0;

       Buyerchain.push(b);
       return Buyerchain.length;
}// 添加买家节点

  function SortBuyer() public returns (uint){
       Buyer memory temp;
      if (Buyerchain.length == 1){
        return 1;
      }

      for(uint k = 0; k < Buyerchain.length; k++){
       for (uint j = 0; j < Buyerchain.length-1; j++){
               if(Buyerchain[j].price < Buyerchain[j+1].price){
                   temp = Buyerchain[j];
                   Buyerchain[j] = Buyerchain[j+1];
                   Buyerchain[j+1] = temp;
           }
       }
}
  return Buyerchain.length;
}// 将买家排序

function subSeller(uint _price, uint _amount) public returns (uint) {
       Seller memory s;

       s.price = _price;
       s.amount = _amount;
       s.owner = msg.sender;

       trasamount[msg.sender] = 0;
       trastoken[msg.sender] = 0;

       Sellerchain.push(s);
       return Sellerchain.length;
}// 添加卖家节点

  function sortSeller() public returns (uint){
       Seller memory temp;
       if (Sellerchain.length == 1){
         return 1;
       }

      for(uint k = 0; k < Sellerchain.length; k++){
       for (uint j = 0; j < Sellerchain.length-1; j++){
               if(Sellerchain[j].price > Sellerchain[j+1].price){
                   temp = Sellerchain[j];
                   Sellerchain[j] = Sellerchain[j+1];
                   Sellerchain[j+1] = temp;
           }
       }
}
  return Sellerchain.length;

}//将卖家排序

uint ID = 0;

function Doubleauc() public returns (uint, uint, uint){

uint b = 0;
uint s = 0;

for(; ;){

if(Sellerchain[s].price <= Buyerchain[b].price){
 uint ca = Amount(Buyerchain[b].amount, Sellerchain[s].amount);
 uint cp = (Buyerchain[b].price + Sellerchain[s].price)/2;
 uint payamount = ca * cp;

//统计交易数量
 Buyerchain[b].amount -= ca;
 Sellerchain[s].amount -= ca;

ID += 1;

//加入成交序列
Dealunit memory d;
d.buyerad = Buyerchain[b].owner;
d.sellerad = Sellerchain[s].owner;
d.clearinga = ca;
d.clearingp = cp;
d.paya = payamount;
d.id = ID;
Dealchain.push(d);

}

if (Buyerchain[b].amount == 0){
  b = b + 1;
}
if (Sellerchain[s].amount == 0){
  s = s + 1;
}
//改变卖家的序列号

if(Sellerchain[s].price > Buyerchain[b].price){
    break;
}

if (b == Buyerchain.length){
    break;
}

 if (s == Sellerchain.length){
    break;
}

}

for (uint j = 0; j < Dealchain.length; j++ ){
    trasamount[Dealchain[j].buyerad] += int(Dealchain[j].clearinga);
    trasamount[Dealchain[j].sellerad] -= int(Dealchain[j].clearinga);
    trastoken[Dealchain[j].buyerad] -= int(Dealchain[j].clearinga * Dealchain[j].clearingp);
    trastoken[Dealchain[j].sellerad] += int(Dealchain[j].clearinga * Dealchain[j].clearingp);
}

return (b,s,Dealchain.length);

}//买卖双方匹配并出清




function Amount(uint _a, uint _b) pure public returns (uint){
    if (_a < _b){
    return _a;
}
    return _b;
}

function BuyerInfo() public returns(uint, uint, uint, uint, uint){
    uint bn = 0;
    uint sumb = 0;
    B memory Ba;
    uint preb = Bchain.length;

    for (uint p = 0; p < Dealchain.length; p++){
        if (msg.sender == Dealchain[p].buyerad){
            Ba.b = Dealchain[p].id;
            Bchain.push(Ba);
            bn ++;
        }
    }

    for (uint pp = 0; pp < bn; pp ++){
        sumb += Bchain[pp].b * (10 ** pp);
    }
    if (bn == 1){
    return (Bchain[preb].b, 0, 0, 0, 0);
    }
     if (bn == 2){
    return (Bchain[preb].b, Bchain[preb+1].b, 0, 0, 0);
    }
     if (bn == 3){
    return (Bchain[preb].b, Bchain[preb+1].b, Bchain[preb+2].b, 0, 0);
    }
     if (bn == 4){
    return (Bchain[preb].b, Bchain[preb+1].b, Bchain[preb+2].b, Bchain[preb+3].b, 0);
    }
     if (bn == 5){
    return (Bchain[preb].b, Bchain[preb+1].b, Bchain[preb+2].b, Bchain[preb+3].b, Bchain[preb+4].b);
    }

}

function SellerInfo() public returns(uint, uint, uint, uint, uint){
    uint sn = 0;
    S memory Sa;
    uint pres = Schain.length;

    for (uint q = 0; q < Dealchain.length; q++){
        if (msg.sender == Dealchain[q].sellerad){
            Sa.s = Dealchain[q].id;
            Schain.push(Sa);
            sn ++;
        }
    }
     if (sn == 1){
    return (Schain[pres].s, 0, 0,0,0);
    }
     if (sn == 2){
    return (Schain[pres].s, Schain[pres+1].s, 0,0,0);
    }
     if (sn == 3){
    return (Schain[pres].s, Schain[pres+1].s, Schain[pres+2].s,0,0);
    }
    if (sn == 4){
    return (Schain[pres].s, Schain[pres+1].s, Schain[pres+2].s,Schain[pres+3].s,0);
    }
     if (sn == 5){
    return (Schain[pres].s, Schain[pres+1].s, Schain[pres+2].s,Schain[pres+3].s,Schain[pres+4].s);
    }
}



function xmatch()public returns (int, int, int){
       transPUQs[msg.sender] = precallPUQs[msg.sender] + trasamount[msg.sender];
           return (trasamount[msg.sender],trastoken[msg.sender],transPUQs[msg.sender] );
        }
function pay() public returns(uint){
     for (uint i=0; i <= Nodechain.length; i++){
         deposit[Nodechain[i].Nodeadr] +=  trastoken[Nodechain[i].Nodeadr];
}
}
}
