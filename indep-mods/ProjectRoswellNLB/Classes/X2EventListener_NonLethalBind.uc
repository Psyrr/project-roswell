class X2EventListener_NonLethalBind extends X2EventListener;
const SHOWDEBUG = False;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Templates;

    Log("X2EventListener_NonLethalBind.CreateTemplates       Run 05", 10);
    Templates.AddItem(Create_Listener_Template());

    return Templates;
}

static function X2EventListenerTemplate Create_Listener_Template()
{
    local X2EventListenerTemplate Template;

    Log("X2EventListener_NonLethalBind.Create_Listener_Template");
    `CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template, 'NonLethalBindListener');

    Template.RegisterInTactical = true;
    Template.RegisterInStrategy = false;

    Template.AddEvent('UnitTakeEffectDamage', OnTriggered);

    return Template;
}

static function EventListenerReturn OnTriggered(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
    local XComGameState_Unit Unit;
    local XComGameState NewGameState;
   	local X2Effect_ApplyWeaponDamage DamageEffect;
	local EffectAppliedData ApplyData;
    local int hp, NumEffects, i;

    Log(".");
    Log("X2EventListener_NonLethalBind.OnTriggered");

    Unit = XComGameState_Unit(EventSource);

    hp = Unit.GetCurrentStat(eStat_HP);

    Log("Event: " @ Event @ " Event Source: " @ EventSource @ " EventData: " @ EventData @ " Callback: " @ CallbackData);
    Log("Unit: " @ Unit @ " Name: " @ Unit.GetMyTemplateName() @ " HP: " @ hp @ "  Bound: " @ Unit.IsBound() @ "  Alive: " @ Unit.IsAlive() @ "  Uncon: " @ Unit.IsUnconscious() 
        @ "  Team: " @ Unit.GetTeam() @ "Is Unit VIP: " @ Unit.GetMyTemplate().bIsVIP @ ("  ObjID: " $ Unit.ObjectID));
 
    if (hp < 1 && Unit.IsBound()){
        Log("Unit HP<1 and is Bound.");

        if(Unit.IsImmuneToDamage('Unconscious')){
            Log("IsImmune: TRUE!");
            return ELR_NoInterrupt;
        }
        if(Unit.GetMyTemplateName() == 'Cyberus'){
            Log("Cyberus Detected!");        
            return ELR_NoInterrupt;
        }

        NumEffects = Unit.AppliedEffectNames.Length;
        for(i = 0; i < NumEffects; i++){
            if (Unit.AppliedEffectNames[i] == 'BindSustainedEffect'){
                Log("Unit is the one binding!");
                return ELR_NoInterrupt;
            }
        }

        Log("Unit Passed Checks, rendering unconscious.");
        NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Setting Unit Value");
        Unit = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', Unit.ObjectID));

        Unit.SetCurrentStat(eStat_HP, 1);

        DamageEffect = new class'X2Effect_ApplyWeaponDamage';
        DamageEffect.EffectDamageValue.Damage = 1000;
        DamageEffect.bHideDeathWorldMessage = false;
        DamageEffect.bCaptureInsteadOfKill = true;
        
        ApplyData.AbilityResultContext.HitResult = eHit_Success;
        ApplyData.TargetStateObjectRef = Unit.GetReference();


        DamageEffect.ApplyEffect( ApplyData, Unit, NewGameState );

        `XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
        Log("Unconscious damage applied.");
    } else {
        Log("Unit>=1hp, or not bound.");
    }

    return ELR_NoInterrupt;
}

simulated static function Log(string Text, optional int count=1){
    local int i;

    if(SHOWDEBUG){
        const TAG = '-----------------------X2EventListener_NonLethalBind-';

        for(i=0; i<count;i++)
            `log(Text, ,TAG);
    }
}

