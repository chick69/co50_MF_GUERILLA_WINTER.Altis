// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: towns.sqf
//	@file Author: AgentRev, JoSchaap

private _towns =
[
	["Town_Abdera", -1, "Abdera"],
	["Town_Aggelochori", -1, "Aggelochori"],
	["Town_AgiosDyonisos", -1, "Agios Dionysos"],
	["Town_AgiosKonstantinos", -1, "Agios Konstantinos"],
	["Town_Alikampos", -1, "Alikampos"],
	["Town_Anthrakia", -1, "Anthrakia"],
	["Town_Athira", -1, "Athira"],
	["Town_Chalkeia", -1, "Chalkeia"],
	["Town_Charkia", -1, "Charkia"],
	["Town_Dorida", -1, "Dorida"],
	["Town_Frini", -1, "Frini"],
	["Town_Galati", -1, "Galati"],
	["Town_Gravia", -1, "Gravia"],
	["Town_Kalochori", -1, "Kalochori"],
	["Town_Katalaki", -1, "Katalaki"],
	["Town_Kavala_S", -1, "Kavala Sud"],
	["Town_Kore", -1, "Kore"],
	["Town_Lakka", -1, "Lakka"], 
	["Town_Molos", -1, "Molos"],
	["Town_Negades", -1, "Negades"],
	["Town_Neochori", -1, "Neochori"],
	["Town_Neri", -1, "Neri"],
	["Town_Oreokastro", -1, "Oreokastro"],
	["Town_Panagia", -1, "Panagia"],
	["Town_Panochori", -1, "Panochori"],
	["Town_Paros", -1, "Paros"],
	["Town_Poliakko", -1, "Poliakko"],
	["Town_Pyrgos", -1, "Pyrgos"],
	["Town_Rodopoli", -1, "Rodopoli"],
	["Town_Selakano", -1, "Selakano"],
	["Town_Sofia", -1, "Sofia"],
	["Town_Stavros", -1, "Stavros"],
	["Town_Syrta", -1, "Syrta"],
	["Town_Telos", -1, "Telos"],
	["Town_Therisa", -1, "Therisa"],
	["Town_Zaros", -1, "Zaros"]
];

//copyToClipboard str ((allMapMarkers select {_x select [0,5] == "Town_"}) apply {[_x, -1, markerText _x]})

private "_size";
 
{
	_x params ["_marker"];

	if (markerShape _marker == "ELLIPSE") then
	{
		_size = markerSize _marker;
		_x set [1, (_size select 0) min (_size select 1)];
	};
} forEach _towns;

_towns
