//I========================================================================I
//I                    ___  _____  _____                                   I
//I                   /   !!  __ \!  ___!                                  I
//I                  / /! !! !  \/! !_          ___  ____                  I
//I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//I                     !_/ \____/\_!     (_)  \___!/___!                  I
//I                                                                        I
//I========================================================================I
// Call of Duty 4: Modern Warfare
//I========================================================================I
// Mod      : Core
// Website  : http://www.4gf.cz/
//I========================================================================I
// Script by: PetX
//I========================================================================I

#include core\include\_usings;

 AddMenu(name, menuFile)
{
	game["menu_" + name] = menuFile;
	precacheMenu(game["menu_" + name]);
}

 GetMenu(name)
{
	return game["menu_" + name];
}

 GetOpenedMenu()
{
	return self.OpenedMenu;
}

 SetOpenedMenu(sMenuName, sResponse, responseArgs)
{
	self.OpenedMenu = SpawnStruct();
	self.OpenedMenu.sMenuName = sMenuName;
	
	args = core\include\_eventCallback::Args_Create();
	args.sMenuName = sMenuName;
	args.sResponse = sResponse;
	args.ResponseArgs = responseArgs;
	args.OpenedMenu = self.OpenedMenu;
	self core\_init::RunOnCMenuOpened(args);
}