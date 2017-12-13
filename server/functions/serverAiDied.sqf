// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2017 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: serverAiDied.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

params ["_unit", "_killer", "_instigator","_money","_m"];

private _presumedKiller = effectiveCommander _killer;
private _killerVehicle = vehicle _killer;

if ((floor random 100) > 70) then {
	_m = createVehicle ["Land_Money_F", [_unit, [0,2,0]] call relativePos, [], 0, "CAN_COLLIDE"];
	_m setDir random 360;
	_money = floor random 200;
	_m setVariable ["cmoney", _money, true];
	_m setVariable ["owner", "world", true];
	_m call A3W_fnc_setItemCleanup;
};
if ((floor random 100) > 90) then {
	_m = createVehicle ["Land_Can_V3_F", [_unit, [0,2,0]] call relativePos, [], 0, "CAN_COLLIDE"];
	_m setDir random 360;
	_m setVariable["mf_item_id", "energydrink", true];
	_m call A3W_fnc_setItemCleanup;
};

if ((floor random 100) > 80) then {
	_m = createVehicle ["Land_BakedBeans_F", [_unit, [0,2,0]] call relativePos, [], 0, "CAN_COLLIDE"];
	_m setDir random 360;
	_m setVariable["mf_item_id", "cannedfood", true];
	_m call A3W_fnc_setItemCleanup;
};

if ((floor random 100) > 80) then {
	_m = createVehicle ["Land_BottlePlastic_V2_F", [_unit, [0,2,0]] call relativePos, [], 0, "CAN_COLLIDE"];
	_m setDir random 360;
	_m setVariable["mf_item_id", "water", true];
	_m call A3W_fnc_setItemCleanup;
};

if (!isNull _instigator) then
{
	_killer = _instigator;
};

if (isUavConnected _killerVehicle) then
{
	private _uavOwner = (uavControl _killerVehicle) select 0;

	if (!isNull _uavOwner) then
	{
		_killer = _uavOwner;
	};
};

[_unit, _killer, _presumedKiller] call A3W_fnc_serverPlayerDied;
