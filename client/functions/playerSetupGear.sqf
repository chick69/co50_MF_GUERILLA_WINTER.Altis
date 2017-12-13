// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_headgear", "_goggles"];
_player = _this;

_player forceAddUniform "U_I_G_resistanceLeader_F";
_player addItemToUniform "FirstAidKit";
_player addWeapon "hgun_ACPC2_F";
_player addMagazine "9Rnd_45ACP_Mag";
_player addMagazine "9Rnd_45ACP_Mag";
_player selectWeapon "hgun_ACPC2_F";

if (_player == player) then
{
	thirstLevel = 100;
	hungerLevel = 100;
};

