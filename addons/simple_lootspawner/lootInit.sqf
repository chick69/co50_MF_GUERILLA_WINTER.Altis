//Loot initialize
//Author: BangaBob(H8ermaker) edited by Gigatek
//@file Name: lootInit.sqf

if(isServer)then
{
// Set probability of loot spawning 1-100%
_probability= 10;

// Show loot position and type on map (Debugging)
_showLoot= false;

// Set Weapon loot: Primary weapons, secondary weapons, Sidearms.
weaponsLoot= ["hgun_ACPC2_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_P07_khk_F"];
// Set Magazine loot: Primary weapons, secondary weapons, Sidearms.
magazineLoot= ["SmokeShellPurple","SmokeShellYellow","SmokeShellOrange","11Rnd_45ACP_Mag","9Rnd_45ACP_Mag","16Rnd_9x21_Mag","6Rnd_45ACP_Cylinder"];
// Set items: Weapon attachments, first-aid, Binoculars
itemsLoot= ["Chemlight_yellow","acc_flashlight","G_Sport_BlackWhite","G_Sport_Blackyellow","G_Shades_Blue","G_Shades_Black","G_Squares_Tinted","G_Respirator_white_F"];
// Set Clothing: Hats, Helmets, Uniforms
clothesLoot= ["H_Bandanna_camo","H_Watchcap_blk","H_Watchcap_khk","H_Construction_basic_white_F","H_Construction_basic_yellow_F","H_Cap_blk_CMMG"];
// Set Survival
SurvivalLoot= ["FirstAidKit","Land_BakedBeans_F","Land_BottlePlastic_V2_F","Land_Can_V3_F","Medikit"];
// Set Repair Loot
RepairLoot= ["Land_CanisterFuel_F","Land_CanisterOil_F","Land_Suitcase_F"];

// Exclude buildings from loot spawn. Use 'TYPEOF' to find building name
_exclusionList= ["Land_Pier_F","Land_Pier_small_F","Land_NavigLight","Land_LampHarbour_F"];

_houseList= (getMarkerPos "center_mrk") nearObjects ["House",13000];

{
_house= _x;
	if (!(typeOf _house in _exclusionList)) then
	{
//		for "_n" from 0 to 50 do ---> OMG
		for "_n" from 0 to 3 do
		{
			_buildingPos= _house buildingpos _n;
			if (str _buildingPos == "[0,0,0]") exitwith {};
			if (_probability > random 100) then
			{
				null=[_buildingPos,_showLoot] execVM "addons\Simple_lootspawner\spawnLoot.sqf";
			};
		};
	};
}foreach _houseList;

};