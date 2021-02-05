class X2DownloadableContentInfo_ProjectRoswellBB extends X2DownloadableContentInfo;

    // This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the
    // DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
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
// Allows DLCs/Mods to modify the start state before launching into the mission

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

}

// Called when the difficulty changes and this DLC is active

static event OnDifficultyChanged()
{

}

// Called by the Geoscape tick

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