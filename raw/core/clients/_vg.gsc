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

OnCMenuResponse(args)
{
	if (!IsDefined(self.VG) || args.sMenuName != core\include\clients\_menu::GetMenu("vg"))
		return;

	if (IsDefined(self.VG.bIsWorking)) // sending dvars have not finished yet...
		return;
	
	if (args.sResponse == "vgClose")
		self.VG core\include\clients\_vg::OnClose();
	else if (args.sResponse == "vgEsc")
		self.VG core\include\clients\_vg::OnEsc();
	else if (args.sResponse == "vgBtn")
		self.VG core\include\clients\_vg::Menu_OnBtn(Int(args.ResponseArgs[1]) - 1);
	else if (args.sResponse == "vgSBtn")
		return; // arrows, enter, backSpace, ...
	else if (args.sResponse == "vgT")
	{
		if (args.ResponseArgs[1] == "Cancel")
			self.VG core\include\clients\_vg::TextBox_OnCancel();
		else if (args.ResponseArgs[1] == "OK")
			self.VG core\include\clients\_vg::TextBox_OnOK();
		else
			core\include\_exception::ArgumentMsg("Unknown VG notify '" + args.sResponse + "'");
	}
	else
		core\include\_exception::ArgumentMsg("Unknown VG notify '" + args.sResponse + "'");
}

OnCKilled()
{
	if (IsDefined(self.VG))
		self.VG core\include\clients\_vg::Close();
}