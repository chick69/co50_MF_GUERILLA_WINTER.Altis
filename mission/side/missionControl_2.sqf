/*
Author: 

	Yanoukovytsch

Last modified: 

	27102017

Description:

	Controle des secondes missions

To do:

	
______________________________________________*/

private ["_mission2","_missionList2","_currentMission2","_nextMission","_delay2","_loopTimeout2"];

_delay2 = 300 + (random 600);
_loopTimeout2 = 10 + (random 10);


//	"CacheMunExplo",
//	"convoi",
//	"convoi_lourd",
//	"vol_vehicule",
//  "cache_drone"

_missionList2 = [	
	
	"CacheMunExplo",
	"convoi",
	"convoi_lourd",
	"vol_vehicule",
	"cache_drone"
];

SM_SWITCH2 = true; publicVariable "SM_SWITCH2";
	
while { true } do {

	if (SM_SWITCH2) then {
	
		hqSideChat2 = "Nouvelle Mission..."; publicVariable "hqSideChat2"; [WEST,"CROSSROAD"] sideChat hqSideChat2;
	
		sleep 3;
	
		_mission2 = _missionList2 call BIS_fnc_selectRandom;
		_currentMission2 = execVM format ["mission\side\missions\%1.sqf", _mission2];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission2
		};
	
		sleep _delay2;
		
		SM_SWITCH2 = true; publicVariable "SM_SWITCH2";
	};
	sleep _loopTimeout2;
};


	
