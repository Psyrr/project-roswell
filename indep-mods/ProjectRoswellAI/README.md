# Project Roswell AI

![IDE Badge](https://img.shields.io/badge/Development%20Enviroment%3A-Unreal%20Editor%2C%20IntelliJ%20%26%20VS-important)
![Test Badge](https://img.shields.io/badge/Tested%20With%3A-Win--64%20%7C%20Linux--64-success)
![Update Badge](https://img.shields.io/badge/Last%20Updated%3A-03%2F02%2F21-informational)
![Update Badge](https://img.shields.io/badge/Authored%20By%3A-Reece%20R.%20(Psyrr2)-inactive)

Without a doubt the most extensive modification with-in this modpack as it for all intents and purposes, 
this modpack removes near all restrictions places on the AI for "fairness" purposes, changes the logic used in the AI trees to make enemy behaviour more logical,
changes core mechanics to be more punishing, adds abilities and items to enemies and finally fixes bugs/mistakes left 
in the game by Firaxis (E.g. Spectral Zombies invoking an attack which does not exist in the core game files, etc).

### AI Changes
* Acolyte Mind Fire usage now scales with difficulty. Mindfire is unresistable, unblockable damage that ignores cover armour and shields and has no immunity offered to XCOM in game. Pretty powerful stuff. The higher the difficulty, the more Acolytes will use Mindfire with impunity.

* Adder snakes will no longer CONSTANTLY open with its bite ability.

* Androids will no longer self-destruct when they are not damaged.

* Androids will overwatch more on second action instead of going crazy on move flank and fire cycles.

* Any unit that has just spawned is now forbidden to take an action other than moving.

* Archon behaviour more consistent with Frenzy. While Frenzied, more movement and more melee. While not frenzied, will sometimes Overwatch and Fire Staff more.

* Archons will Frenzy 33% of the time instead of 75% after being damaged (each occurrence is 33%).

* Berserk AI behaviour changed so that it always prefers firing on enemies that are closer than farther. It will prefer flanked units within 8 tiles first, then evaluate everyone else.

* Breach scamper mechanics updated. I'm not a big fan of forcing enemies to do nothing with SkipMove, now they examine all valid non-firing options if they are Alert leading to smarter behaviours and choices from mission commencement.

* Call For Reinforcements cooldown up to 6 turns from 3.

* Cobras will no longer spit at any opportunity because it's available.

* Cobras won't use Rooting Poison if they are alone and they see multiple enemies unless they've failed at trying everything else.
* Commandos will use Call For Reinforcements IF AND ONLY IF
1) They are wounded in any way and
2) They see NO allies in their line of sight and
3) They are not flanked.

    It should feel more like a punishment mechanism now and less like a chance penalty thing. Kill those commandos DEAD first and you should be fine.

* Cover calc adjusted, Full Cover now preferred by enemies.

* Enemies will massively prefer wounded targets as the difficulty increases. Changes most apparent on Expert+.

* Fixed Legionnaire AI that has 2 "MoveThenGrenade" instead of "MoveThenGrenade" and then "TryGrenade". Can't move twice and grenade!

* Fixed Progeny not being able to use Dark Event Flashbangs. Acolytes, Resonants and Sorcerers carry 1 grenade and know how to use it. I've decided to limit it to them, the game also allows Thralls and Brutes, but I voted against it or it would be flashbang spam. If the Dark Event is not active, the units will never use it.

*  Hitmen will no longer spam Disabling Shot.

*  Hopefully resolved issues where the Berserker moves randomly about, doing nothing.

* The Gatekeeper will melee more, and never on allies like in XC2.

*  In the case where a Berserk character or enemy becomes Panicked on top, the character will refuse to Panic Move and stay in place.

* The Python should be much smarter. Tongue Pull and gunning point blank is now an option.

*  MECs no longer consider allies as valid targets for Micro Missiles.

*  MECs require to have LOS to all targets before Micro Missiling.

*  Mind Controlled units are now smarter and extremely deadly.

* Panicked units have 25% chance to fire on anything and 75% chance to Cower with their action.

*  Panicked units no longer grenade at all (either side).

*  Panicked units will move away from anyone and as far as possible as fast as possible, preferring High Cover. This is similar to the ADVENT Priest behaviour if you played XCOM 2 while he was on Holy Warrior.

*  Praetorians are less obsessed with their "Duel" target, it's still important but they'll check more options instead of going into an AI frenzy of wanting to go get their target at all costs.

*  Psi Reanimation moved to 1 Action, doesn't end the turn when used.

*  Purifiers can use their Flamethrower as a melee weapon (Subdue)

*  Reloading is forbidden if you are Panicked, Berserk or Frenzied. Valid for both sides.

* Battle Madness will now do the following in order: Unit tries to melee, Unit tries to shoot a random ally or flamethrower an ally, Unit tries to shoot anyone or flamethrower anyone, try to grenade a random unit. Reloading has been removed from the tree.

* RiotGuard updated. Should work better.

* Fallback mechanics updated to run further and away from units.

* Sectoid Paladin was overhauled. No longer uses a pure Advent Priest AI. Carries a Medikit.

* Spectral Zombies moved to 1 Action, doesn't end the turn.

* Spectral Zombies should be less stupid.

* Spectral Zombies given Psi Zombie melee attack as previously their "weapon" is a template that does not exist in XC:CS, only in XCOM 2. Which is a HUGE oversight on the part of Firaxis.

* Sticky Grenades behaviour remodelled, the unit that is grenaded will now Panic Move instead of sometimes running towards XCOM for no reason.

* Support for all Gray Phoenix units Grenade Dark Event added. I don't know if it's even in game, but if it is GP will start grenading your units with Plasmas if they have them. If not, no harm done.

* Targets will consider "Very Good" to be 8 tiles instead of 5 leading to ridiculous decisions not to shoot flanked targets that are at reasonable distance.

* Tempo Surge usage varies with difficulty (25/50/75/90%) each round Ronins get.

* The AI can now fire on Bound, Panicked or Berserk targets.

* The AI is now allowed to bunch up a little more. It had the XCOM2 values, but the playfield is tighter, so the area has been adjusted. Units are allowed to be within 2 tiles of each other.

*  The AI will no longer use Pin Down on Flanked targets of it the MEC is alone.

*  The AI will now correctly use Overwatch in many varied situations.

*  The default ideal range for enemies is down to 7 from 10.

*  The Muton Brute has severely improved his intelligence in combat instead of constantly spamming Melee Stance and pounding his chest.

*  The Praetorian is allowed an exception to the "Do not double move ever during a round" behaviour. It will move on the 2nd action towards its dual target IF AND ONLY IF it doesn’t see too many enemies and it has at least 1 supporting ally. Otherwise, it will just act like a regular unit.

* Tile lingering is now allowed (less movement for no reason)

* Turrets are now allowed to fire on anyone, not just Marked Targets. They do prefer Marked, however. They will also prefer flanked targets closer.

* Units no longer care if you acted or not for targeting.

* Units with fixed abilities that always preferred using them in priority are now forced to mix up their choices more (Demolition, Duel, etc.). You should no longer be able to predict with 100% accuracy what a unit will do (Hey look a MEC, i bet it’s going to open with Micro Missiles).

* Units with the Demolition ability will not use it if they don’t see any allies (What's the point right?).

* While playing around I discovered that most of the enemy units with shields have working abilities and VFX (Animations) which are unused. Units are now capable of Shield Bashing you if it is appropriate!

### Non-AI/Mechanic Changes

* The radius of Radial Overwatch has been doubled as it felt very underpowered in production builds of the game (3.5 to 7 tiles).

* Sectoid Paladins no longer use "Holy Warrior" as behaviour changes seemed to be ignored because of hardcode in the core game so replaced with a charge of "Kinetic Shield" as they are in practice the same but KS behaviour is more consistent and able to be controlled.

### Pre-Requisites

In the base game, enemies are incapable of using Overwatch properly or will use in scenarios which logically make no sense.
To amend this I gut the ability and reimplement it in "ProjectRoswellEXA" so this mod can dictate its logic in AI trees properly.

This is by no means an obligation to download the other package, however you need to be aware that without this some enemies will
be unable to use Overwatch properly and it will be skipped from their logic.

### Conflicts & Compatibility

This mod naturally has conflicts with any modification which alters the behaviour of the AI, such as ABA: Dragon AI.

This mod also will not work if downloaded mid-mission as it requires a fresh game state, however it can be safely added, used or removed
at any other point.

### Known Bugs

N/A as of this time.

### Testimonials

"Love Letter to Hardcore XCOM - Notoriously challenging making for riveting, unforgiving gameplay"

- SamBC (Firaxis Developer)

"You really aren’t messing around"
- Valvatorex (Former Steam Workshop Subscriber - Project Roswell 1.0)
