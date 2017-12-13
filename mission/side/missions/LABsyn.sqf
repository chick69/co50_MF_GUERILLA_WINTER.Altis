/*
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.

____________________________________*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object","_SMveh","_SMaa","_tower1","_tower2","_tower3","_flatPos1","_flatPos2","_flatPos3","_completeText","_failedText"];

_c4Message = ["Les charges sont posées, 15 secondes avant explosion du laboratoire!","Dégagez la zone! Les charges vont exploser dans 15 secondes!","Le laboratoire est plastiqué! 15 secondes avant mise à feu!"] call BIS_fnc_selectRandom;



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
	
	_flatPos1 = [_flatPos, 30,0] call BIS_fnc_relPos;
	_flatPos2 = [_flatPos, 30,120] call BIS_fnc_relPos;
	_flatPos3 = [_flatPos, 30,240] call BIS_fnc_relPos;

//-------------------- SPAWN OBJECTIVE

	_objDir = random 360;

	sideObj = "Land_Unfinished_Building_02_F" createVehicle _flatPos;
	waitUntil {alive sideObj};
	sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), (getPos sideObj select 2)];
	sideObj setVectorUp [0,0,1];
	sideObj setDir _objDir;
	
	_object = [indCrate1,indCrate2] call BIS_fnc_selectRandom;
	_object setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 2)];
	truck1 = "Land_d_Stone_Shed_V1_F" createVehicle _flatPos1;
	truck2 = "Land_d_House_Small_01_V1_F" createVehicle _flatPos2;
	truck3 = "Land_d_House_Small_02_V1_F" createVehicle _flatPos3;
	{ _x setDir random 360 } forEach [truck1,truck2,truck3];

	


//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 100),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Neutraliser le laboratoire"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Mission secondaire: plastiquer le laboratoire"; publicVariable "sideMarker";
	publicVariable "sideObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvel objectif secondaire</t><br/><t size='1.5' color='#00B2EE'>Neutraliser le laboratoire</t><br/>____________________<br/>Les Syndicates disposent d'un laboratoire qui leur permet de produire la drogue qu'ils écoulent sur l'Île.<br/><br/>Les satellites alliés ont détecté l'emplacement du laboratoire de drogue; plastiquer le laboratoire afin de ralentir le circuit de distribution de drogue.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Neutraliser le laboratoire"]; publicVariable "showNotification";
	sideMarkerText = "Neutraliser le laboratoire"; publicVariable "sideMarkerText";
	_null = [west, "labsyn", ["Les rebels disposent d'un laboratoire qui leur permet de produire la drogue qu'ils écoulent sur l'Île.<br/><br/>Les satellites alliés ont détecté l'emplacement du laboratoire de drogue; plastiquer le laboratoire afin de ralentir le circuit de distribution de drogue.", "Neutraliser le laboratoire", "Neutraliser le laboratoire"], getMarkerPos "SideMarker", true] spawn BIS_fnc_taskCreate;  

//-------------------- SPAWN FORCE PROTECTION

	 null = [["sideCircle"],[1,3],[5,1],[0,0],[0],[2],[0,0],[7,1,1000,Resistance,TRUE]] call EOS_Spawn;	
	
	
	

//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]

	if (!alive sideObj) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Laboratoire détruit! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		_failedText = "<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#b60000'>ECHOUEE</t><br/>____________________<br/>Vous devrez faire mieux la prochaine fois!<br/><br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>";
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["labsyn", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["labsyn"] call BIS_fnc_deleteTask; 
		
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,truck1,truck2,truck3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Unfinished_Building_02_ruins_F"];

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
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/><br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>",_vehName];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["labsyn", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["labsyn"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,truck1,truck2,truck3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Unfinished_Building_02_ruins_F"];

	};
};