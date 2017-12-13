// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: briefing.sqf

if (!hasInterface) exitWith {};

_trimName = { _this select [1, count _this - 2] };
_aKeyName = { _arr = actionKeysNamesArray _this; if (count _arr == 0) exitWith {"<UNDEFINED>"}; _arr select 0 };

#define NKEYNAME(DIK) (keyName DIK call _trimName)
#define AKEYNAME(ACT) (ACT call _aKeyName)

waitUntil {!isNull player};

player createDiarySubject ["infos", "Infos and Help"];
player createDiarySubject ["changelog", "Changelog"];
player createDiarySubject ["credits", "Credits"];

player createDiaryRecord ["changelog",
[
"v1.6",
"
<br/>[Added] New Respawn points
<br/>[Fixed] Many minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.5",
"
<br/>[Added] special Weather :)
"
]];

player createDiaryRecord ["credits",
[
"Credits",
"
<br/><font size='16' color='#BBBBBB'>Developed by A3Wasteland.com: - Modified by Mercenaires-francais </font>
<br/>	* AgentRev (TeamPlayerGaming)
<br/>	* JoSchaap (GoT/Tweakers.net)
<br/>	* MercyfulFate
<br/>	* His_Shadow (KoS/KillonSight)
<br/>	* Bewilderbeest (KoS/KillonSight)
<br/>	* Torndeco
<br/>	* Del1te (404Games)
<br/>   * ------Mercenaires-francais----------
<br/>   * Chick69 
<br/>   * Yannoukovytsh 
<br/>   * ----------------------------------
<br/>
<br/><font size='16' color='#BBBBBB'>Original Arma 2 Wasteland missions by:</font>
<br/>	* Tonic
<br/>	* Sa-Matra
<br/>	* MarKeR
<br/>
<br/><font size='16' color='#BBBBBB'>Improved and ported to Arma 3 by 404Games:</font>
<br/>	* Deadbeat
<br/>	* Costlyy
<br/>	* Pulse
<br/>	* Domuk
<br/>
<br/><font size='16' color='#BBBBBB'>Other contributors:</font>
<br/>	* 82ndab-Bravo17 (GitHub)
<br/>	* afroVoodo (Armaholic)
<br/>	* Austerror (GitHub)
<br/>	* AWA (OpenDayZ)
<br/>	* bodybag (Gameaholic.se)
<br/>	* Champ-1 (CHVD)
<br/>	* code34 (iniDBI)
<br/>	* Das Attorney (Jump MF)
<br/>	* Ed! (404Games forums)
<br/>	* Farooq (GitHub)
<br/>	* gtoddc (A3W forums)
<br/>	* HatchetHarry (GitHub)
<br/>	* Hub (TeamPlayerGaming)
<br/>	* k4n30 (GitHub)
<br/>	* Killzone_Kid (KillzoneKid.com)
<br/>	* Krunch (GitHub)
<br/>	* LouDnl (GitHub)
<br/>	* madbull (R3F)
<br/>	* Mainfrezzer (Magnon)
<br/>	* meat147 (GitHub)
<br/>	* micovery (GitHub)
<br/>	* Na_Palm (BIS forums)
<br/>	* Outlawled (Armaholic)
<br/>	* red281gt (GitHub)
<br/>	* RockHound (BierAG)
<br/>	* s3kShUn61 (GitHub)
<br/>	* Sa-Matra (BIS forums)
<br/>	* Sanjo (GitHub)
<br/>	* SCETheFuzz (GitHub)
<br/>	* Shockwave (A3W forums)
<br/>	* SicSemperTyrannis (iniDB)
<br/>	* SPJESTER (404Games forums)
<br/>	* spunFIN (BIS forums)
<br/>	* Tonic (BIS forums)
<br/>	* wiking.at (A3W forums)
<br/>	* xx-LSD-xx (Armaholic)
<br/>	* Zenophon (BIS Forums)
<br/>
<br/><font size='16'>Thanks A LOT to everyone involved for the help and inspiration!</font>
"
]];


_WASD = AKEYNAME("MoveForward") + "," + AKEYNAME("MoveBack") + "," + AKEYNAME("TurnLeft") + "," + AKEYNAME("TurnRight");

player createDiaryRecord ["infos",
[
"Admin Spectate keys",
"
<br/>Admin menu Spectate camera controls:
<br/>
<br/>Shift + " + AKEYNAME("NextChannel") + " (next player)
<br/>Shift + " + AKEYNAME("PrevChannel") + " (previous player)
<br/>Ctrl + " + NKEYNAME(18) + " (exit camera)
<br/>Ctrl + " + AKEYNAME("Chat") + " (attach/detach camera from target)
<br/>Ctrl + " + NKEYNAME(35) + " (toggle target HUD)
<br/>" + AKEYNAME("NightVision") + " (nightvision, thermal)
<br/>" + _WASD + " (move camera around)
<br/>" + NKEYNAME(16) + " (move camera up)
<br/>" + NKEYNAME(44) + " (move camera down)
<br/>Mouse Move (rotate camera)
<br/>Mouse Wheel Up (increase camera speed)
<br/>Mouse Wheel Down (decrease camera speed)
<br/>Shift + " + _WASD + " (move camera around faster)
<br/>" + AKEYNAME("ShowMap") + " (open/close map - click on map to teleport camera)
"
]];

player createDiaryRecord ["infos",
[
"Player hotkeys",
"
<br/>List of default player hotkeys:
<br/>
<br/>" + NKEYNAME(41) + " (open player menu)
<br/>" + NKEYNAME(207) + " (toggle earplugs)
<br/>" + NKEYNAME(199) + ", " + NKEYNAME(219) + ", " + NKEYNAME(220) + " (toggle player names)
<br/>Ctrl + " + AKEYNAME("GetOut") + " (emergency eject)
<br/>" + AKEYNAME("GetOver") + " (open parachute)
<br/>Shift + " + NKEYNAME(201) + " / " + NKEYNAME(209) + " (adjust nightvision)
<br/>" + NKEYNAME(22) + " (admin menu)
"
]];

player createDiaryRecord ["infos",
[
"A propos de ce Mod - GUERILLA",
"
<br/><font size='18'>Mercenaires-francais - A3Wasteland</font>
<br/>
<br/>* La Russie a revendiqué une partie du territoire De la Flastonie république de l’est de l’europe issue de l’ex bloc soviétique
<br/>
<br/>* Suite à cette agression armée très violente l’ensemble des éléments de l’état, Armée et police ont été réduit à néant 
<br/>
<br/>* Suite à cela de nombreuses milices armées se sont formés localement et ont décidés de proclamer leur indépendance vis-à-vis de l’état Flaston
<br/>
<br/>* le président Flaton - Slavaditsh à demandé l'aide de la communauté internationnale afin de retrouver une certaine stabilité
<br/>
<br/>* Celle-ci a répondu en envoyant des instructeurs, de l’armement et une force d’interposition.
<br/>
<br/>* L’ONU et la Russie ont trouvé un terrain d’entente en retirant (théoriquement) leurs troupes, cependant le pays est toujours en état de guerre permanent.
<br/>
<br/>* Dans les faits, de nombreuses factions pro russe (OPFOR) lourdement armés sont restés sur le territoire et aides des milices dans leurs actions de déstabilisation du gouvernement
<br/>
<br/>* D'autres factions elles-mêmes soutenues militairement et logistiquement par les Etats-Unis sévissent sur le sol
<br/>
<br/>* Celles-ci pillent sans vergogne les banques et transfèrent illégalement des fonds à travers le pays
<br/>
<br/>* Nous intervenons dans ce contexte, à la demande du président Slavaditsh et ce dans le plus grand secret
<br/>
<br/>* Il faut nous organiser afin de réunir suffisamment de moyen pour contrer les différentes factions présentes dans ce conflit
<br/>
<br/>* Pour cela nous ne pourrons faire autrement qu’accéder au marché noir afin de nous fournir en matériel et nourriture
<br/>
<br/>* ATTENTION : Nous devons faire attention aux civils présent dans les zones de guerre qui subissent ces agressions perpétuelles sous peine qu’un jour ils se retournent contre nous. 
"
]];

player createDiaryRecord ["infos",
[
"Jouez à ce mod",
"
<br/><font size='18'>Mercenaires-francais - GUERILLA</font>
<br/>
<br/>* Vous vous retrouver isolé de votre groupe, les personnes devant vous ammener vous ayant drogué et jetter au milieu de nulle part.
<br/>
<br/>* Vous avez en tout et pour tout, un PA en .45 avec deux chargeurs, une ration alimentaire, une bouteille d'eau et un kit de réparation.
<br/>
<br/>* Vous devez retrouver votre groupe, personne d'autre ne vous aidera et considérer les autres groupes comme étant hostiles, armés et dangereux.
<br/>
<br/>* Les rations alimentaires et boissons peuvent etre achetés dans les black market,récupérés sur les corps de différents protagonistes, voirent trouvés lorsque celles-ci ont été abandonnées dans les villes
<br/>
<br/>* Récupérez toute chose qui vous sera utile dans les maisons(s'il reste quelque chose) et sur les ennemeis que vous croiserez afin de les utiliser ou de les vendres.
<br/>
<br/>* Vous pouvez vous approprier certains véhicules, mais pas tous.
<br/>
<br/>* Vous trouver ou acheter des parties de construction afin d'établir des camps.
<br/>
<br/>* La fréquence radio de secours sera comme d'habitude la fréquence : CINQUANTE ET UN (51)
<br/>
<br/>* Restez tous les temps sur vos gardes; des patrouilles de toutes factions circulent dans cette ile. Ils sont hostiles et déterminés...
<br/>
<br/>* 19 points de respawn ont été prévus sur la map..soyez malin, patient et sans pitié pour les factions adverses.
<br/>
<br/>* ATTENTION
<br/>
<br/>* Le Serveur est un serveur PVE, il est donc interdit de s'entretuer (sauf bug) et un système de TK Punish est présent pour calmer les éventuels TROLL.
<br/>
<br/>* Le fait d'abatre un collègue vous vaudra sa malédiction éternelle, votre mort dans d'atroce souffrance et éventuellement le ban du serveur dans le cas de TK répétés et volontaire.
<br/>
<br/>* les admins sont présent pour vous aider.
"
]];


player createDiaryRecord ["infos",
[
"About Wasteland",
"
<br/>Wasteland is a team versus team versus team sandbox survival experience. The objective of this mission is to rally your faction, scavenge supplies, weapons, and vehicles, and destroy the other factions. It is survival at its best! Keep in mind this is a work in progress, please direct your reports to http://forums.a3wasteland.com/
<br/>
<br/>FAQ:
<br/>
<br/>Q. What am I supposed to do here?
<br/>A. See the above description
<br/>
<br/>Q. Where can I get a gun?
<br/>A. Weapons are found in one of three places, first in ammo crates that come as rewards from missions, inside and outside buildings, and second, in the gear section of the vehicles, which also randomly spawn around the map. The last place to find a gun would be at the gunshops located throughout the map. You can also find them on dead players whose bodies have not yet been looted.
<br/>
<br/>Q. What are the blue circles on the map?
<br/>A. The circles represent town limits. If friendly soldiers are in a town, you can spawn there from the re-spawn menu; however if there is an enemy presence, you will not be able to spawn there.
<br/>
<br/>Q. Why is it so dark, I cant see.
<br/>A. The server has a day/night cycle just like in the real world, and as such, night time is a factor in your survival. It is recommended that you find sources of light or use your Nightvision Goggles as the darkness sets in.
<br/>
<br/>Q. Is it ok for me to shoot my team mates?
<br/>A. If you are member of BLUFOR or OPFOR teams, then you are NOT allowed to shoot or steal items and vehicles from other players. If you play as Independent, you are free to engage anyone as well as team up with anyone you want.
<br/>
<br/>Q. Whats with the canisters, baskets and big bags?
<br/>A. This game has a food and water system that you must stay on top of if you hope to survive. You can collect food and water from food sacks and wells, or baskets and plastic canisters dropped by dead players. Food and water will also randomly spawn around the map.
<br/>
<br/>Q. I saw someone breaking a rule, what do I do?
<br/>A. Simply go into global chat and get the attention of one of the admins or visit our forums, and make a report if the offense is serious.
"
]];
