class X2DownloadableContentInfo_ProjectRoswellAI extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated() {
   local X2AbilityTemplateManager	          AllAbilities;
   local X2AbilityTemplate                    CurrentAbility;
   local X2Condition_UnitProperty             UnitPropertyCondition;
   local X2Condition_UnitEffects              UnitConditionEffects;
   local X2AbilityCost_ActionPoints           ActionCost;
   local X2AbilityCost_ActionPoints ActionPointCost;

   AllAbilities     = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

   // Fix Dark Events
   AllAbilities.AddAbilityTemplate(class'X2Ability_DarkEvents_Fixed'.static.DarkEventAbility_Regeneration(), true);
   // I dont think this is in game but if it is, its now fixed.
   AllAbilities.AddAbilityTemplate(class'X2Ability_DarkEvents_Fixed'.static.DarkEventAbility_LightningReflexes(), true);
   
   // Cannot use Reload if Panicked, Berserk, Muton Rage or Frenzied
   CurrentAbility = AllAbilities.FindAbilityTemplate('Reload');
   UnitConditionEffects = new class'X2Condition_UnitEffects';
   UnitConditionEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BerserkName, 'AA_UnitRageTriggered');
   UnitConditionEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.PanickedName, 'AA_UnitIsPanicked');
   UnitConditionEffects.AddExcludeEffect(class'X2AbilityTemplateMAnager'.default.MutonRageBerserkName, 'AA_UnitRageTriggered');
   UnitConditionEffects.AddExcludeEffect('FrenzyEffect', 'AA_UnitIsFrenzied');
   CurrentAbility.AbilityShooterConditions.AddItem(UnitConditionEffects);

   CurrentAbility = AllAbilities.FindAbilityTemplate('EngageSelfDestruct');
   UnitPropertyCondition = new class'X2Condition_UnitProperty';
   UnitPropertyCondition.ExcludeFriendlyToSource = false;
   UnitPropertyCondition.ExcludeFullHealth = true;
   UnitPropertyCondition.FailOnNonUnits = true;
	CurrentAbility.AbilityTargetConditions.AddItem(UnitPropertyCondition);

   // I dont know why this fixes it, but it fixes it. Bruisers/Guardians/Praetorians lost the ability, now they have it.
   // If i pop a Bruiser in the base game, it does NOT have RiotGuard. If I pop it after i do this, they work. So there.
   AllAbilities.AddAbilityTemplate(class'X2Ability_NewRiotGuard'.static.AddNewRiotGuard(), true);

   CurrentAbility = AllAbilities.FindAbilityTemplate('PsiReanimation');
   CurrentAbility.AbilityCosts.Length = 0;
   ActionCost = new class'X2AbilityCost_ActionPoints';
   ActionCost.iNumPoints = 1;
   ActionCost.bConsumeAllPoints = false;
   CurrentAbility.AbilityCosts.AddItem(ActionCost);

   CurrentAbility = AllAbilities.FindAbilityTemplate('CorressM2');
   CurrentAbility.AbilityCosts.Length = 0;
   ActionCost = new class'X2AbilityCost_ActionPoints';
   ActionCost.iNumPoints = 1;
   ActionCost.bConsumeAllPoints = false;
   CurrentAbility.AbilityCosts.AddItem(ActionCost);

   // Prevents multiple uses in same turn.
   CurrentAbility = AllAbilities.FindAbilityTemplate('TargetingSystem');
   CurrentAbility.AbilityCooldown = CreateCooldown(1);

   // Prevents them from spaming.
   CurrentAbility = AllAbilities.FindAbilityTemplate('QuickBite');
   CurrentAbility.AbilityCooldown = CreateCooldown(3);

   // Dark Event Flashbang fix
   FixDarkEventFlashbang();
   FixDarkEventPlasmaGrenades();

   // Remove HolyWarriorM1 from Sectoid_Paladin
   RemoveUnitPerk('Sectoid_Paladin', 'HolyWarriorM1');

   // Anima Consume enemies only
   AllAbilities.AddAbilityTemplate(class'X2Ability_GatekeeperAnimaFix'.static.NewCreateAnimaConsumeAbility(), true);

   // Enemy Bladestorm Overwatch is totally free
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 0;
	ActionPointCost.bFreeCost = true;
	ActionPointCost.bConsumeAllPoints = false;
   CurrentAbility = AllAbilities.FindAbilityTemplate('BladestormOverwatch');
   CurrentAbility.AbilityCosts.Length = 0;
	CurrentAbility.AbilityCosts.AddItem(ActionPointCost);
   CurrentAbility = AllAbilities.FindAbilityTemplate('MeleeStance');
   CurrentAbility.AbilityCosts.Length = 0;
	CurrentAbility.AbilityCosts.AddItem(ActionPointCost);

   FixCharRoot('Purifier', "BreachScamperRoot_Generic");
   FixCharRoot('Sectoid_Dominator', "BreachScamperRoot_Sectoid_Dominator");
   FixCharRoot('Gatekeeper', "BreachScamperRoot_Generic");

   // This one fixes most issues.
   DisableMeleeStickyGrenadeOnAbility('StandardMelee');

   // Then go through exceptions.
   DisableMeleeStickyGrenadeOnAbility('ChryssalidSlash');
   DisableMeleeStickyGrenadeOnAbility('DevastatingPunch');
   DisableMeleeStickyGrenadeOnAbility('ScythingClaws');   
   DisableMeleeStickyGrenadeOnAbility('BigDamnPunch');
   DisableMeleeStickyGrenadeOnAbility('AnimaConsume');
   DisableMeleeStickyGrenadeOnAbility('FacelessBerserkMelee');
   DisableMeleeStickyGrenadeOnAbility('Bind');
   DisableMeleeStickyGrenadeOnAbility('RendingSlash');
   DisableMeleeStickyGrenadeOnAbility('RootingSlash');
   DisableMeleeStickyGrenadeOnAbility('DisarmingSlash');
   DisableMeleeStickyGrenadeOnAbility('BreakerRageAttack');

   // Melee for purifiers as last resort.
   ChangeUnitPerk('Purifier', 'TakeDown');

   // The Chryssalid can no longer target canisters of explosives, LOL
   CurrentAbility = AllAbilities.FindAbilityTemplate('ChryssalidSlash');
   CurrentAbility.AbilityTargetConditions.AddItem(new class'X2Condition_BerserkerDevastatingPunch'); 

   // Give Legionnaires the Bomber Melee ability. Bombers are bombers, they dont melee much. They still have it though.
   // NOTE : VFX MISSING, CANNOT USE. REMOVING.
   //ChangeUnitPerk('Muton_Legionairre','BomberStrike');
   //ChangeUnitPerk('VIP_GPGroundwork3rd','BomberStrike');
}

static function ChangeUnitPerk( name nUnitName, name nPerkName, optional bool bRemoveInstead = false) {
   local X2CharacterTemplateManager	              AllCharacters;
   local X2CharacterTemplate		                 CurrentUnit;
   local X2DataTemplate					              DifficultyTemplate;
   local array<X2DataTemplate>		              DifficultyTemplates;
   
   AllCharacters    = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

   CurrentUnit = AllCharacters.FindCharacterTemplate(nUnitName);

   if ( CurrentUnit != none ) {
	   if ( CurrentUnit.bShouldCreateDifficultyVariants == true ) {
		   AllCharacters.FindDataTemplateAllDifficulties(nUnitName, DifficultyTemplates);
		   foreach DifficultyTemplates(DifficultyTemplate) {
			   CurrentUnit = X2CharacterTemplate(DifficultyTemplate);
            CurrentUnit.Abilities.RemoveItem(nPerkName);
            if ( bRemoveInstead == false ) {
               CurrentUnit.Abilities.AddItem(nPerkName);
            }
         }
	   } else {
         CurrentUnit.Abilities.RemoveItem(nPerkName);
         if ( bRemoveInstead == false ) {
            CurrentUnit.Abilities.AddItem(nPerkName);
         }
      }
   } else {
      `log("Change Unit Perk: Current Unit is NONE.");
   }
}

static function DisableMeleeStickyGrenadeOnAbility( name nAbilityName ) {
   local X2AbilityTemplateManager	          AllAbilities;
   local X2AbilityTemplate                    CurrentAbility;
	local X2Condition_UnitEffects					 EffectCondition;

   AllAbilities     = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

   CurrentAbility = AllAbilities.FindAbilityTemplate(nAbilityName);
   if ( CurrentAbility != none ) {
      EffectCondition = new class'X2Condition_UnitEffects';
      EffectCondition.AddExcludeEffect(class'X2Effect_HomingMine'.default.EffectName, 'AA_UnitHasHomingMine');
      EffectCondition.AddExcludeEffect('StickyGrenadeRetreat', 'AA_UnitHasHomingMine');
      CurrentAbility.AbilityShooterConditions.AddItem(EffectCondition);
   } else {
      `log("Chimera AI error: Ability name is none.");
   }
}

static function FixCharRoot( name nUnitName, string sRootName ) {
   local X2CharacterTemplateManager	              AllCharacters;
   local X2CharacterTemplate		                 CurrentUnit;
   local X2DataTemplate					              DifficultyTemplate;
   local array<X2DataTemplate>		              DifficultyTemplates;
   
   AllCharacters    = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

   CurrentUnit = AllCharacters.FindCharacterTemplate(nUnitName);

   if ( CurrentUnit != none ) {
	   if ( CurrentUnit.bShouldCreateDifficultyVariants == true ) {
		   AllCharacters.FindDataTemplateAllDifficulties(nUnitName, DifficultyTemplates);
		   foreach DifficultyTemplates(DifficultyTemplate) {
			   CurrentUnit = X2CharacterTemplate(DifficultyTemplate);
            CurrentUnit.strBreachScamperBT = sRootName;
         }
	   } else {
         CurrentUnit = X2CharacterTemplate(DifficultyTemplate);
         CurrentUnit.strBreachScamperBT = sRootName;
      }
   } else {
      `log("Change Unit Root: Current Unit is NONE.");
   }
}

static function RemoveUnitPerk( name nUnitName, name nPerkName ) {
   local X2CharacterTemplateManager	              AllCharacters;
   local X2CharacterTemplate		                 CurrentUnit;
   local X2DataTemplate					              DifficultyTemplate;
   local array<X2DataTemplate>		              DifficultyTemplates;
   
   AllCharacters    = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

   CurrentUnit = AllCharacters.FindCharacterTemplate(nUnitName);

   if ( CurrentUnit != none ) {
	   if ( CurrentUnit.bShouldCreateDifficultyVariants == true ) {
		   AllCharacters.FindDataTemplateAllDifficulties(nUnitName, DifficultyTemplates);
		   foreach DifficultyTemplates(DifficultyTemplate) {
			   CurrentUnit = X2CharacterTemplate(DifficultyTemplate);
            CurrentUnit.Abilities.RemoveItem(nPerkName);
         }
	   } else {
         CurrentUnit.Abilities.RemoveItem(nPerkName);
      }
   } else {
      `log("Change Unit Perk: Current Unit is NONE.");
   }
}

// Create Cooldown
static function X2AbilityCooldown CreateCooldown( int iNewCooldown ) {
   local X2AbilityCooldown Cooldown;
   Cooldown = new class'X2AbilityCooldown';

   if (iNewCooldown <= 0)
	  return none;

   if (iNewCooldown > 9)
      iNewCooldown = 9;

   Cooldown.iNumTurns = iNewCooldown;

   return Cooldown;
}

static function FixDarkEventFlashbang() {
   local X2Effect_Persistent                      CurrentDarkEventEffect;
   local X2AbilityTemplateManager	              AllAbilities;
   local X2AbilityTemplate                        CurrentAbility;
   local X2Effect                                 TempEffect;

   AllAbilities     = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

   CurrentAbility = AllAbilities.FindAbilityTemplate('DarkEventAbility_Flashbang');
   foreach CurrentAbility.AbilityTargetEffects( TempEffect ) {
      if ( TempEffect.IsA('X2Effect_Persistent') == true ) {
         CurrentDarkEventEffect = X2Effect_Persistent(TempEffect);
         CurrentDarkEventEffect.EffectName = 'DarkEventFlashbangEffect';
      }
   } 
   `log("Dark Event Flashbang patched to have a proper effect name.");
}

static function FixDarkEventPlasmaGrenades() {
   local X2Effect_Persistent                      CurrentDarkEventEffect;
   local X2AbilityTemplateManager	              AllAbilities;
   local X2AbilityTemplate                        CurrentAbility;
   local X2Effect                                 TempEffect;

   AllAbilities     = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

   CurrentAbility = AllAbilities.FindAbilityTemplate('DarkEvent_PlasmaGrenades');
   foreach CurrentAbility.AbilityTargetEffects( TempEffect ) {
      if ( TempEffect.IsA('X2Effect_Persistent') == true ) {
         CurrentDarkEventEffect = X2Effect_Persistent(TempEffect);
         CurrentDarkEventEffect.EffectName = 'DarkEventPlasmaGrenadesEffect';
      }
   } 
   `log("Dark Event Plasma Grenades patched to have a proper effect name.");
}