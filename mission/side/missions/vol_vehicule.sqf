/*
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_flatPosition","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object","_flatPos4","_flatPos5","_flatPos6","_completeText","_failedText"];


//-------------------- FIND POSITION FOR OBJECTIVE

	_flatPosition = [[9938,18283,131],random 1000,10000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPosition = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];

		while {(count _flatPosition) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPosition = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];
		};

		if ((_flatPosition distance (getMarkerPos "respawn_west")) > 1700) then {
			_accepted = true;
		};
	};
	
	_flatPos4 = [_flatPosition, 30,0] call BIS_fnc_relPos;
	_flatPos5 = [_flatPosition, 30,120] call BIS_fnc_relPos;
	_flatPos6 = [_flatPosition, 30,240] call BIS_fnc_relPos;


	//-------------------- SPAWN OBJECTIVE

	_objDir = random 360;
	sideObj2 = "I_MRAP_03_hmg_F" createVehicle _flatPosition;
	waitUntil {alive sideObj2};
	sideObj2 setPos [(getPos sideObj2 select 0), (getPos sideObj2 select 1), (getPos sideObj2 select 2)];
	sideObj2 setVectorUp [0,0,1];
	sideObj2 setDir _objDir;
	building1 = "Land_d_Stone_Shed_V1_F" createVehicle _flatPos4;
	building2 = "Land_d_House_Small_01_V1_F" createVehicle _flatPos5;
	building3 = "Land_d_House_Small_02_V1_F" createVehicle _flatPos6;
	{ _x setDir random 360 } forEach [building1,building2,building3];	
	


//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPosition select 0) - 50) + (random 100),((_flatPosition select 1) - 50) + (random 100),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker_1", "sideCircle_1"];
	sideMarkerText = "Voler un véhicule blindé"; publicVariable "sideMarkerText";
	"sideMarker_1" setMarkerText "Voler un véhicule blindé"; publicVariable "sideMarker_1";
	publicVariable "sideObj2";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Voler un véhicule blindé</t><br/>____________________<br/>Des civils ont trouvé un blindé de la Guérilla.<br/>C'est l'occasion d'augmenter votre force, voler le véhicule et évacuez la zone.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Voler un véhicule blindé"]; publicVariable "showNotification";
	sideMarkerText = "Voler un véhicule blindé"; publicVariable "sideMarkerText";
	_null = [west, "vol_vehicule", ["Des civils ont trouvé un véhicule blindé de la Guérilla.<br/><br/>C'est l'occasion d'augmenter votre force, volez le véhicule et évacuez la zone.", "Voler le véhicule blindé", "Voler le véhicule blindé"], getMarkerPos "sideMarker_1", true] spawn BIS_fnc_taskCreate; 

//-------------------- SPAWN FORCE PROTECTION

	 null = [["sideCircle_1"],[1,1],[5,1],[0,0],[0],[2],[0,0],[7,1,1000,Resistance,TRUE]] call EOS_Spawn;	
	
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp2 = true; publicVariable "sideMissionUp2";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp2 } do {

	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]

	if (!alive sideObj2) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp2 = false; publicVariable "sideMissionUp2";
		hqSideChat = "Véhicule détruit! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		_failedText = "<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#b60000'>ECHOUEE</t><br/>____________________<br/>Vous devrez faire mieux la prochaine fois!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>";
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker_1", "sideCircle_1"]; publicVariable "sideMarker_1";
		_null = ["vol_vehicule", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["vol_vehicule"] call BIS_fnc_deleteTask; 
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];
		sleep 120;
		{ deleteVehicle _x } forEach [building1,building2,building3];
		deleteVehicle nearestObject [getPos sideObj2,"CamoNet_INDP_big_F"];
	};
	
	//--------------------------------------------- IF VEHICULE IS SAVED
	
	if ((alive sideObj2) && (sideObj2 distance getMarkerPos "respawn_west" < 50)) then
	{
		//-------------------- DE-BRIEFING

		sideMissionUp2 = false; publicVariable "sideMissionUp2";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>",_vehName];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker_1", "sideCircle_1"]; publicVariable "sideMarker_1";
		_null = ["vol_vehicule", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["vol_vehicule"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [building1,building2,building3];
		deleteVehicle nearestObject [getPos sideObj2,"Land_Unfinished_Building_02_F"];

		
	};	
};