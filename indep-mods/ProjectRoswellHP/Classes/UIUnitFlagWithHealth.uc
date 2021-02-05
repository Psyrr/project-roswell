class UIUnitFlagWithHealth extends UIUnitFlag config(Game);

var config bool OnlyShowInBreach;
var config bool OnlyShowEnemies;

var UIText HPValueBox;


simulated function RealizeHitPoints(optional XComGameState_Unit NewUnitState = none, optional bool bForceUpdate =false )
{
	local bool IsBreaching;

	super.RealizeHitPoints(NewUnitState, bForceUpdate);

	IsBreaching = `BATTLE.GetDesc().bInBreachPhase;
	
	if( NewUnitState == none )
	{
		NewUnitState = XComGameState_Unit(History.GetGameStateForObjectID(StoredObjectID));
	}

	if (HPValueBox == none) {
		HPValueBox = Spawn(class'UIText', self).InitText('HPValueText');
		HPValueBox.SetX(-1);
		HPValueBox.SetY(-6);
	}

	if( NewUnitState.IsSoldier() || NewUnitState.GetMyTemplate().bTreatAsSoldier)
	{
		if (!default.OnlyShowEnemies && (!default.OnlyShowInBreach || IsBreaching)) {
			HPValueBox.SetText("(" $ int(NewUnitState.GetCurrentStat(eStat_HP)) $ "/" $ int(NewUnitState.GetMaxStat(eStat_HP)) $ ")");
			HPValueBox.Show();
		}
		else {
			HPValueBox.Hide();
		}
	}
	else if( NewUnitState.IsCivilian() )
	{
	}
	else // alien
	{
		if (!default.OnlyShowInBreach || IsBreaching) {
			HPValueBox.SetText("(" $ int(NewUnitState.GetCurrentStat(eStat_HP)) $ "/" $ int(NewUnitState.GetMaxStat(eStat_HP)) $ ")");
			HPValueBox.Show();
		} else {
			HPValueBox.Hide();
		}
	}
}



simulated function Remove()
{
	if (HPValueBox != none) {
		HPValueBox.Remove();
	}

	super.Remove();
}