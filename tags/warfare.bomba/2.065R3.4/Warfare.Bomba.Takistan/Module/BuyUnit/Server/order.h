class Order
{
	_clientId = _order select 0;
	_building = _order select 1;
	_unitType = _order select 2; 
	_side	  = _order select 3; 
	_team     = _order select 4; 
	_vehInfo  = _order select 5;  
};

class OrderRegistered
{
	_orderId		 = _orderInfo select 0;
	_productionTime  = _orderInfo select 1;
	_order	         = _orderInfo select 2;   
}