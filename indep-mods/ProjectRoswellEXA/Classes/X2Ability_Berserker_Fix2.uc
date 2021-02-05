class X2Ability_Berserker_Fix2 extends X2Ability_Berserker config(GameData_SoldierSkills);

static function X2AbilityTemplate CreateMeleeResistanceAbility() {
	local X2AbilityTemplate Template;
	local X2AbilityTargetStyle TargetStyle;
	local X2Effect_MeleeDamageAdjust_Fixed2 MeleeArmor;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MeleeResistance');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_absorption_fields";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	// This ability will only be targeting the unit it is on
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	// Triggers at the start of the tactical
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	MeleeArmor = new class'X2Effect_MeleeDamageAdjust_Fixed2';
	MeleeArmor.BuildPersistentEffect(1, true, true, true);
	MeleeArmor.DamageMod = -2;
    MeleeArmor.EffectName = 'MeleeResistanceEffect';
	MeleeArmor.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, , , Template.AbilitySourceName);
	
    Template.AddTargetEffect(MeleeArmor);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate CreateSuperMeleeResistanceAbility() {
	local X2AbilityTemplate Template;
	local X2AbilityTargetStyle TargetStyle;
	local X2Effect_MeleeDamageAdjust_Fixed2 MeleeArmor;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'SuperMeleeResistance');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_absorption_fields";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	// This ability will only be targeting the unit it is on
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	// Triggers at the start of the tactical
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	MeleeArmor = new class'X2Effect_MeleeDamageAdjust_Fixed2';
	MeleeArmor.BuildPersistentEffect(1, true, true, true);
	MeleeArmor.DamageMod = -4;
    MeleeArmor.EffectName = 'SuperMeleeResistanceEffect';
	MeleeArmor.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, , , Template.AbilitySourceName);
	
    Template.AddTargetEffect(MeleeArmor);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}