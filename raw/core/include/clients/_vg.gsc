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




 Create(pOwner)
{
	vg = SpawnStruct();
	
	vg.pOwner = pOwner;
	pOwner.VG = vg;
	
	pOwner OpenMenu(core\include\clients\_menu::GetMenu("vg"));
	
	vg.bIsWorking = undefined;
	
	vg.TextLines = [];
	vg.AddTextLines = [];
	
	vg.PrevMenu = [];
	vg.Menu = [];
	
	return vg;
}

 OnEsc()
{
	if (self.PrevMenu.size > 0)
		self Menu_OnBackBtn();
	else
		self Close();
}

 OnClose()
{
	// another menu opened(scoreboard, main menu, etc.)
	self.bIsWorking = true;

	wait 0.1;
	
	self.pOwner CloseMenu();
	self.pOwner CloseInGameMenu();
	
	wait 0.1;
	
	self.pOwner OpenMenu(core\include\clients\_menu::GetMenu("vg"));
	self.bIsWorking = undefined;
}

 Close()
{
	self notify("close");
	self.pOwner.VG = undefined;
	self.pOwner CloseMenu();
	self.pOwner CloseInGameMenu();
}

// ==================================================================================== //


 Menu_Clear(bBackBtn, dOnClose)
{
	if ((IsDefined(bBackBtn) && bBackBtn) || !IsDefined(bBackBtn))
		self.PrevMenu[self.PrevMenu.size] = self.Menu;
		
	self.Menu = [];
	self.Menu["dOnClose"] = dOnClose;
}

 Menu_RegisterBtn(iBtn, sText, dFunc, bTurnable)
{
	if (IsDefined(bTurnable))
		bTurnable = false;
	else
		bTurnable = undefined;
		
	{ self.Menu[iBtn]["sText"] = sText; self.Menu[iBtn]["dFunc"] = dFunc; self.Menu[iBtn]["bTurnable"] = bTurnable; }
}

 Menu_Show()
{
	iLines = self.Menu.size + 1;
	if (IsDefined(self.Menu["dOnClose"]))
		iLines--; // hack for array & dictionary in one
	
	//iInc = MenuSlots - iLines;
	
	self Menu_ClearBtns();
	
	for (i = 0; i < iLines - 1; i++)
		self Menu_SetBtn(i, "[^3" + (i + 1) + "^7] " + self.Menu[i]["sText"]);
	
	if (self.PrevMenu.size > 0)
		self Menu_SetBtn((iLines - 1), "[^3ESC^7] Back");
	else
		self Menu_SetBtn((iLines - 1), "[^3ESC^7] Exit");
}

 Menu_OnBtn(iBtn)
{
	item = self.Menu[iBtn];
	if (IsDefined(item))
	{
		if (IsDefined(item["bTurnable"]))
		{
			if (item["bTurnable"])
				self Menu_TurnBtnOff(iBtn);
			else
				self Menu_TurnBtnOn(iBtn);
		}
		
		self [[item["dFunc"]]]();
	}
}

 Menu_OnBackBtn()
{
	if (IsDefined(self.Menu["dOnClose"]))
		self [[self.Menu["dOnClose"]]]();

	self.Menu = self.PrevMenu[self.PrevMenu.size - 1];
	self.PrevMenu[self.PrevMenu.size - 1] = undefined;
	
	self Menu_Show();
}

 Menu_TurnBtnOn(iBtn)
{
	self.Menu[iBtn]["bTurnable"] = true;
	self Menu_SetBtn(iBtn, "[^3" + (iBtn + 1) + "^7] ^1" + self.Menu[iBtn]["sText"]);
}

 Menu_TurnBtnOff(iBtn)
{
	self.Menu[iBtn]["bTurnable"] = false;
	self Menu_SetBtn(iBtn, "[^3" + (iBtn + 1) + "^7] " + self.Menu[iBtn]["sText"]);
}

 Menu_SetBtn(iLine, sText)
{
	core\include\_exception::Argument(iLine < 9);
	
	iStart = 37 - 9;
	
	iLines = self.Menu.size + 1;
	if (IsDefined(self.Menu["dOnClose"]))
		iLines--; // hack for array & dictionary in one
		
	iInc = 9 - iLines;
	self.pOwner core\include\clients\_dev::SetInfo(iStart + iInc + iLine, sText);
}

 Menu_ClearBtns()
{
	iStart = 37 - 9;
	for (i = 0; i < 9; i++)
		self.pOwner core\include\clients\_dev::SetInfo(iStart + i, "");
}


// ==================================================================================== //

 TextSet(iLine, sText)
{
	core\include\_exception::Argument(iLine < 37 - 9);
	
	if (!core\include\_type::IsEqual(sText, self.TextLines[iLine]))
	{
		self.TextLines[iLine] = sText;
		self.pOwner core\include\clients\_dev::SetInfo(iLine, sText);
	}
}

 TextClear(iStartLine)
{
	if (!IsDefined(iStartLine)) iStartLine = 0;
	
	for (i = iStartLine; i < 37 - 9; i++)
		self TextSet(i, "");
}

 AddTextSet(iLine, sText)
{
	if (!core\include\_type::IsEqual(sText, self.AddTextLines[iLine]))
	{
		self.AddTextLines[iLine] = sText;
		self.pOwner SetClientDvar("ui_vgAddI" + iLine, sText);
	}
}

 AddTextClear(iStartLine)
{
	if (!IsDefined(iStartLine)) iStartLine = 0;
	
	for (i = iStartLine; i < 37 - 1; i++)
		self AddTextSet(i, "");
}

// ==================================================================================== //


 TextBox_Show(sTitle, dOnOK, dOnCancel, sTextA, sTextB, sTextC)
{
	if (!IsDefined(sTextA)) sTextA = "";
	if (!IsDefined(sTextB)) sTextB = "";
	if (!IsDefined(sTextC)) sTextC = "";

	self.pOwner SetClientDvars(	"ui_vgTT", sTitle, 
								"ui_vgTA", sTextA, 
								"ui_vgTB", sTextB, 
								"ui_vgTC", sTextC,
								"cl_bypassMouseInput", 0);
	
	self.dTextBoxOnCancel = dOnCancel;
	self.dTextBoxOnOK = dOnOK;
}

 TextBox_OnCancel()
{
	dFunc = self.dTextBoxOnCancel;
	self TextBox_Close();
	if (IsDefined(dFunc))
	{
		sTA = self TextBox_GetText("ui_vgTA");
		sTB = self TextBox_GetText("ui_vgTB");
		sTC = self TextBox_GetText("ui_vgTC");
		
		self [[dFunc]](sTA, sTB, sTC);
	}
}

 TextBox_OnOK()
{
	if (IsDefined(self.dTextBoxOnOK))
	{
		sTA = self TextBox_GetText("ui_vgTA");
		sTB = self TextBox_GetText("ui_vgTB");
		sTC = self TextBox_GetText("ui_vgTC");
		
		self [[self.dTextBoxOnOK]](sTA, sTB, sTC);
	}
}

 TextBox_Close()
{
	self.pOwner SetClientDvars(	"ui_vgTT", "", 
								"cl_bypassMouseInput", 1);
	
	self.dTextBoxOnCancel = undefined;
	self.dTextBoxOnOK = undefined;
}

 TextBox_GetText(sDvarName)
{
	return GetDvar(sDvarName);
}


// ==================================================================================== //