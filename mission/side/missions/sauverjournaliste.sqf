/*
Author:

	Yanou
	
Last modified:

	15/10/2017
	
Description:

	Libérer le journaliste.

*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_SMveh","_SMaa","_tower1","_tower2","_tower3","_flatPos1","_flatPos2","_flatPos3","_completeText","_failedText","_journaliste","_briefing","_smPos"];

#define OBJUNIT_TYPES_INTEL "B_Survivor_F"


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
	truck1 = "Land_d_Stone_Shed_V1_F" createVehicle _flatPos1;
	truck2 = "Land_d_House_Small_01_V1_F" createVehicle _flatPos2;
	truck3 = "Land_d_House_Small_02_V1_F" createVehicle _flatPos3;
	
	{ _x setDir random 360 } forEach [truck1,truck2,truck3];
	


//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 50) + (random 100),((_flatPos select 1) - 50) + (random 100),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Libérer et escorter le journaliste"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Mission secondaire: Libérer et escorter le journaliste"; publicVariable "sideMarker";
	publicVariable "sideObj";
	_briefing = "<t align='center'><t size='2.2'>Nouvelle Mission</t><br/><t size='1.5' color='#00B2EE'>Libérer le journaliste</t><br/>____________________<br/>Un journaliste d'une gande chaîne télévisée a été prise en otage.<br/><br/> Les rebels le retiennenent et préparent son éxecution. Retrouvez le et escorter le à plus de 50 mètres du lieu de la prise d'otage.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["Nouvelle Mission", "Libérer le journaliste"]; publicVariable "showNotification";
	_null = [west, "journaliste", ["Un journaliste d'une gande chaîne télévisée a été prise en otage.<br/><br/> Les rebels le retiennenent et préparent son éxecution. Retrouvez le et escorter le à plus de 50 mètres du lieu de la prise d'otage.", "Libérer le journaliste", "Libérer le journaliste"], getMarkerPos "SideMarker", true] spawn BIS_fnc_taskCreate;  

//-------------------- SPAWN FORCE PROTECTION

	 null = [["sideCircle"],[1,3],[5,1],[0,0],[0],[2],[0,0],[7,1,1000,Resistance,TRUE]] call EOS_Spawn;	
	
	
//-------------------- SPAWN OBJECTIVE (okay okay, setPos not spawn/create)

	
	_smPos = getMarkerPos "sideMarker";
	sleep 1;
	_surrenderGroup = createGroup civilian;
	[OBJUNIT_TYPES_INTEL] call BIS_fnc_selectRandom createUnit [_smPos, _surrenderGroup];

	//--------- INTEL OBJ

	sleep 0.3;
	
	_journaliste = ((units _surrenderGroup) select 0);
	removeAllWeapons _journaliste;
	removeAllItems _journaliste;
	removeAllAssignedItems _journaliste;
	removeUniform _journaliste;
	removeVest _journaliste;
	removeBackpack _journaliste;
	removeHeadgear _journaliste;
	removeGoggles _journaliste;
	_journaliste forceAddUniform "U_C_Journalist";
	_journaliste addHeadgear "H_Cap_press";
	0 = [_journaliste,"Otage"] execVM "scripts\sush_pow_script.sqf";
	_journaliste setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 2)];

//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

	//FAIL SIDE

	if (!alive _journaliste) exitWith {
	
		sleep 0.3;
		
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Le journaliste a été tué! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		_failedText = "<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#b60000'>ECHOUEE</t><br/>____________________<br/>Vous devrez faire mieux la prochaine fois!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>";
		GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["journaliste", "FAILED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["journaliste"] call BIS_fnc_deleteTask; 
		
		
		//-------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,truck1,truck2,truck3,_journaliste];
		deleteVehicle nearestObject [getPos sideObj,"Land_Unfinished_Building_02_F"];

		
	};	
		
		
		
		
	
	//SUCESS SIDE

	if ((alive _journaliste) && (_journaliste distance getMarkerPos "sideMarker" > 50)) then
	{
		//-------------------- DE-BRIEFING

		sideMissionUp = false; publicVariable "sideMissionUp";
		_completeText = format["<t align='center'><t size='2.2'>Mission</t><br/><t size='1.5' color='#08b000'>REUSSIE</t><br/>____________________<br/>Beau travail!<br/>Continuez votre progression sur l'île en attendant d'autres objectifs...</t>",_vehName];
		GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
		showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		_null = ["journaliste", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		sleep 5;
		["journaliste"] call BIS_fnc_deleteTask; 
	
		//--------------------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,truck1,truck2,truck3,_journaliste];
		deleteVehicle nearestObject [getPos sideObj,"Land_Unfinished_Building_02_F"];

		
	};	
		
};