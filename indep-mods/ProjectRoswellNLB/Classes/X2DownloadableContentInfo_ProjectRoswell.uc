class X2DownloadableContentInfo_ProjectRoswellNLB extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager TemplateManager;

	`log("-------------------------------", , 'NonLethalBind');
	`log("-------------------------------", , 'NonLethalBind');
	`log("-------------------------------Project Roswell: NonLethalBind Mod is Active", , 'NonLethalBind');
	`log("-------------------------------", , 'NonLethalBind');
	`log("-------------------------------", , 'NonLethalBind');

	TemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AddCaptureFlag(TemplateManager.FindAbilityTemplate('InquisitorBind'));
	AddCaptureFlag(TemplateManager.FindAbilityTemplate('InquisitorBindSustained'));
}

static function AddCaptureFlag(X2AbilityTemplate Template) {
	local int i;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	for (i = 0; i < Template.AbilityTargetEffects.Length; i++) {
		WeaponDamageEffect = X2Effect_ApplyWeaponDamage(Template.AbilityTargetEffects[i]);

		if (WeaponDamageEffect != None) {
			WeaponDamageEffect.bCaptureInsteadOfKill = true;
			break;
		}
	}
}
