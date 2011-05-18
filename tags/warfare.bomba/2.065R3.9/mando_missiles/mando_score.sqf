// Air 5, Car 2, Tank 3, Boat 3, Static 3


// Code that is executed by missile warhead scripts to add score to players firing missiles.
Sleep 4;
_var = false;
if ((damage _target > 0.9) || (isNull _target)) then
{
   if (!isNull _target) then
   {
      _var = _target getVariable "mando_kill_scored";
   };


   if ((isNil "_var") || (isNull _target)) then
   {

      if (!isNull _target) then
      {
         [_target] spawn
         {
            Sleep 5;
            (_this select 0) setVariable ["mando_kill_scored", true, true];
         };
      };


      if (typeName _cost == "SCALAR") then
      {
         _rating = 100 + _cost / 1000;
      }
      else
      {
         _rating = 100;
      };

      if (_classtarget isKindOf "Air") then
      {
         _score = 5;
      }
      else
      {
         if (_classtarget isKindOf "Car") then
         {
            _score = 2;
         }
         else
         {
            if (_classtarget isKindOf "Tank") then
            {
               _score = 3;
            }
            else
            {
               if (_classtarget isKindOf "Boat") then
               {
                  _score = 3;
               }
               else
               {
                  if (_classtarget isKindOf "BigShip") then
                  {
                     _score = 25;
                  }
                  else
                  {
                     if (_classtarget isKindOf "SmallShip") then
                     {
                        _score = 15;
                     }
                     else
                     {         
                        if (_classtarget isKindOf "Ship") then
                        {
                           _score = 10;
                        }
                        else
                        {
                           if (_classtarget isKindOf "Static") then
                           {
                              _score = 3;
                           }
                           else
                           {
                              _score = 1;
                           };
                        };
                     };
                  };
               };
            };
         };
      };

      if (({!alive _x} count _crewt) > 0) then
      {
         _score = _score + ({!alive _x} count _crewt);
      };

  
      if (_side == (side _launcher)) then
      {
         _rating = -_rating;
         _score = -_score;
      };

      _crew = crew _launcher;

      for [{_i=0},{_i < (count _crew)},{_i=_i+1}] do
      {
         _unit = _crew select _i;
         if (alive _unit) then
         {
            if (isPlayer _unit) then 
            {
               if (isServer) then
               {
                  _unit addScore _score;
               };
            };
  
            if ((local _unit) && (isPlayer _unit)) then
            {
              _unit addRating _rating;
            };
         };
      };
   };
};