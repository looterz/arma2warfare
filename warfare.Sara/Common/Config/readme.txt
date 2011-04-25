### CORE SYSTEM GENERAL FACT:
- Most of the core are defined from Init_Common.sqf
- All units or weapons used HAVE TO be defined within Core or Core_Gear in order to be used properly.
- Duplicated items or Wrong classname are not an issue as there is a protection in the core files.
- arma2.rpt / arma2oa.rpt contains the results of the core system initialization after lauching the game.


### CORE FOLDERS
# Core: 
	Contains the Units definitions such as the label, the cost... Any new units shall be defined in this folder.

# Core_Gear:
	Contains the Loadout definitions such as the label, the cost... Any new weapons or magazine shall be defined in this folder.

# Core_Loadout:
	Contains the Loadout classname, gear menu weapons are defined there after being delcared in the "Core_Gear" folder.

# Core_Units:
	Contains the units classname, this folder is used depending on the gamemode to run (Vanilla, Arrowhead...), 
	if you want to add units in a factory, add the units classname here after declaring it in the "Core" folder.
	
# Core_Squads:
	This folder contains the AI Units Templates depending on the current running gamemode.

# Core_Resistance:
	This folder contains the AI Resistance Units templates to use depending on the current running gamemode.

# Core_Occupation:
	This folder contains the AI Occupation Units templates to use depending on the current running gamemode.