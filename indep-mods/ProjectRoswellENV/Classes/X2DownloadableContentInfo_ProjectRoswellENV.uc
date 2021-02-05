class X2DownloadableContentInfo_ProjectRoswellENV extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated() {
   ReduceEnvironmentalDamageAbility('AutoTakedown');
   ReduceEnvironmentalDamageAbility('RiotBash');
   ReduceEnvironmentalDamageAbility('ChargedBash');
   ReduceEnvironmentalDamageAbility('Takedown');

   ReduceEnvironmentalDamageWeapon('PsiZombie_MeleeAttack', 1);
   ReduceEnvironmentalDamageWeapon('ArchonStaff', 5);

   ReduceEnvironmentalDamageAbility('Inquisitor_PoisonSpit');
}

static function ReduceEnvironmentalDamageAbility ( name AbilityName ) {
   local X2AbilityTemplateManager	          AllAbilities;
   local X2AbilityTemplate                    CurrentAbility;
   local X2Effect                             TempEffect;
   local X2Effect_ApplyWeaponDamage           WeaponEffect;
   
   AllAbilities     = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

   CurrentAbility = AllAbilities.FindAbilityTemplate(AbilityName);
   foreach CurrentAbility.AbilityTargetEffects( TempEffect ) {
      if ( TempEffect != none ) {
         if ( TempEffect.IsA('X2Effect_ApplyWeaponDamage') ) {
            WeaponEffect = X2Effect_ApplyWeaponDamage(TempEffect);
            WeaponEffect.EnvironmentalDamageAmount = 0;
			   `log(AbilityName $ " was patched successfully, environmental damage adjusted.");
         }
      }
   }
}

static function ReduceEnvironmentalDamageWeapon ( name WeaponName, int iNewValue ) {
   local X2ItemTemplateManager                    AllItems;
   local X2WeaponTemplate                         CurrentWeapon;
   local X2DataTemplate					              DifficultyTemplate;
   local array<X2DataTemplate>		              DifficultyTemplates;

   AllItems         = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

   CurrentWeapon = X2WeaponTemplate(AllItems.FindItemTemplate(WeaponName));
   if ( CurrentWeapon.bShouldCreateDifficultyVariants == true ) { // Difficulty variants
      AllItems.FindDataTemplateAllDifficulties(WeaponName, DifficultyTemplates);
      foreach DifficultyTemplates(DifficultyTemplate) {
          CurrentWeapon.iEnvironmentDamage = iNewValue;
      }
      `log(WeaponName $ " was patched successfully, environmental damage adjusted.");
   } else { // One difficulty
      CurrentWeapon.iEnvironmentDamage = iNewValue;
      `log(WeaponName $ " was patched successfully, environmental damage adjusted.");
   }
}
