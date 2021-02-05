class X2DownloadableContentInfo_ProjectRoswellEP extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated() {
   local X2CharacterTemplateManager	       AllCharacters;
   local X2CharacterTemplate		          CurrentUnit;

   local array<name> nAllCharacterNames;

   local name CurrentName;

   AllCharacters    = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

   AllCharacters.GetTemplateNames(nAllCharacterNames);

   foreach nAllCharacterNames ( CurrentName ) {
      CurrentUnit = AllCharacters.FindCharacterTemplate( CurrentName );

      // EXPLICIT EXCEPTIONS:
      switch( CurrentName ) {
         case 'Berserker':
            goto SkipLoop;
         case 'Sectopod':
            goto SkipLoop;
         case 'AdvTurretM1':
            goto SkipLoop;
         case 'AndromedonRobot':
            goto SkipLoop;
         case 'PsiZombie':
            goto SkipLoop;
         case 'PsiZombieHuman':
            goto SkipLoop;
         case 'SpectralZombieM2':
            goto SkipLoop;
         case 'ChryssalidCocoon':
            goto SkipLoop;
         case 'ChryssalidCocoonHuman':
            goto SkipLoop;
      }

      CurrentUnit.Abilities.RemoveItem('DelayTurn'); // Prevents duplication
      CurrentUnit.Abilities.AddItem('DelayTurn');

      SkipLoop:
   }

   `log("ProjectRoswellEP: DelayTurn added to all units.");
}