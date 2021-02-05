class UICustomListener extends UIScreenListener;
var UITacticalHUD            HookScreen;

event OnInit(UIScreen Screen)
{
    `log("FOUND A TACTICALHUD", , '--------------------------------------------------------');
    `log("FOUND A TACTICALHUD", , '--------------------------------------------------------');
    `log("FOUND A TACTICALHUD", , '--------------------------------------------------------');
    `log("FOUND A TACTICALHUD", , '--------------------------------------------------------');
    `log("FOUND A TACTICALHUD", , '--------------------------------------------------------');

    HookScreen = UITacticalHUD(Screen);
    if (HookScreen == None)
        return;

    Abilities();
    Targets();
}

function Abilities(){
    local array<UITacticalHUD_Ability>      HUD_Ability_array;
    local int i;

    HUD_Ability_Array = HookScreen.m_kAbilityHUD.m_arrUIAbilities;
    
    for(i = 0; i < HUD_Ability_Array.Length; i++){
        HUD_Ability_Array[i].SetPanelScale(1.5);
        HUD_Ability_Array[i].SetPosition(i*65-0,-155);
    }
}

function Targets(){ 
        HookScreen.m_kEnemyTargets.SetPanelScale(1.5); 
}

defaultproperties
{
    ScreenClass = UITacticalHUD;
}