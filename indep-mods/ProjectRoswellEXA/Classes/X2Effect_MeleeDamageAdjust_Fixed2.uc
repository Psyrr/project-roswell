class X2Effect_MeleeDamageAdjust_Fixed2 extends X2Effect_MeleeDamageAdjust;

function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, 
										const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect, optional XComGameState NewGameState)
{
	local X2AbilityToHitCalc_StandardAim ToHitCalc;

	local int iExcess;

	// The damage effect's DamageTypes must be empty or have melee in order to adjust the damage
	if( (WeaponDamageEffect.EffectDamageValue.DamageType == MeleeDamageTypeName) || (WeaponDamageEffect.DamageTypes.Find(MeleeDamageTypeName) != INDEX_NONE) ||
		((WeaponDamageEffect.EffectDamageValue.DamageType == '') && (WeaponDamageEffect.DamageTypes.Length == 0)) )
	{
		ToHitCalc = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if (ToHitCalc != none && ToHitCalc.bMeleeAttack)
		{
		   // EXAMPLES
		   // Damage received: 5+ Melee Resistance: -4 Function returns -4 always
		   // Damage received: 4 Melee Resistance: -4 Function Returns -3 (Only -3 is required to get to 1 damage)
		   // Damage received: 3 Melee Resistance: -4 Function Returns -2
		   // Damage received: 2 Melee Resistance: -4 Function Returns -1
		   // Damage received: 1 Melee Resistance: -4 Function Returns 0

		   // Damage received: 3+ Melee Resistance: -2 Function Returns -2
		   // Damage received: 2 Melee Resistance: -2 Function Returns -1
		   // Damage received: 1 Melee Resistance: -2 Function Returns 0

		   // Also fixes cases where if you dealt 3 damage to a SuperMelee target, it would heal by 1.

		   if ( (-1 * DamageMod) >= CurrentDamage ) {
		      // How much did we exceed it by? For example, 2 Damage 4 Melee Resistance is 2 excess
			  iExcess = (-1 * DamageMod) - CurrentDamage;
			  // Return the DamageMod value, plus the excess, plus 1 for minimum 1 damage (-4 + 2 + 1) = 1 Damage Resistance.
			  return ( DamageMod + iExcess + 1 );
		   }

		   return DamageMod; // Apply the full bonus.
		}
	}
	
	return 0;
}

defaultproperties
{
	MeleeDamageTypeName="melee"
	bDisplayInSpecialDamageMessageUI = true
}
