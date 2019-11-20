pragma solidity ^0.5.1;


contract Dou {

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
