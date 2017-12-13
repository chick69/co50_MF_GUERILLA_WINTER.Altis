/*
Author:

	Yanoukovytsch
	
Last modified:

	27102017
	
Description:

	Convoi léger

____________________________________*/

private ["_flatPosition","_flatDestination","_accepted","_accepted2","_position","_position2","_enemiesArray","_fuzzyPos","_fuzzyPos2","_x","_briefing","_unitsArray","_object","_flatPos4","_flatPos5","_flatPos6","_flatPos7","_flatPos8","_flatPos9","_completeText","_failedText","_group","_veh","_units","_group2","_veh2","_group3","_veh3"];


//-------------------- Trouver la position de départ du convoi

	_flatPosition = [[9938,18283,131],random 1000,10000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPosition = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];

		while {(count _flatPosition) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPosition = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];
		};

		if ((_flatPosition distance (getMarkerPos "respawn_west")) > 500) then {
			_accepted = true;
		};
	};
	
	_flatPos4 = [_flatPosition, 30,0] call BIS_fnc_relPos;
	_flatPos5 = [_flatPosition, 30,120] call BIS_fnc_relPos;
	_flatPos6 = [_flatPosition, 30,240] call BIS_fnc_relPos;


//-------------------- SPAWN des bâtiments de base


	building1 = "Land_d_Stone_Shed_V1_F" createVehicle _flatPos4;
	building2 = "Land_d_House_Small_01_V1_F" createVehicle _flatPos5;
	building3 = "Land_d_House_Small_02_V1_F" createVehicle _flatPos6;
	{ _x setDir random 360 } forEach [building1,building2,building3];	



//-------------------- SPAWN des marqueurs départ

	_fuzzyPos = [((_flatPosition select 0) - 50) + (random 100),((_flatPosition select 1) - 50) + (random 100),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker_1", "sideCircle_1"];
	sideMarkerText1 = "Départ Convoi"; publicVariable "sideMarkerText1";
	"sideMarker_1" setMarkerText "Départ Convoi"; publicVariable "sideMarker_1";
	
	

//-------------------- Trouver la position d'arrivée du convoi

	_flatDestination = [[9938,18283,131],random 1000,10000, 1, 0, 60 * (pi / 180), 0, []] call BIS_fnc_findSafePos;
	_accepted2 = false;
	while {!_accepted2} do {
		_position2 = [] call BIS_fnc_randomPos;
		_flatDestination = _position2 isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];

		while {(count _flatDestination) < 2} do {
			_position2 = [] call BIS_fnc_randomPos;
			_flatDestination = _position2 isFlatEmpty [10,1,0.2,sizeOf "Land_Medevac_HQ_V1_F",0,false];
		};

		if ((_flatDestination distance (getMarkerPos "sideMarker_1")) > 3000) then {
			_accepted2 = true;
			_fuzzyPos2 = [((_flatDestination select 0) - 50) + (random 100),((_flatDestination select 1) - 50) + (random 100),0];
			{ _x setMarkerPos _fuzzyPos2; } forEach ["sideMarker_2", "sideCircle_2"];
			sideMarkerText2 = "Destination Convoi"; publicVariable "sideMarkerText2";
			"sideMarker_2" setMarkerText "Destination Convoi"; publicVariable "sideMarker_2";
			_null = [west, "convoi", ["Un convoi léger (pickups et transports de troupes probables) doit transporter une cargaison de munitions.<br/><br/> Les rebels n'apprécieront surement pas sa perte...", "Intercepter le convoi léger", "Intercepter le convoi léger"], getMarkerPos "SideMarker_2", true] spawn BIS_fnc_taskCreate;  
	
		};
	};
	
	_flatPos9 = [_flatDestination, 30,0] call BIS_fnc_relPos;
	_flatPos8 = [_flatDestination, 30,120] call BIS_fnc_relPos;
	_flatPos9 = [_flatDestination, 30,240] call BIS_fnc_relPos;	

	
	
//Création du convoi et du marqueur d'arrivée

_group = [getMarkerPos "sideMarker_1", East, ["O_G_engineer_F","O_G_medic_F","O_G_officer_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
_veh = "B_G_Offroad_01_armed_F" createVehicle getMarkerPos "sideMarker_1";

_group addVehicle _veh;
_units = (units _group);
(_units select 0) assignAsDriver _veh;
(_units select 0) moveInDriver _veh;

(_units select 1) assignAsGunner _veh;
(_units select 1) moveInGunner _veh;

(_units select 2) assignAsCargo _veh;
(_units select 2) moveInCargo _veh;

_group2 = [getMarkerPos "sideMarker_1", East, ["O_G_engineer_F","O_G_medic_F","O_G_officer_F","O_G_engineer_F","O_G_medic_F","O_G_officer_F","O_G_engineer_F","O_G_medic_F","O_G_officer_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
_veh2 = "O_G_Van_01_transport_F" createVehicle getMarkerPos "sideMarker_1";

_group2 addVehicle _veh2;
_units = (units _group2);

(_units select 0) assignAsDriver _veh2;
(_units select 0) moveInDriver _veh2;

(_units select 1) assignAsCargo _veh2;
(_units select 1) moveInCargo _veh2;

(_units select 2) assignAsCargo _veh2;
(_units select 2) moveInCargo _veh2;

(_units select 3) assignAsCargo _veh2;
(_units select 3) moveInCargo _veh2;

(_units select 4) assignAsCargo _veh2;
(_units select 4) moveInCargo _veh2;

(_units select 5) assignAsCargo _veh2;
(_units select 5) moveInCargo _veh2;

(_units select 6) assignAsCargo _veh2;
(_units select 6) moveInCargo _veh2;

(_units select 7) assignAsCargo _veh2;
(_units select 7) moveInCargo _veh2;

(_units select 8) assignAsCargo _veh2;
(_units select 8) moveInCargo _veh2;

(_units select 9) assignAsCargo _veh2;
(_units select 9) moveInCargo _veh2;

_group3 = [getMarkerPos "sideMarker_1", East, ["O_G_engineer_F","O_G_medic_F","O_G_officer_F","O_G_engineer_F","O_G_medic_F","O_G_officer_F","O_G_engineer_F","O_G_medic_F","O_G_officer_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
_veh3 = "O_G_Van_01_transport_F" createVehicle getMarkerPos "sideMarker_1";

_group3 addVehicle _veh3;
_units = (units _group3);

(_units select 0) assignAsDriver _veh3;
(_units select 0) moveInDriver _veh3;

(_units select 1) assignAsCargo _veh3;
(_units select 1) moveInCargo _veh3;

(_units select 2) assignAsCargo _veh3;
(_units select 2) moveInCargo _veh3;

(_units select 3) assignAsCargo _veh3;
(_units select 3) moveInCargo _veh3;

(_units select 4) assignAsCargo _veh3;
(_units select 4) moveInCargo _veh3;

(_units select 5) assignAsCargo _veh3;
(_units select 5) moveInCargo _veh3;

(_units select 6) assignAsCargo _veh3;
(_units select 6) moveInCargo _veh3;

(_units select 7) assignAsCargo _veh3;
(_units select 7) moveInCargo _veh3;

(_units select 8) assignAsCargo _veh3;
(_units select 8) moveInCargo _veh3;

(_units select 9) assignAsCargo _veh3;
(_units select 9) moveInCargo _veh3;



(units _group) join _group2;
(units _group3) join _group2;

//creates the first waypoint at position marker1

_wp2 = _group2 addWaypoint [getMarkerPos "sideMarker_2", 0];

//Sets the behaviour and speed of the units to "SAFE" and "LIMITED" and the waypointType to "MOVE"

_wp2 setWaypointBehaviour "AWARE"; 
_wp2 setWaypointSpeed "LIMITED";
_wp2 setWaypointType "MOVE";


	
	
//-------------------- SPAWN FORCE PROTECTION

	null = [["sideCircle_1"],[1,1],[5,1],[0,0],[0],[2],[0,0],[7,1,1000,Resistance,TRUE]] call EOS_Spawn;	
	null = [["sideCircle_2"],[1,1],[5,1],[0,0],[0],[2],[0,0],[7,1,1000,Resistance,TRUE]] call EOS_Spawn;
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp2 = true; publicVariable "sideMissionUp2";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp2 } do {

	//--------------------------------------------- Convoi s'est échappé, raté

	if ((alive _veh) && (_veh distance getMarkerPos "sideMarker_2" < 100)) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp2 = false; publicVariable "sideMissionUp2";
		hqSideChat = "Véhicule détruit! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		_failedText = "<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#b60000'>ECHOUEE</t><br/>____________________<br/>Vous devrez faire mieux la prochaine fois!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>";
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker_1", "sideCircle_1", "sideMarker_2", "sideCircle_2"]; publicVariable "sideMarker_1";
		_null = ["convoi", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["convoi"] call BIS_fnc_deleteTask; 
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];
		sleep 120;
		{ deleteVehicle _x } forEach [building1,building2,building3];

	};
	
	//--------------------------------------------- Convoi intercepté, succès
	
	if (({alive _x} count units _group2) < 1) then
	{
		//-------------------- DE-BRIEFING

		sideMissionUp2 = false; publicVariable "sideMissionUp2";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>",_vehName];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker_1", "sideCircle_1", "sideMarker_2", "sideCircle_2"]; publicVariable "sideMarker_1";
		_null = ["convoi", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["convoi"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [building1,building2,building3];
		

		
	};	
};