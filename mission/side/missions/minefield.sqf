/*
Author:

	Yanou
	
Last modified:

	15/10/2017
	
Description:

	Déminez.

*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_SMveh","_SMaa","_tower1","_tower2","_tower3","_flatPos1","_flatPos2","_flatPos3","_flatPos4","_flatPos5","_flatPos6","_flatPos7","_flatPos8","_flatPos9","_completeText","_failedText","_journaliste","_briefing","_smPos"];




//-------------------- FIND POSITION FOR OBJECTIVE

	_flatPos = [[9938,18283,131],random 1000,10000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];
		};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700) then {
			_accepted = true;
		};
	};
	


//-------------------- SPAWN OBJECTIVE

	_objDir = random 360;
	sideObj = "Box_IND_AmmoVeh_F" createVehicle _flatPos;
	waitUntil {alive sideObj};
	sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), (getPos sideObj select 2)];
	sideObj setVectorUp [0,0,1];
	sideObj setDir _objDir;




//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 1) + (random 1),((_flatPos select 1) - 1) + (random 1),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker"];
	sideMarkerText = "Déminer la zone"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Mission : Déminer la zone"; publicVariable "sideMarker";
	any =  [   [    ["Nouvelle Mission","align = 'center' size = '0.9' font='PuristaBold'","#ff0000"]  ]  ]  spawn BIS_fnc_typeText2;
	showNotification = ["Nouvelle Mission", "Déminer la zone"]; publicVariable "showNotification";
	null = ["sideMarker",50,"APERSBoundingMine",50,false,false] execVM "AL_mines\alias_mines.sqf";
	null = ["sideMarker",10,"APERSBoundingMine",30,false,false] execVM "AL_mines\alias_mines.sqf";
	_null = [west, "minefield", ["Plusieurs explosions ont été entendues par les civils dans les alentours; plusieurs civils ont également disparu soudainement dans le secteur...<br/><br/>Rendez-vous sur zone pour voir ce qu'il s'y passe...", "Déminer la zone", "Déminer la zone"], getMarkerPos "SideMarker", true] spawn BIS_fnc_taskCreate;  
	

//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

	//FAIL SIDE

	if (!alive sideobj) exitWith {
	
		sleep 0.3;
		
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Le journaliste a été tué! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		any =  [   [    ["Mission echouée","align = 'center' size = '0.9' font='PuristaBold'","#00ff00"]  ]  ]  spawn BIS_fnc_typeText2;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["minefield", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["minefield"] call BIS_fnc_deleteTask; 
		
		//-------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj];
		
	};	
		
	
	//SUCESS SIDE

	if ((player distance getPos sideObj < 3)) then
	{
		//-------------------- DE-BRIEFING

		sideMissionUp = false; publicVariable "sideMissionUp";
		any =  [   [    ["Mission Accomplie","align = 'center' size = '0.9' font='PuristaBold'","#ff0000"]  ]  ]  spawn BIS_fnc_typeText2;
		showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
		[] spawn QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["minefield", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["minefield"] call BIS_fnc_deleteTask; 

	};	
		
};