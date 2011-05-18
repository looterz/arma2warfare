switch (param3thView) do
{
	case 0:
	{};
	case 1:
	{
		while {(true)} do
		{
			if (cameraView == "External") then
			{
				if ((vehicle player) == player) then
				{
					player switchCamera "Internal";
				};
			};
		sleep 0.10
		};
	};
	case 2:
	{	
		while {(true)} do
		{
			if (cameraView == "External") then
			{
				(vehicle player) switchCamera "Internal";
			};
			sleep 0.10
		};
	};
}