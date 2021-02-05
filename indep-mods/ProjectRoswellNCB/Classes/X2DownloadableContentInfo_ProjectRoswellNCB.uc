class X2DownloadableContentInfo_ProjectRoswellNCB extends X2DownloadableContentInfo;

struct BreachModConflicts
{
	var name Mod_A;
	var name Mod_B;
};

var config array<BreachModConflicts> ConflictDelcates;

// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
// DLC/Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
// create without the content installed. Subsequent saves will record that the content was installed.

static event OnLoadedSavedGame()
{	
}

// This method is run when the player loads a saved game directly into Strategy while this DLC is installed

static event OnLoadedSavedGameToStrategy()
{

}

// Called when the player starts a new campaign while this DLC / Mod is installed. When a new campaign is started the initial state of the world
// is contained in a strategy start state. Never add additional history frames inside of InstallNewCampaign, add new state objects to the start state
// or directly modify start state objects

static event InstallNewCampaign(XComGameState StartState)
{

}

// Called just before the player launches into a tactical a mission while this DLC / Mod is installed.
// Allows dlcs/mods to modify the start state before launching into the mission

static event OnPreMission(XComGameState StartGameState, XComGameState_MissionSite MissionState)
{

}

// Called when the player completes a mission while this DLC / Mod is installed.

static event OnPostMission()
{

}

// Called when the player is doing a direct tactical->tactical mission transfer. Allows mods to modify the
// start state of the new transfer mission if needed

static event ModifyTacticalTransferStartState(XComGameState TransferStartState)
{

}


// Called after the player exits the post-mission sequence while this DLC / Mod is installed.

static event OnExitPostMissionSequence()
{

}

// Called after the Templates have been created (but before they are validated) while this DLC / Mod is installed.

static event OnPostTemplatesCreated()
{
	local BreachModifierFilter					Filter, EmptyFilter;
	local X2BreachPointTypeTemplate				BreachTemplate;
	local X2TacticalElementTemplateManager		TemplateMgr;
	local array<name>							DataNames;
	local name									DataName, DistributionName;

	TemplateMgr = class'X2TacticalElementTemplateManager'.static.GetTacticalElementTemplateManager();
	TemplateMgr.GetTemplateNames(DataNames);
	foreach DataNames(DataName)
	{
		BreachTemplate = X2BreachPointTypeTemplate(TemplateMgr.FindTacticalElementTemplate(DataName));
		if (BreachTemplate != none)
		{
			DistributionName = 'RandomNoneOneTwo';

			if (class'X2TacticalElement_DefaultBreachPointTypes'.default.ModifierDistributionByBreachPointType.Length > 0
				&& class'X2TacticalElement_DefaultBreachPointTypes'.default.ModifierDistributionByBreachPointType.Length >= BreachTemplate.Type)
			{
				DistributionName = class'X2TacticalElement_DefaultBreachPointTypes'.default.ModifierDistributionByBreachPointType[BreachTemplate.Type];
			}

			if (DistributionName == 'RandomNoneOneTwo')
			{
				`log(BreachTemplate.DataName @ "patched conflicted detection RandOneOrNone",, 'ConflictRemover');
				BreachTemplate.ModifierInfo.AdditionalModifiersFilters[0].Func = BreachModifierFilter_RandomSelectOneorTwo;
			}

			`log(BreachTemplate.DataName @ "patched conflicted detection",, 'ConflictRemover');
			Filter = EmptyFilter;
			Filter.Func = BreachModifierFilter_RemoveConflicting;
			BreachTemplate.ModifierInfo.AdditionalModifiersFilters.InsertItem(0, Filter);
		}
	}
}


// Called when the difficulty changes and this DLC is active

static event OnDifficultyChanged()
{

}

/// <summary>
/// Called by the Geoscape tick
/// </summary>
static event UpdateDLC()
{

}

// Called after HeadquartersAlien builds a Facility

static event OnPostAlienFacilityCreated(XComGameState NewGameState, StateObjectReference MissionRef)
{

}


// Called after a new Alien Facility's doom generation display is completed

static event OnPostFacilityDoomVisualization()
{

}

// Called when viewing mission blades, used primarily to modify tactical tags for spawning
// Returns true when the mission's spawning info needs to be updated

static function bool ShouldUpdateMissionSpawningInfo(StateObjectReference MissionRef)
{
	return false;
}

// Called when viewing mission blades, used primarily to modify tactical tags for spawning
// Returns true when the mission's spawning info needs to be updated

static function bool UpdateMissionSpawningInfo(StateObjectReference MissionRef)
{
	return false;
}

// Called when viewing mission blades, used to add any additional text to the mission description

static function string GetAdditionalMissionDesc(StateObjectReference MissionRef)
{
	return "";
}

// Called from X2AbilityTag:ExpandHandler after processing the base game tags. Return true (and fill OutString correctly)
// to indicate the tag has been expanded properly and no further processing is needed.

static function bool AbilityTagExpandHandler(string InString, out string OutString)
{
	return false;
}

// Called from XComGameState_Unit:GatherUnitAbilitiesForInit after the game has built what it believes is the full list of
// abilities for the unit based on character, class, equipment, et cetera. You can add or remove abilities in SetupData.

static function FinalizeUnitAbilitiesForInit(XComGameState_Unit UnitState, out array<AbilitySetupData> SetupData, optional XComGameState StartState, optional XComGameState_Player PlayerState, optional bool bMultiplayerDisplay)
{

}

// Calls DLC specific popup handlers to route messages to correct display functions

static function bool DisplayQueuedDynamicPopup(DynamicPropertySet PropertySet)
{

}

static function bool IsBreachModConflicting(array<name> ChosenMods, X2BreachPointModifierTemplate Modifier)
{
	local BreachModConflicts ModConflict;

	if (ChosenMods.Find(Modifier.DataName) != INDEX_NONE)
	{
		return true;
	}
	
	foreach default.ConflictDelcates(ModConflict)
	{
		if (ModConflict.Mod_A == Modifier.DataName)
		{
			`log(Modifier.DataName @ "is MOD A, check if" @ ModConflict.Mod_B @ "exists",, 'ConflictRemover');
			if (ChosenMods.Find(ModConflict.Mod_B) != INDEX_NONE)
			{
				`log(ModConflict.Mod_B @ "is conflict, removing",, 'ConflictRemover');
				return true;
			}
		}
		else if (ModConflict.Mod_B == Modifier.DataName)
		{
			`log(Modifier.DataName @ "is MOD B, check if" @ ModConflict.Mod_A @ "exists",, 'ConflictRemover');
			if (ChosenMods.Find(ModConflict.Mod_A) != INDEX_NONE)
			{
				`log(ModConflict.Mod_A @ "is conflict, removing",, 'ConflictRemover');
				return true;
			}
		}
	}

	return false;
}

static function BreachModifierFilter_RemoveConflicting(const out BreachModifierFilter FilterInfo, const array<X2BreachPointModifierTemplate> Modifiers, const out array<X2BreachPointModifierTemplate> AlreadySelectedModifiers, const out array<X2BreachPointModifierTemplate> ChosenAvailableModifiers, out array<X2BreachPointModifierTemplate> OutModifiers, const out int PointIndex, const out int NumBreachPoints)
{
	local X2BreachPointModifierTemplate						Modifier;
	local array<name>										SelectedNames;

	foreach ChosenAvailableModifiers(Modifier)
	{
		`log(Modifier.DataName @ "is already chosen for this mission type",, 'ConflictRemover');
		SelectedNames.AddItem(Modifier.DataName);
	}

	foreach Modifiers(Modifier)
	{
		if (!IsBreachModConflicting(SelectedNames, Modifier)) 
		{
			`log(Modifier.DataName @ "has no conflicts and is elligible for picking",, 'ConflictRemover');
			OutModifiers.AddItem(Modifier);
		}
	}
}

static function BreachModifierFilter_RandomSelectOneorTwo(const out BreachModifierFilter FilterInfo, const array<X2BreachPointModifierTemplate> Modifiers, const out array<X2BreachPointModifierTemplate> AlreadySelectedModifiers, const out array<X2BreachPointModifierTemplate> ChosenAvailableModifiers, out array<X2BreachPointModifierTemplate> OutModifiers, const out int PointIndex, const out int NumBreachPoints)
{
	local X2BreachPointModifierTemplate				SelectedModifier, Modifier;
	local int										ModLength, i, RandIndex, NegModifierCount;
	local array<name>								SelectedNames;
	local array<X2BreachPointModifierTemplate> 		RemainingModifiers;

	if (ChosenAvailableModifiers.length >= 2)
		return; // No more than 2 modifiers MAX including always-on ones

	foreach ChosenAvailableModifiers(Modifier)
	{
		`log(Modifier.DataName @ "is already chosen for this mission type",, 'ConflictRemover');
		SelectedNames.AddItem(Modifier.DataName);
	}

	foreach Modifiers(Modifier)
	{
		if (!IsBreachModConflicting(SelectedNames, Modifier)) 
		{
			`log(Modifier.DataName @ "has no conflicts and is elligible for picking",, 'ConflictRemover');
			RemainingModifiers.AddItem(Modifier);
		}
	}

	ModLength = RemainingModifiers.length;

	if (ModLength == 0)
	{
		return;
	}

	if (`SYNC_RAND_STATIC(100) < 75 && ChosenAvailableModifiers.length > 0)
	{
		// high chance we'll have 0 additional modifiers
	}	
	else if (`SYNC_RAND_STATIC(100) < 75 || ChosenAvailableModifiers.length > 0)
	{
		RandIndex = `SYNC_RAND_STATIC(ModLength);
		SelectedModifier = RemainingModifiers[RandIndex];
		OutModifiers.AddItem(SelectedModifier);
		RemainingModifiers.Remove(RandIndex, 1);
		SelectedNames.AddItem(SelectedModifier.DataName);
		// choose one modifier due to chance, or because we already have one modifier
	}
	else
	{
		for (i = 0; i < 2; i++)
		{
			if (ModLength == 0)
			{
				break;
			}

			RandIndex = `SYNC_RAND_STATIC(ModLength);
			SelectedModifier = RemainingModifiers[RandIndex];

			if ((!SelectedModifier.bGood && NegModifierCount > 0) ||
				IsBreachModConflicting(SelectedNames, SelectedModifier))
			{
				i--;
				RemainingModifiers.Remove(RandIndex, 1);
				ModLength = RemainingModifiers.Length;
				continue;
			}

			if (!SelectedModifier.bGood)
			{
				NegModifierCount++;
			}

			OutModifiers.AddItem(SelectedModifier);
			RemainingModifiers.Remove(RandIndex, 1);
			ModLength = RemainingModifiers.Length;
			SelectedNames.AddItem(SelectedModifier.DataName);
		}
	}
}