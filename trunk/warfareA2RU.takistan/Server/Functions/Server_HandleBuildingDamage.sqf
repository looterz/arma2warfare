Private ["_difference"];

if ((typeOf (_this select 0)) in ('WFBE_EASTSTRUCTURENAMES' Call GetNamespace)) then 
{
	if ((typeOf (_this select 0)) in ('WFBE_EASTSTRUCTURENAMES2' Call GetNamespace)) then 
	{
	_difference = ((_this select 1) - (getDammage (_this select 0)))/(('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)*1.25)//; player sideChat "damage +25 per cent"
	} else	{	
		if ((typeOf (_this select 0)) in ('WFBE_EASTSTRUCTURENAMES3' Call GetNamespace)) then
		{
		_difference = ((_this select 1) - (getDammage (_this select 0)))/(('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)*1.45)//; player sideChat "damage +45 per cent"
		}  else
			{	
			if ((typeOf (_this select 0)) in ('WFBE_EASTSTRUCTURENAMES4' Call GetNamespace)) then
				{
				_difference = ((_this select 1) - (getDammage (_this select 0)))/(('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)*2)//; player sideChat "damage +100 per cent"
				}  else	
				{
				_difference = ((_this select 1) - (getDammage (_this select 0)))/(('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)*0.8)//; player sideChat "damage -20 per cent"
				};
			};
		};		
}else {
if ((typeOf (_this select 0)) in ('WFBE_WESTSTRUCTURENAMES' Call GetNamespace)) then 
{
	if ((typeOf (_this select 0)) in ('WFBE_WESTSTRUCTURENAMES2' Call GetNamespace)) then 
	{
	_difference = ((_this select 1) - (getDammage (_this select 0)))/('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)//; player sideChat "damage default"
	} else	{	
		if ((typeOf (_this select 0)) in ('WFBE_WESTSTRUCTURENAMES3' Call GetNamespace)) then
			{
			_difference = ((_this select 1) - (getDammage (_this select 0)))/(('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)*1.45)//; player sideChat "damage +45 per cent"
			}  else
			{	
				if ((typeOf (_this select 0)) in ('WFBE_WESTSTRUCTURENAMES4' Call GetNamespace)) then
				{
				_difference = ((_this select 1) - (getDammage (_this select 0)))/(('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)*2)//; player sideChat "damage +100 per cent"
				}  else	
				{
				_difference = ((_this select 1) - (getDammage (_this select 0)))/(('WFBE_BUILDINGDAMAGEREDUCTION' Call GetNamespace)*0.8)//; player sideChat "damage -20 per cent"
				};
			};
		};
};
};
((getDammage (_this select 0))+_difference)	


