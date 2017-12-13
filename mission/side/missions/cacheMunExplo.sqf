/*
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_flatPosition","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object","_flatPos4","_flatPos5","_flatPos6","_flatPos7","_flatPos8","_flatPos9","_completeText","_failedText","_task2"];

_c4Message = ["Les charges sont posées, 15 secondes avant explosion!","Dégagez la zone! Les charges vont exploser dans 15 secondes!","Le cachemunexplo est plastiquée! 15 secondes avant mise à feu!"] call BIS_fnc_selectRandom;



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
	
	_flatPos4 = [_flatPosition, 3,0] call BIS_fnc_relPos;
	_flatPos5 = [_flatPosition, 3,120] call BIS_fnc_relPos;
	_flatPos6 = [_flatPosition, 3,240] call BIS_fnc_relPos;
	_flatPos7 = [_flatPosition, 50,0] call BIS_fnc_relPos;
	_flatPos8 = [_flatPosition, 50,120] call BIS_fnc_relPos;
	_flatPos9 = [_flatPosition, 50,240] call BIS_fnc_relPos;
	
	
//-------------------- SPAWN OBJECTIVE

	_objDir = random 360;

	sideObj2 = "CamoNet_INDP_big_F" createVehicle _flatPosition;
	waitUntil {alive sideObj2};
	sideObj2 setPos [(getPos sideObj2 select 0), (getPos sideObj2 select 1), (getPos sideObj2 select 2)];
	sideObj2 setVectorUp [0,0,1];
	sideObj2 setDir _objDir;
	
	_object = [indCrate1,indCrate2] call BIS_fnc_selectRandom;
	_object setPos [(getPos sideObj2 select 0), (getPos sideObj2 select 1), ((getPos sideObj2 select 2) + 2)];
	
	building1 = "Box_Syndicate_Wps_F" createVehicle _flatPos4;
	building2 = "Box_Syndicate_Ammo_F" createVehicle _flatPos5;
	building3 = "Box_IED_Exp_F" createVehicle _flatPos6;
	building4 = "Land_Cargo_Patrol_V2_F" createVehicle _flatPos7;
	building5 = "Land_Cargo_Patrol_V2_F" createVehicle _flatPos8;
	building6 = "Land_Cargo_Patrol_V2_F" createVehicle _flatPos9;
	
	{ _x setDir random 360 } forEach [building1,building2,building3];
	
	


//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPosition select 0) - 50) + (random 100),((_flatPosition select 1) - 50) + (random 100),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker_1", "sideCircle_1"];
	sideMarkerText = "Neutraliser le laboratoire"; publicVariable "sideMarkerText";
	"sideMarker_1" setMarkerText "Trouver la cache de munitions"; publicVariable "sideMarker_1";
	publicVariable "sideObj2";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Trouver la cache de munitions de la Guérilla</t><br/>____________________<br/>Des civils nous ont révélé la position probable d'une cache de munitions utilisée par la Guérilla.<br/>Le meilleur moyen d'en être sûr est d'y aller; trouvez la cache, profitez-en pour faire vos courses, et plastiquez la position...</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Trouver la cache de munitions"]; publicVariable "showNotification";
	sideMarkerText = "Trouver la cache de munitions"; publicVariable "sideMarkerText";
	_null = [west, "CacheMunitions", ["Des civils ont trouvé un véhicule blindé de la Guérilla.<br/><br/>Des civils nous ont révélé la position probable d'une cache de munitions utilisée par la Guérilla.<br/>Le meilleur moyen d'en être sûr est d'y aller; trouvez la cache, profitez-en pour faire vos courses, et plastiquez la position...", "Trouver la cache de munitions", "Trouver la cache de munitions"], getMarkerPos "sideMarker_1", true] spawn BIS_fnc_taskCreate; 	
	
//-------------------- SPAWN FORCE PROTECTION

	 null = [["sideCircle_1"],[1,3],[5,1],[0,0],[0],[2],[0,0],[7,1,Resistance,EAST,TRUE]] call EOS_Spawn;	
	
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp2 = true; publicVariable "sideMissionUp2";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp2 } do {

	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]

	if (!alive sideObj2) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp2 = false; publicVariable "sideMissionUp2";
		hqSideChat = "Cache de munitions détruite! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		_failedText = "<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#b60000'>ECHOUEE</t><br/>____________________<br/>Vous devrez faire mieux la prochaine fois!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>";
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker_1", "sideCircle_1"]; publicVariable "sideMarker_1";
		_null = ["CacheMunitions", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["CacheMunitions"] call BIS_fnc_deleteTask; 
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj2,building1,building2,building3,building4,building5,building6];
		deleteVehicle nearestObject [getPos sideObj2,"CamoNet_INDP_big_F"];

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

		sideMissionUp2 = false; publicVariable "sideMissionUp2";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>",_vehName];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker_1", "sideCircle_1"]; publicVariable "sideMarker_1";
		_null = ["CacheMunitions", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["CacheMunitions"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj2,building1,building2,building3,building4,building5,building6];
		deleteVehicle nearestObject [getPos sideObj2,"CamoNet_INDP_big_F"];

	};
};