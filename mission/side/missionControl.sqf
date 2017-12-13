/*
Author: 

	Yanoukovytsch

Last modified: 

	27102017

Description:

	Control des missions 1

To do:

	Rescue/capture/HVT missions
______________________________________________*/

private ["_mission","_missionList","_currentMission","_nextMission","_delay","_loopTimeout"];

_delay = 300 + (random 600);
_loopTimeout = 10 + (random 10);

//	"CacheMun",
//	"LABsyn",
//	"sauverjournaliste",
//	"minefield",


_missionList = [	
	
	"CacheMun",
	"LABsyn",
	"sauverjournaliste",
	"minefield"
];

SM_SWITCH = true; publicVariable "SM_SWITCH";
	
while { true } do {

	if (SM_SWITCH) then {
	
		hqSideChat = "Nouvelle Mission..."; publicVariable "hqSideChat"; [WEST,"CROSSROAD"] sideChat hqSideChat;
	
		sleep 3;
	
		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["mission\side\missions\%1.sqf", _mission];
	
		waitUntil {
			sleep 3;
			scriptDone _currentMission
		};
	
		sleep _delay;
		
		SM_SWITCH = true; publicVariable "SM_SWITCH";
	};
	sleep _loopTimeout;
};


	
