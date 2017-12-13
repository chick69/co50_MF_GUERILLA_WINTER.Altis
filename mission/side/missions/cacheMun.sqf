/*
Author:

	Yanoukovytsch
	
Last modified:

	27102017
	
Description:

	Trouver et détruire la cache de munitions 

____________________________________*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object","_SMveh","_SMaa","_tower1","_tower2","_tower3","_flatPos1","_flatPos2","_flatPos3","_completeText","_failedText"];

_c4Message = ["Les charges sont posées, 15 secondes avant explosion!","Dégagez la zone! Les charges vont exploser dans 15 secondes!","Le Cache est plastiquée! 15 secondes avant mise à feu!"] call BIS_fnc_selectRandom;



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
	
	_flatPos1 = [_flatPos, 3,0] call BIS_fnc_relPos;
	_flatPos2 = [_flatPos, 3,120] call BIS_fnc_relPos;
	_flatPos3 = [_flatPos, 3,240] call BIS_fnc_relPos;

//-------------------- SPAWN OBJECTIVE

	_objDir = random 360;

	sideObj = "CamoNet_INDP_big_F" createVehicle _flatPos;
	waitUntil {alive sideObj};
	sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), (getPos sideObj select 2)];
	sideObj setVectorUp [0,0,1];
	sideObj setDir _objDir;
	
	_object = [indCrate1,indCrate2] call BIS_fnc_selectRandom;
	_object setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 2)];
	
	truck1 = "Box_Syndicate_Wps_F" createVehicle _flatPos1;
	truck2 = "Box_Syndicate_Ammo_F" createVehicle _flatPos2;
	truck3 = "Box_East_Wps_F" createVehicle _flatPos3;
	
	{ _x setDir random 360 } forEach [truck1,truck2,truck3];
	
	


//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 100),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Neutraliser le laboratoire"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Trouver la cache d'armes"; publicVariable "sideMarker";
	publicVariable "sideObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Trouver la cache de munitions de la Guérilla</t><br/>____________________<br/>Des civils nous ont révélé la position probable d'une cache de munitions utilisée par la Guérilla.<br/>Le meilleur moyen d'en être sûr est d'y aller; trouvez la cache, profitez-en pour faire vos courses, et plastiquez la position...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Trouver la cache d'armes"]; publicVariable "showNotification";
	sideMarkerText = "Trouver la cache d'armes"; publicVariable "sideMarkerText";
	_null = [west, "cache", ["Des civils nous ont révélé la position probable d'une cache de munitions utilisée par la Guérilla.<br/>Le meilleur moyen d'en être sûr est d'y aller; trouvez la cache, profitez-en pour faire vos courses, et plastiquez la position...", "Trouver la cache d'armes", "Trouver la cache d'armes"], getMarkerPos "SideMarker", true] spawn BIS_fnc_taskCreate; 

//-------------------- SPAWN FORCE PROTECTION

	 null = [["sideCircle"],[1,1],[5,1],[0,0],[0],[2],[0,0],[7,1,1000,Resistance,TRUE]] call EOS_Spawn;	
	
	
	

//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]

	if (!alive sideObj) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Laboratoire détruit! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		_failedText = "<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#b60000'>ECHOUEE</t><br/>____________________<br/>Vous devrez faire mieux la prochaine fois!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>";
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["cache", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["cache"] call BIS_fnc_deleteTask; 
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,truck1,truck2,truck3];
		deleteVehicle nearestObject [getPos sideObj,"CamoNet_INDP_big_F"];

	};
	
	//--------------------------------------------- IF PACKAGE DESTROYED [SUCCESS]
	
	if (SM_SUCCESS) exitWith {
		
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
		//-------------------- BOOM!
	
		sleep 12;											
		"Bo_Mk82" createVehicle getPos _object; 			
		sleep 0.1;
		_object setPos [-10000,-10000,0];
	
		//-------------------- DE-BRIEFING

		sideMissionUp = false; publicVariable "sideMissionUp";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>",_vehName];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["cache", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["cache"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj];
		deleteVehicle nearestObject [getPos sideObj,"CamoNet_INDP_big_F"];

	};
};