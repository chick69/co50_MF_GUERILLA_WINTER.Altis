//Spawn loot
//Author: BangaBob(H8ermaker) edited by Gigatek
//@file Name: spawnLoot.sqf

if(isServer) then
{
	_pos= (_this select 0);
	_pos0= (_pos select 0);
	_pos1= (_pos select 1);
	_pos2= (_pos select 2);
	_showLoot= (_this select 1);

	_BARREL= createVehicle ["Land_BarrelEmpty_F",[_pos0,_pos1,_pos2+0.3], [], 0, "can_Collide"];
	sleep 1;
	_tmppos = getposATL _BARREL;
	_holder= createVehicle ["groundweaponholder",[_pos0,_pos1,(getposATL _BARREL select 2)], [], 0, "can_Collide"];
	deletevehicle _BARREL;
	_type= floor (random 5);
	_holder setVariable ["persistent", true, true];
	_holder enableDynamicSimulation true;


// Spawn Weapon
	if (_type == 0) then
	{
		_weapon= weaponsLoot call bis_fnc_selectRandom; 
		_magazines= getArray (configFile / "CfgWeapons" / _weapon / "magazines");
		_magazineClass= _magazines call bis_fnc_selectRandom; 
		_holder addWeaponCargoGlobal [_weapon, 1];
		_holder addMagazineCargoGlobal [_magazineClass, 1];
		if (_showLoot) then
		{
			_id=format ["%1",_pos];
			_debug=createMarker [_id,GETPOS _holder];
			_debug setMarkerShape "ICON";
			_debug setMarkerType "hd_dot";
			_debug setMarkerColor "ColorRed";
			_txt=format ["%1-%2",_type,"W"];
			_debug setMarkerText _txt;
		};
	};

// Spawn Magazines
	if (_type == 1) then
	{
		_mags= magazineLoot call bis_fnc_selectRandom;
		_holder addMagazineCargoGlobal [_mags, 1];
		if (_showLoot) then
		{
			_id=format ["%1",_pos];
			_debug=createMarker [_id,GETPOS _holder];
			_debug setMarkerShape "ICON";
			_debug setMarkerType "hd_dot";
			_debug setMarkerColor "ColorRed";
			_txt=format ["%1-%2",_type,"M"];
			_debug setMarkerText _txt;
		};
	};

// Spawn Items
	if (_type == 2) then
	{
		_item= itemsLoot call bis_fnc_selectRandom;
		_holder addItemCargoGlobal [_item, 1];
		_clothing= clothesLoot call bis_fnc_selectRandom;
		_holder addItemCargoGlobal [_clothing, 1];
		if (_showLoot) then
		{
			_id=format ["%1",_pos];
			_debug=createMarker [_id,GETPOS _holder];
			_debug setMarkerShape "ICON";
			_debug setMarkerType "hd_dot";
			_debug setMarkerColor "ColorRed";
			_txt=format ["%1-%2",_type,"I"];
			_debug setMarkerText _txt;
		};
	};

// Spawn Survival
/* ---------------------------
	if (_type == 3) then
	{
		_loot= SurvivalLoot call bis_fnc_selectRandom;
		if (_loot == "Land_Can_V3_F"  || _loot == "Land_BakedBeans_F" || _loot == "Land_BottlePlastic_V2_F") then
		{
			_lootholder = createVehicle [_loot, _tmpPos, [], 0, "CAN_COLLIDE"];
			_lootholder setPosATL _tmpPos;
			if(_loot == "Land_Can_V3_F") then {
				_lootholder setVariable["mf_item_id", "energydrink", true];
			};
			if(_loot == "Land_BakedBeans_F") then {
				_lootholder setVariable["mf_item_id", "cannedfood", true];
			};
			if(_loot == "Land_BottlePlastic_V2_F") then {
				_lootholder setVariable["mf_item_id", "water", true];
			};
			_lootholder setVariable ["Lootready", diag_tickTime];

		} else {
			_holder addItemCargoGlobal [_loot, 1];
		};
		if (_showLoot) then
		{
			_id=format ["%1",_pos];
			_debug=createMarker [_id,GETPOS _holder];
			_debug setMarkerShape "ICON";
			_debug setMarkerType "hd_dot";
			_debug setMarkerColor "ColorRed";
			_txt=format ["%1-%2",_type,"S"];
			_debug setMarkerText _txt;
		};
	};
	
---------------------------------------- */	

// Spawn RepairLoot
	if (_type == 4) then
	{
		_loot= RepairLoot call bis_fnc_selectRandom;
		_lootholder = createVehicle [_loot, _tmpPos, [], 0, "CAN_COLLIDE"];
		_lootholder setPosATL _tmpPos;
		if(_loot == "Land_CanisterFuel_F") then {
			_chfullf = (random 100);
			if (_chfullfuel > _chfullf) then {
				_lootholder setVariable["mf_item_id", "jerrycanfull", true];
			} else {
				_lootholder setVariable["mf_item_id", "jerrycanempty", true];
			};
		};
		if(_loot == "Land_CanisterOil_F") then {
			_lootholder setVariable["mf_item_id", "syphonhose", true];
		};
		if(_loot == "Land_Suitcase_F") then {
			_lootholder setVariable["mf_item_id", "repairkit", true];
		};
		_lootholder setVariable ["Lootready", diag_tickTime];
		if (_showLoot) then
		{
			_id=format ["%1",_pos];
			_debug=createMarker [_id,GETPOS _holder];
			_debug setMarkerShape "ICON";
			_debug setMarkerType "hd_dot";
			_debug setMarkerColor "ColorRed";
			_txt=format ["%1-%2",_type,"R"];
			_debug setMarkerText _txt;
		};
	};
};