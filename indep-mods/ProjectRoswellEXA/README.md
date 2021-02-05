# Project Roswell EXA

![IDE Badge](https://img.shields.io/badge/Development%20Enviroment%3A-Unreal%20Editor%2C%20IntelliJ%20%26%20VS-important)
![Test Badge](https://img.shields.io/badge/Tested%20With%3A-Win--64%20%7C%20Linux--64-success)
![Update Badge](https://img.shields.io/badge/Last%20Updated%3A-03%2F02%2F21-informational)
![Update Badge](https://img.shields.io/badge/Authored%20By%3A-Reece%20R.%20(Psyrr2)-inactive)

This modification adds extra resistances and abilities to give a more challenging gameplay experience.
Additionally for those with a penchant towards the masochistic, this mod also hides enemy health values and inter-phase healing on
"Impossible" difficulty.

Side Note: As this is the most recently developed out of all the mods in the pack, it bares reference in the code a campaign fix mod which is not currently finished. Once implemented this will have cross-functionality.

### Abilities Added

#### AI Civilians
* Shadowstep is added to the AI civilians out of the players control to avoid crossfire caused by Overwatch, etc.

#### Enemies/Legacy Enemies
*	Acolyte: Steady Hands, Warm Welcome
*	ADVENT MEC: Full Throttle, Sentinel, Cone Overwatch (Fixed!)
*	Android: Hit Where It Hurts
*	Andromedon Robot: Melee Resistance
*	Andromedon: Reflex Grip, Blast Padding, Melee Resistance, Cone Overwatch (Fixed!)
*	Archon: Steady Hands, Lightning Reflexes, Radial Overwatch (Fixed!)
*	Berserker: Lightning Reflexes, Shrug It Off (Melee Resistance was removed)
*	Bruiser: Hit Where It Hurts
*	Chryssalid: Lightning Reflexes
*	Cocoons: Vulnerability To Melee (2), Regeneration
*	Codex: Lightning Reflexes, Cone overwatch (Fixed!)
*	Commando: Steady Hands
*	Faceless: Skirmisher Reflexes, Vulnerability to Melee (2), Blast Padding
*	Gatekeeper: Regeneration
*	Guardian: Sentinel
*	Hitman: Zero In, Reflex Grip
*	Muton Bomber: Biggest Booms, Volatile Mix, Deep Cover
*	Muton Brute: Bloodtrail
*	Muton Legionnaire: Steady Hands
*	Muton Praetorian: Hit Where It Hurts, Bloodtrail, Melee Resistance (2)
*	Neonate Chryssalid: Vulnerability To Melee (2)
*	Purifier: Blast Padding
*	Ronin: (Lightning Reflexes removed), DarkEventAbility_Regeneration
*	Sectoid Dominator: Deep Cover, Hit Where It Hurts
*	Sectoid Necromancer: Solace, Regeneration, Fond Farewell
*	Sectoid Paladin: Deep Cover, Hit Where It Hurts
*	Sectoid Resonant: Deep Cover
*	Sectopod: Super Melee Resistance (4), Full Throttle, Holo Targeting, Zero In, Biggest Booms, Sentinel
*	Sorcerer: Solace, Steady Hands
*	Thrall: Bloodtrail, Sentinel
*	Trooper: Steady Hands
*	Turrets: Zero In, Sentinel, Reload On Kill
*	Viper Adder: Bloodtrail
*	Viper Cobra: Lightning Reflexes, Skirmisher Reflexes
*	Zombies: Regeneration

#### Faction Leaders (Bosses)
*	CONSPIRACY: Skirmisher Reflexes, Reflex Grip, Deep Cover, Blast Padding, Sentinel, Shadowstep, Close Combat Specialist, Steady Hands, Fond Farewell, Warm Welcome
*	GREY PHOENIX: Shrug It Off, Biggest Booms, Blast Padding, Regeneration, Bloodtrail, Volatile Mix, Shadowstep
*	PROGENY: Solace, Fortress, Deep Cover, Steady Hands
*	SACRED COIL: Untouchable, Full Throttle, Melee Resistance, Hit Where It Hurts, Shadowstep

### Additional Fixes
Being the most recently developed modification a number of fixes which are too small for their own packs, I threw into this mod before these modifcationms became seperate (In Project Roswell 1.0).

* Overwatch Fix - Granted overwatch to the following units which did not have it by default:
1) Archon: Radial Overwatch
2) Andromedon: Cone Overwatch
3) MEC: Cone Overwatch
4) Codex: Cone Overwatch

* Melee Resistance Fix - I discovered a bug where negative damage results as a result of the added resistances can result in the
healing of the enemy target which I amend here.

* Solace Fixes - Patches multiple bugs related to Solace and its VFX. (This section refers to the unfinished campaign mod which will once of of dev become known as "ProjectRoswellCPN")

### Conflicts & Compatibility

This mod also will not work if downloaded mid-mission as it requires a fresh game state, however it can be safely added, used or removed
at any other point.

### Dependencies

This mod is dependant on "ProjectRoswellAI" for the "Overwatch" ability to function properly as in the base game, enemies are incapable of using Overwatch properly or will use it in scenarios which logically make no sense.
To amend this I gut the ability and reimplement it here so "ProjectRoswellAI" can dictate its logic in AI trees properly. 

### Known Bugs
* Overwatch on some enemies doesnt fire properly (Bugged VFX) - This is a base game bug which would be hard to fix without 
going deep into GameState which that I'm not currently comfortable with. Maps and visibility also play a factor.
