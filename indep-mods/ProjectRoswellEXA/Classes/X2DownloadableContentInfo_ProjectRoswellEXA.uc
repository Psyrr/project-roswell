class X2DownloadableContentInfo_ProjectRoswellEXA extends X2DownloadableContentInfo;

const PERK_ADD = false;
const PERK_SUB = true;

static function SolaceFixes() {
   local X2AbilityTemplateManager	              AllAbilities;
   local X2AbilityTemplate                        CurrentAbility;
   local X2Condition_UnitProperty                 CurrentCondition;
   local X2Condition                              TempCondition;
   local X2Effect                                 CurrentEffect;
   local X2Effect_DamageImmunity                  ImmunityEffect;

   AllAbilities     = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

   // Fixes total immunity for Shelter.
   CurrentAbility = AllAbilities.FindAbilityTemplate('SolacePassive');
   
   ImmunityEffect = new class'X2Effect_DamageImmunity';
	ImmunityEffect.EffectName = 'SolaceOwnerImmunities';
	ImmunityEffect.ImmuneTypes.AddItem('Mental');
	ImmunityEffect.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.DisorientDamageType);
   ImmunityEffect.ImmuneTypes.AddItem('Panic');
	ImmunityEffect.BuildPersistentEffect(1, true, false, false);
	CurrentAbility.AddTargetEffect(ImmunityEffect);

   // Remove garbage targets for Solace effects (Robots, etc.)
   CurrentAbility = AllAbilities.FindAbilityTemplate('Solace');

   foreach CurrentAbility.AbilityTargetEffects( CurrentEffect ) {
      if ( CurrentEffect != none ) {
	     foreach CurrentEffect.TargetConditions ( TempCondition ) {
		    if ( TempCondition != none ) {
			   if ( TempCondition.IsA( 'X2Condition_UnitProperty' )) {
		         CurrentCondition = X2Condition_UnitProperty(TempCondition);
			      CurrentCondition.ExcludeRobotic       = true;
			      CurrentCondition.ExcludeDead          = true;
			      CurrentCondition.ExcludeCosmetic      = true;
			      CurrentCondition.ExcludeUnrevealedAI  = true;
               CurrentCondition.ExcludeUnconscious   = true;
               CurrentCondition.ExcludeInStasis      = true;
               CurrentCondition.ExcludeUnBreached    = true; 
			   }
		   }
		 }
	  }
   }
   foreach CurrentAbility.AbilityMultiTargetEffects( CurrentEffect ) {
      if ( CurrentEffect != none ) {
	     foreach CurrentEffect.TargetConditions ( TempCondition ) {
		    if ( TempCondition != none ) {
			   if ( TempCondition.IsA( 'X2Condition_UnitProperty' )) {
		         CurrentCondition = X2Condition_UnitProperty(TempCondition);
			      CurrentCondition.ExcludeRobotic       = true;
			      CurrentCondition.ExcludeDead          = true;
			      CurrentCondition.ExcludeCosmetic      = true;
			      CurrentCondition.ExcludeUnrevealedAI  = true;
               CurrentCondition.ExcludeUnconscious   = true;
               CurrentCondition.ExcludeInStasis      = true;
               CurrentCondition.ExcludeUnBreached    = true; 
			   }
		   }
		 }
	  }
   }

   CurrentAbility = AllAbilities.FindAbilityTemplate('SolaceCleanse');
   foreach CurrentAbility.AbilityTargetEffects( CurrentEffect ) {
      if ( CurrentEffect != none ) {
	     foreach CurrentEffect.TargetConditions ( TempCondition ) {
		    if ( TempCondition != none ) {
			   if ( TempCondition.IsA( 'X2Condition_UnitProperty' )) {
		         CurrentCondition = X2Condition_UnitProperty(TempCondition);
			      CurrentCondition.ExcludeRobotic       = true;
			      CurrentCondition.ExcludeDead          = true;
			      CurrentCondition.ExcludeCosmetic      = true;
			      CurrentCondition.ExcludeUnrevealedAI  = true;
               CurrentCondition.ExcludeUnconscious   = true;
               CurrentCondition.ExcludeInStasis      = true;
               CurrentCondition.ExcludeUnBreached    = true; 
			   }
		   }
		 }
	  }
   }
   foreach CurrentAbility.AbilityMultiTargetEffects( CurrentEffect ) {
      if ( CurrentEffect != none ) {
	     foreach CurrentEffect.TargetConditions ( TempCondition ) {
		    if ( TempCondition != none ) {
			   if ( TempCondition.IsA( 'X2Condition_UnitProperty' )) {
		         CurrentCondition = X2Condition_UnitProperty(TempCondition);
			      CurrentCondition.ExcludeRobotic       = true;
			      CurrentCondition.ExcludeDead          = true;
			      CurrentCondition.ExcludeCosmetic      = true;
			      CurrentCondition.ExcludeUnrevealedAI  = true;
               CurrentCondition.ExcludeUnconscious   = true;
               CurrentCondition.ExcludeInStasis      = true;
               CurrentCondition.ExcludeUnBreached    = true; 
			   }
		    }
		 }
	  }
   }

   `log("Solace bugfixes patched in because Avenger Campaign Tweaks is not subscribed.");
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

static function bool ModInstalled(name ModName) {

	local XComOnlineEventMgr EventManager;
	local int i;

	EventManager = `ONLINEEVENTMGR;
	for(i = EventManager.GetNumDLC() - 1; i >= 0; i--)
	{
		if(EventManager.GetDLCNames(i) == ModName)
		{
			return true;
		}
	}
	return false;
}

static event OnPostTemplatesCreated() {
   local X2AbilityTemplateManager	              AllAbilities;
   local X2Effect_SkirmisherReflex                CurrentSkirmisherReflexEffect;
   local X2Condition_UnitProperty                 UnitCondition;
   local X2AbilityTemplate                        CurrentAbility;
   local X2Effect                                 CurrentEffect;
   
   AllAbilities     = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

   if ( !ModInstalled( 'AvengerCampaignTweaks' ) ) {
      SolaceFixes();

      // Fix Melee Resistance negatives patch. 2 because its already implemented in my Campaign Mods.
      AllAbilities.AddAbilityTemplate(class'X2Ability_Berserker_Fix2'.static.CreateMeleeResistanceAbility(), true);      
      AllAbilities.AddAbilityTemplate(class'X2Ability_Berserker_Fix2'.static.CreateSuperMeleeResistanceAbility(), true);
   }

   // Skirmisher Reflexes only triggers if you survive the shot and if you're not impaired.
   CurrentAbility = AllAbilities.FindAbilityTemplate('SkirmisherReflex');
   UnitCondition = new class'X2Condition_UnitProperty';
	UnitCondition.ExcludeDead = true;
   UnitCondition.ExcludeUnconscious = true;
	UnitCondition.ExcludeFriendlyToSource = false;
   UnitCondition.ExcludeStunned = true;
   UnitCondition.ExcludeInStasis = true;
   UnitCondition.ExcludePanicked = true;
   UnitCondition.ExcludeUnableToAct = true;
   foreach CurrentAbility.AbilityTargetEffects( CurrentEffect ) {
      if ( CurrentEffect != none ) {
         if ( CurrentEffect.IsA( 'X2Effect_SkirmisherReflex' )) {
            CurrentSkirmisherReflexEffect = X2Effect_SkirmisherReflex(CurrentEffect);
            CurrentSkirmisherReflexEffect.TargetConditions.AddItem(UnitCondition);
            break;
         }
      }
   }     

   // Trigger Happy: Doesn't work if given.
   // Ever Vigiliant is buggy as hell.

   // Civilians
   ChangeUnitPerk('Civilian', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('HybridCivilian', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('HumanCivilian', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('MutonCivilian', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('SectoidCivilian', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('ViperCivilian', 'Shadowstep', PERK_ADD);

   // Regulars
   ChangeUnitPerk('Muton_Legionairre', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('VIP_GPGroundwork3rd', 'SteadyHands', PERK_ADD);

   ChangeUnitPerk('Viper_Adder', 'Bloodtrail', PERK_ADD);

   ChangeUnitPerk('Sectoid_Paladin', 'DeepCover', PERK_ADD);
   ChangeUnitPerk('Sectoid_Paladin', 'HitWhereItHurts', PERK_ADD);
   
   ChangeUnitPerk('Sectoid_Dominator', 'DeepCover', PERK_ADD);
   ChangeUnitPerk('Sectoid_Dominator', 'HitWhereItHurts', PERK_ADD);
   
   ChangeUnitPerk('Muton_Praetorian', 'HitWhereItHurts', PERK_ADD);
   ChangeUnitPerk('Muton_Praetorian', 'Bloodtrail', PERK_ADD);
   ChangeUnitPerk('Muton_Praetorian', 'MeleeResistance', PERK_ADD);
   ChangeUnitPerk('VIP_GPTier2A1', 'HitWhereItHurts', PERK_ADD);
   ChangeUnitPerk('VIP_GPTier2A1', 'Bloodtrail', PERK_ADD);
   ChangeUnitPerk('VIP_GPTier2A1', 'MeleeResistance', PERK_ADD);

   ChangeUnitPerk('Berserker', 'LightningReflexes', PERK_ADD);
   ChangeUnitPerk('Berserker', 'ShrugItOff', PERK_ADD);
   ChangeUnitPerk('Berserker', 'MeleeResistance', PERK_SUB);
   AddUnitNaturalImmunity('Berserker', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('Berserker', 'Panic');

   ChangeUnitPerk('Faceless', 'SkirmisherReflex', PERK_ADD);
   ChangeUnitPerk('Faceless', 'VulnerabilityMelee', PERK_ADD);
   ChangeUnitPerk('Faceless', 'BlastPadding', PERK_ADD);
   AddUnitNaturalImmunity('Faceless', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('Faceless', 'Panic');   

   ChangeUnitPerk('Sectopod', 'SuperMeleeResistance', PERK_ADD);
   ChangeUnitPerk('Sectopod', 'TargetingSystemHolotargeting', PERK_ADD);
   ChangeUnitPerk('Sectopod', 'ZeroIn', PERK_ADD);
   ChangeUnitPerk('Sectopod', 'BiggestBooms', PERK_ADD);
   ChangeUnitPerk('Sectopod', 'Sentinel', PERK_ADD);

   ChangeUnitPerk('Commando', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('SacredCoilDJ', 'SteadyHands', PERK_ADD);

   ChangeUnitPerk('Android', 'HitWhereItHurts', PERK_ADD);

   ChangeUnitPerk('AdvTurretM1', 'WarmWelcome', PERK_ADD);

   ChangeUnitPerk('Purifier', 'BlastPadding', PERK_ADD);

   ChangeUnitPerk('Guardian', 'Sentinel', PERK_ADD);

   ChangeUnitPerk('Ronin', 'LightningReflexes', PERK_SUB);
   ChangeUnitPerk('Ronin', 'DarkEventAbility_Regeneration', PERK_ADD);

   ChangeUnitPerk('AdvMEC_M1', 'Sentinel', PERK_ADD);

   ChangeUnitPerk('Chryssalid', 'LightningReflexes', PERK_ADD);  
   ChangeUnitPerk('NeonateChryssalid', 'VulnerabilityMelee', PERK_ADD);
   
   ChangeUnitPerk('ChryssalidCocoon', 'VulnerabilityMelee', PERK_ADD);
   ChangeUnitPerk('ChryssalidCocoonHuman', 'VulnerabilityMelee', PERK_ADD);
   ChangeUnitPerk('ChryssalidCocoon', 'Regeneration', PERK_ADD);
   ChangeUnitPerk('ChryssalidCocoonHuman', 'Regeneration', PERK_ADD);   

   // You have to give Overwatch via the weapon for Archon and Andromedon.
   // If you give them the ability directly it'll whine it doesn't have enough Ammo.
   ChangeUnitPerk('Andromedon', 'ReflexGripAbility', PERK_ADD);
   ChangeUnitPerk('Andromedon', 'BlastPadding', PERK_ADD);
   ChangeUnitPerk('Andromedon', 'MeleeResistance', PERK_ADD);
   AddUnitNaturalImmunity('Andromedon', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('Andromedon', 'Panic');

   ChangeUnitPerk('AndromedonRobot', 'MeleeResistance', PERK_ADD);

   ChangeUnitPerk('Gatekeeper', 'Regeneration', PERK_ADD);
   AddUnitNaturalImmunity('Gatekeeper', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('Gatekeeper', 'Panic');

   ChangeUnitPerk('Thrall', 'Bloodtrail', PERK_ADD);
   ChangeUnitPerk('Thrall', 'Sentinel', PERK_ADD);

   ChangeUnitPerk('Acolyte', 'WarmWelcome', PERK_ADD);
   ChangeUnitPerk('Acolyte', 'SteadyHands', PERK_ADD);
   
   ChangeUnitPerk('Sectoid_Resonant', 'DeepCover', PERK_ADD);

   ChangeUnitPerk('Muton_Brute', 'Bloodtrail', PERK_ADD);

   ChangeUnitPerk('Sorcerer', 'Solace', PERK_ADD);
   ChangeUnitPerk('Sorcerer', 'SteadyHands', PERK_ADD);

   // You have to give Overwatch via the weapon for Archon and Andromedon.
   // If you give them the ability directly it'll whine it doesn't have enough Ammo.
   ChangeUnitPerk('Archon', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('Archon', 'LightningReflexes', PERK_ADD);
   AddUnitNaturalImmunity('Archon', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('Archon', 'Panic');   
   ChangeUnitPerk('VIP_TPTier3B1_Archon', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('VIP_TPTier3B1_Archon', 'LightningReflexes', PERK_ADD);
   AddUnitNaturalImmunity('VIP_TPTier3B1_Archon', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('VIP_TPTier3B1_Archon', 'Panic');   
   ChangeUnitPerk('VIP_TPTier3B3_Archon', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('VIP_TPTier3B3_Archon', 'LightningReflexes', PERK_ADD);
   AddUnitNaturalImmunity('VIP_TPTier3B3_Archon', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('VIP_TPTier3B3_Archon', 'Panic');   

   ChangeUnitPerk('Cyberus', 'LightningReflexes', PERK_ADD);
   AddUnitNaturalImmunity('Cyberus', class'X2AbilityTemplateManager'.default.PanickedName);
   AddUnitNaturalImmunity('Cyberus', 'Panic');   

   // This is all the same unit, forget the names.
   ChangeUnitPerk('Liquidator', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('NeutralizeBountyVIP', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('EPICSHOTGUN1Carrying_Brute', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('EPICAR2Carrying_Commando', 'SteadyHands', PERK_ADD);
   ChangeUnitPerk('EPICAR1Carrying_Adder', 'SteadyHands', PERK_ADD);

   // This is all the same unit, forget the names.
   //ChangeUnitPerk('Bruiser', 'ReloadOnKill', PERK_ADD); You can never really kill an XCOM agent and it never triggers
   ChangeUnitPerk('Bruiser', 'HitWhereItHurts', PERK_ADD);
   //ChangeUnitPerk('EPICPISTOL1Carrying_Guardian', 'ReloadOnKill', PERK_ADD);
   ChangeUnitPerk('EPICPISTOL1Carrying_Guardian', 'HitWhereItHurts', PERK_ADD);

   ChangeUnitPerk('Hitman', 'ReflexGripAbility', PERK_ADD);
   ChangeUnitPerk('Hitman', 'ZeroIn', PERK_ADD);
   ChangeUnitPerk('EPICPISTOL2Carrying_Hitman', 'ReflexGripAbility', PERK_ADD);
   ChangeUnitPerk('EPICPISTOL2Carrying_Hitman', 'ZeroIn', PERK_ADD);

   ChangeUnitPerk('Muton_Bomber', 'BiggestBooms', PERK_ADD);
   ChangeUnitPerk('Muton_Bomber', 'DeepCover', PERK_ADD);
   ChangeUnitPerk('Muton_Bomber', 'VolatileMix', PERK_ADD);
   ChangeUnitPerk('EPICSHOTGUN2Carrying_Bomber', 'BiggestBooms', PERK_ADD);
   ChangeUnitPerk('EPICSHOTGUN2Carrying_Bomber', 'DeepCover', PERK_ADD);
   ChangeUnitPerk('EPICSHOTGUN2Carrying_Bomber', 'VolatileMix', PERK_ADD);

   // This is all the same unit, forget the names.
   ChangeUnitPerk('Viper_Cobra', 'LightningReflexes', PERK_ADD);
   ChangeUnitPerk('Viper_Cobra', 'SkirmisherReflex', PERK_ADD);
   ChangeUnitPerk('EPICSMG2Carrying_Resonant', 'LightningReflexes', PERK_ADD);
   ChangeUnitPerk('EPICSMG2Carrying_Resonant', 'SkirmisherReflex', PERK_ADD);

   // This is all the same unit, forget the names.
   ChangeUnitPerk('Sectoid_Necromancer', 'Solace', PERK_ADD);
   ChangeUnitPerk('Sectoid_Necromancer', 'BreakerRegeneration', PERK_ADD);
   ChangeUnitPerk('Sectoid_Necromancer', 'FondFarewell', PERK_ADD);
   
   ChangeUnitPerk('EPICSMG1Carrying_Dominator', 'Solace', PERK_ADD);
   ChangeUnitPerk('EPICSMG1Carrying_Dominator', 'BreakerRegeneration', PERK_ADD);
   ChangeUnitPerk('EPICSMG1Carrying_Dominator', 'FondFarewell', PERK_ADD);

   // ZOMBIES
   ChangeUnitPerk('PsiZombie', 'BreakerRegeneration', PERK_ADD);
   ChangeUnitPerk('SacredCoilTD_PsiZombie', 'BreakerRegeneration', PERK_ADD);
   ChangeUnitPerk('PsiZombieHuman', 'BreakerRegeneration', PERK_ADD);
   ChangeUnitPerk('SpectralZombieM2', 'BreakerRegeneration', PERK_ADD);

   // LEADERS
   ChangeUnitPerk('ConspiracyLeader', 'SkirmisherReflex', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'ReflexGripAbility', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'DeepCover', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'BlastPadding', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'Sentinel', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'WarmWelcome', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'FondFarewell', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'SteadyHands', PERK_ADD);
   
   ChangeUnitPerk('ProgenyLeader', 'Solace', PERK_ADD); // Psionic
   ChangeUnitPerk('ProgenyLeader', 'DeepCover', PERK_ADD);
   ChangeUnitPerk('ProgenyLeader', 'Fortress', PERK_ADD);
   ChangeUnitPerk('ProgenyLeader', 'SteadyHands', PERK_ADD);

   ChangeUnitPerk('SC_Leader', 'MeleeResistance', PERK_ADD); // Dual Wield
   ChangeUnitPerk('SC_Leader', 'HitWhereItHurts', PERK_ADD);
   ChangeUnitPerk('SC_Leader', 'SteadyHands', PERK_ADD);

   ChangeUnitPerk('GP_Leader', 'ShrugItOff', PERK_ADD); // Muton
   ChangeUnitPerk('GP_Leader', 'BiggestBooms', PERK_ADD);
   ChangeUnitPerk('GP_Leader', 'BlastPadding', PERK_ADD);
   ChangeUnitPerk('GP_Leader', 'BreakerRegeneration', PERK_ADD);
   ChangeUnitPerk('GP_Leader', 'VolatileMix', PERK_ADD);

   // Don't camp the Leaders please
   ChangeUnitPerk('ProgenyLeader', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('SC_Leader', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('GP_Leader', 'Shadowstep', PERK_ADD);
   ChangeUnitPerk('ConspiracyLeader', 'Shadowstep', PERK_ADD);
   // Remove for conflict in case.
   ChangeUnitPerk('ProgenyLeader', 'LightningReflexes', PERK_SUB);
   ChangeUnitPerk('SC_Leader', 'LightningReflexes', PERK_SUB);
   ChangeUnitPerk('GP_Leader', 'LightningReflexes', PERK_SUB);
   ChangeUnitPerk('ConspiracyLeader', 'LightningReflexes', PERK_SUB);

   ChangeUnitPerk('ConspiracyLeader', 'CloseCombatSpecialist', PERK_ADD);

   AddRadialOverwatchToWeapon('Archon_WPN');
   AddKillzoneOverwatchToWeapon('Andromedon_WPN');
   AddKillzoneOverwatchToWeapon('AdvMEC_M1_WPN');
   AddKillzoneOverwatchToWeapon('Cyberus_WPN');
}

static function AddRadialOverwatchToWeapon( name nWeaponName ) {
   local X2ItemTemplateManager                    AllItems;
   local X2WeaponTemplate                         CurrentWeapon;
   local X2DataTemplate					              DifficultyTemplate;
   local array<X2DataTemplate>		              DifficultyTemplates;

   AllItems         = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

   CurrentWeapon = X2WeaponTemplate(AllItems.FindItemTemplate(nWeaponName));
   if ( CurrentWeapon.bShouldCreateDifficultyVariants == true ) { // Difficulty variants
      AllItems.FindDataTemplateAllDifficulties(nWeaponName, DifficultyTemplates);
      foreach DifficultyTemplates(DifficultyTemplate) {
         CurrentWeapon = X2WeaponTemplate(DifficultyTemplate);
         CurrentWeapon.Abilities.RemoveItem('RadialOverwatch');
         CurrentWeapon.Abilities.RemoveItem('OverwatchShot');
         CurrentWeapon.Abilities.RemoveItem('Overwatch');
         CurrentWeapon.Abilities.AddItem('RadialOverwatch');
         CurrentWeapon.Abilities.AddItem('OverwatchShot');
      }
   } else { // One difficulty
      CurrentWeapon.Abilities.RemoveItem('RadialOverwatch');
      CurrentWeapon.Abilities.RemoveItem('OverwatchShot');
      CurrentWeapon.Abilities.RemoveItem('Overwatch');
      CurrentWeapon.Abilities.AddItem('RadialOverwatch');
      CurrentWeapon.Abilities.AddItem('OverwatchShot');
   }    
}

static function AddKillzoneOverwatchToWeapon( name nWeaponName ) {
   local X2ItemTemplateManager                    AllItems;
   local X2WeaponTemplate                         CurrentWeapon;
   local X2DataTemplate					              DifficultyTemplate;
   local array<X2DataTemplate>		              DifficultyTemplates;

   AllItems         = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

   CurrentWeapon = X2WeaponTemplate(AllItems.FindItemTemplate(nWeaponName));
   if ( CurrentWeapon.bShouldCreateDifficultyVariants == true ) { // Difficulty variants
      AllItems.FindDataTemplateAllDifficulties(nWeaponName, DifficultyTemplates);
      foreach DifficultyTemplates(DifficultyTemplate) {
         CurrentWeapon = X2WeaponTemplate(DifficultyTemplate);
         CurrentWeapon.Abilities.RemoveItem('KillZoneOverwatch');
         CurrentWeapon.Abilities.RemoveItem('OverwatchShot');
         CurrentWeapon.Abilities.RemoveItem('Overwatch');
         CurrentWeapon.Abilities.AddItem('KillZoneOverwatch');
         CurrentWeapon.Abilities.AddItem('OverwatchShot');
      }
   } else { // One difficulty
      CurrentWeapon.Abilities.RemoveItem('KillZoneOverwatch');
      CurrentWeapon.Abilities.RemoveItem('OverwatchShot');
      CurrentWeapon.Abilities.RemoveItem('Overwatch');
      CurrentWeapon.Abilities.AddItem('KillZoneOverwatch');
      CurrentWeapon.Abilities.AddItem('OverwatchShot');   
   }    
}

static function AddUnitNaturalImmunity( name nUnitName, name nImmuneType ) {
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
            CurrentUnit.ImmuneTypes.RemoveItem(nImmuneType);
            CurrentUnit.ImmuneTypes.AddItem(nImmuneType);
         }
	   } else {
         CurrentUnit = X2CharacterTemplate(DifficultyTemplate);
         CurrentUnit.ImmuneTypes.RemoveItem(nImmuneType);
         CurrentUnit.ImmuneTypes.AddItem(nImmuneType);
      }
   } else {
      `log("AddUnitNaturalImmunity: Current Unit is NONE.");
   }
}