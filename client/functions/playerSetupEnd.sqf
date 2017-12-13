// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupEnd.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private "_player";
_player = _this;
_name = str player;

_player addRating 1e11;
removeGoggles _player;

//if ( _name in Medics_slots) then { _player setUnitTrait ["medic",true];};
//if ( _name in Sapeurs_slots) then { _player setUnitTrait ["engineer",true];};


[objNull, _player] call mf_player_actions_refresh;
[] execVM "client\functions\playerActions.sqf";

_player groupChat "Wasteland - Initialization Complete";
playerSetupComplete = true;
