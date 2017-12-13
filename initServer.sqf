// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: initServer.sqf
//	@file Author: AgentRev

//Medics_slots = ["Medic1","Medic2","Medic3","Medic4","Medic5","Medic6","Medic7","Medic8","Medic9","Medic10"]; // List des slots Infirmiers
//publicVariable "Medics_slots";

//Sapeurs_slots = ["Ing1","Ing2","Ing3","Ing4","Ing5","Ing6","Ing7","Ing8","Ing9","Ing10"]; // List des slots Sapeurs
//publicVariable "Sapeurs_slots";

"BIS_fnc_MP_packet" addPublicVariableEventHandler compileFinal preprocessFileLineNumbers "server\antihack\filterExecAttempt.sqf";

_null = [] execVM "mission\side\missionControl.sqf";
_null = [] execVM "mission\side\missionControl_2.sqf";
