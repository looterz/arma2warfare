switch (paramGroupView) do
{
case 0:
{};
case 1:
{
	while {(true)} do
	{
		if (cameraView == "Group") then
		{
			if ((vehicle player) == player) then
			{
				player switchCamera "Internal";
			};
		};
		sleep 0.15
	};
};
case 2:
{
	while {(true)} do
	{
		if (cameraView == "Group") then
		{
			(vehicle player) switchCamera "Internal";
		};
		sleep 0.15
	};
};
};