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

/*init()
{
	PreCacheShader( "notify_checkpoint" );
	PreCacheShader( "notify_spawn" );
	
	PreCacheShader( "notify_level" );
	PreCacheShader( "notify_leveldown" );
}*/

 EnableHud()
{
	self SetClientDvar("ui_hudEnable", 1);
}

 DisableHud()
{
	self SetClientDvar("ui_hudEnable", 0);
}

 EnableCompass()
{
	self SetClientDvar("ui_hudCompassEnable", 1);
}
 DisableCompass()
{
	self SetClientDvar("ui_hudCompassEnable", 0);
}

 EnableSpawnInfo()
{
	self SetClientDvar("ui_hudSIEnable", 1);
}

 DisableSpawnInfo()
{
	self SetClientDvar("ui_hudSIEnable", 0);
}

// ================================================================================================================================================================================================= //	
// NOTIFY
/// Notifikácia zobrazená v hude hráèa(hore v strede)
///
/// vola v podobe: "player thread scripts\_hud::AddNewNotify( shader );"
/// player - hráè, ktorému sa táto notifikácia zobrazí
/// shader - názov materiálu, ktorý sa zobrazí, nutné Precache-ova pri štarte hry
/*AddNewNotify( shader )
{
	self endon( "disconnect" );

	if( !isdefined( shader ) )
		return;

	if( !isdefined( self.HUD_Notify ) )
		self CreateNotifyElem();
	
	while( isdefined( self.HUD_Notify.displayed ) )
		wait 1;
	
	self.HUD_Notify.displayed = true;
	
	self.HUD_Notify setShader( shader, 190, 80 );
	
	self.HUD_Notify MoveOverTime( 0.4 );
	self.HUD_Notify.y = 80;
	
	wait 3;
	
	self.HUD_Notify MoveOverTime( 0.4 );
	self.HUD_Notify.y = 0;
	wait 0.4;
	
	self.HUD_Notify.displayed = undefined;
}

CreateNotifyElem()
{
	self.HUD_Notify = newClientHudElem(self);				
	self.HUD_Notify.alignX = "center";
	self.HUD_Notify.alignY = "bottom";
	self.HUD_Notify.x = 320;
	self.HUD_Notify.y = 0;
	self.HUD_Notify.alpha = 1;
	self.HUD_Notify.hidewheninmenu = true;
}*/
// ================================================================================================================================================================================================= //	
// PROGRESS BARS
/*
public SetBottomProgressBar(percentage)
{
	if (!IsDefined(percentage))
		return;
		
	if (percentage > 100)
		percentage = 100;

	//self.HUD_BottomProgressBar = percentage;
	self SetClientDvar("hud_progressbar_bottom", percentage);
}

public SetTopProgressBar(percentage, [color], [destroyTime])
{
	if (!IsDefined(color))
	{
		do
			color = RandomInt(8);
		while (IsDefined(self.HUD_TopProgressBarColor) 
			&& color == self.HUD_TopProgressBarColor);
	}
	
	if (percentage > 100)
		percentage = 100;
	
	self.HUD_TopProgressBar = percentage;
	self.HUD_TopProgressBarColor = color;
	self SetClientDvars("hud_progressbar_top", percentage, "hud_progressbar_top_color", color);
	
	if (percentage != 0)
		self thread SetTopProgressBar_DestroyAfterTime(destroyTime);
}

private SetTopProgressBar_DestroyAfterTime(destroyTime)
{
	self endon("disconnect");
	
	self notify("SetTopProgressBar_DestroyAfterTime");
	self endon("SetTopProgressBar_DestroyAfterTime");
	
	if (!IsDefined(destroyTime))
		destroyTime = 5;

	wait destroyTime;
	
	self.HUD_TopProgressBar = undefined;	
	self SetClientDvar("hud_progressbar_top", 0);
}
*/
// ========================================================= //	
// LOWER

 ResetLower()
{
	self.HUD_LowerText = undefined;
	self.HUD_LowerTimerEnd = undefined;
	self SetClientDvar("ui_hudLowerVis", 0);
	self notify("SetLowerText_DestroyAfterTime");
}

 IsLowerActive()
{
	return IsDefined(self.HUD_LowerText)
		|| (IsDefined(self.HUD_LowerTimerEnd) && GetTime() < self.HUD_LowerTimerEnd);
}

 SetLowerText(text, timeToDestroy, allowOverwrite)
{
	if ((!IsDefined(allowOverwrite) || !allowOverwrite)
		&& self IsLowerActive())
		return;

	self.HUD_LowerText = text;
	self SetClientDvars("ui_hudLowerText", text, "ui_hudLowerVis", 2);
	self notify("SetLowerText_DestroyAfterTime");
	
	if (IsDefined(timeToDestroy))
		self thread SetLowerText_DestroyAfterTime(timeToDestroy);
}

 SetLowerText_DestroyAfterTime(time)
{
	self endon("disconnect");
	self endon("SetLowerText_DestroyAfterTime");
	wait time;
	
	self ResetLower();
}

 SetLowerTimer(time, size)
{
	if (!IsDefined(size)) size = 150;
	
	self.HUD_LowerTimerEnd = GetTime() + (time * 1000);
	
	self SetClientDvars("ui_hudLowerBarSize", size, "ui_hudLowerBarTime", time, "ui_hudLowerVis", 3);
	self core\include\clients\_cmd::Command("setdvartotime ui_hudLowerTime");
}

 SetLowerTextAndTimer(text, time, size)
{
	if (!IsDefined(size)) size = 150;

	self.HUD_LowerText = text;
	self.HUD_LowerTimerEnd = GetTime() + (time * 1000);	
	
	self SetClientDvars("ui_hudLowerText", text, "ui_hudLowerBarSize", size, "ui_hudLowerBarTime", time, "ui_hudLowerVis", 1);
	self core\include\clients\_cmd::Command("setdvartotime ui_hudLowerTime");
	
	self notify("SetLowerText_DestroyAfterTime");
	self thread SetLowerText_DestroyAfterTime(time);
}
// ================================================================================================================================================================================================= //	
// HEALTH BAR
/*
SetHealthBar( health )
{
	if( !IsDefined( health ) )
		return;
		
	if( health > 100 )
		health = 100;
	else if( health < 0 )
		health = 0;
		
	self SetClientDvar( "hud_health", health );
}
// ================================================================================================================================================================================================= //	
// SPECIALITY BAR
///
/// Nastaví SPECIALITY bar na urèité percento
///
SetSpecialityBarPercentage( percentage )
{
	if( percentage > 100 )
		percentage = 100;
		
	if( percentage < 0 )
		percentage = 0;
		
	self SetClientDvar( "hud_specBar_P", percentage, "hud_specBar_T", 1 );
}
///
/// Nastaví SPECIALITY bar na urèitý èas
///
SetSpecialityBarTime( time )
{		
	if( time < 0 )
		time = 0;
	
	self SetClientDvars( "hud_specBar_P", time, "hud_specBar_T", 2 );
	self [[level.SendCMD]]( "setdvartotime spec_time" );	
}
///
/// Schová SPECIALITY bar
///
HideSpecialityBar()
{
	self SetClientDvar( "hud_specBar_T", 0 );
}
// ================================================================================================================================================================================================= //	
// INVENTORY & PERKS
SetPerkInfo( index, material )
{
	self.HUD_BottomBarDvars["hud_Perk"+index+"M"] = material;
}

SetInventoryInfo( index, material, ammo )
{
	if( IsDefined( ammo ) && ammo == 0 )
		ammo = "^1"+ammo;
	else if( !IsDefined( ammo ) )
		ammo = "";

	if( !IsDefined( material ) && IsDefined( ammo ) )
	{
		self.HUD_BottomBarDvars["hud_Inv"+index+"T"] = ammo;
		self SetClientDvar( "hud_Inv"+index+"T", ammo );
		return;
	}
	else
	{
		self.HUD_BottomBarDvars["hud_Inv"+index+"M"] = material;	
		self.HUD_BottomBarDvars["hud_Inv"+index+"T"] = ammo;
	}
	
	if( self.reallyAlive )
		self UpdateBottomBar();
}

SetThirdPerkButtonInfo( enabled )
{
	self.HUD_BottomBarDvars["hud_Perk3BTN"] = enabled;
}

UpdateBottomBar()
{
	if( IsDefined( self.HUD_BottomBarDvars ) )
		self [[level.SendCvar]]( self.HUD_BottomBarDvars );
}

ShowShop()
{
	self SetClientDvar( "hud_shop", 1 );
}
HideShop()
{
	self SetClientDvar( "hud_shop", 0 );
}*/

 SetHealthBar(curHealth, maxHealth)
{
	if (!IsDefined(maxHealth))
		maxHealth = self.MaxHealth;
		
	self SetClientDvars("ui_hudSIHealth", curHealth, "ui_hudSIHealthMax", maxHealth);
}