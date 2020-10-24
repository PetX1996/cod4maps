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
// Mod      : Escape
// Website  : http://www.4gf.cz/
//I========================================================================I
// Script by: PetX
//I========================================================================I

#include plugins\_include;

/* 
I==============================================================================================I
Zmaze objekt(brush, model, origin) po vami zadanom a obdrzanom damage

Pozor! zadaný damage je damage, pri 0 hráèoch v tíme "Humans", s každým ïa¾ším hráèom sa damage zvyšuje o 10%

Radiant
---------------
1. vytvorte trigger_damage a dajte mu nejaky targetname - tento bude pre vsetky "znicitelne objekty" rovnaky!
3. v entity okne dalej zadajte damage: "count" "velkost_damage"  -  priklad: "count" "2000"
4. NEPOVINNE: dalej zadajte efekt, ktory sa spusti pri zniceni, je nutne zadat presnu cestu a nazov: "script_noteworthy" "cesta k efektu"  -  priklad: "script_noteworthy" "impacts/flesh_hit_knife"
5. vytvorte brush/model/origin, stlacte ESC, oznacte trigger a potom brush/model/origin/trigger a spojte pomocou W 

GSC mapy
---------------
DestructibleObjects(targetname)

targetname(parameter 1 - povinne): 	zadajte string, targetname vasho aktivacneho triggeru, tento targetname je globalny pre vsetky "znicitelne objekty"

funkciu DestructibleObjects(targetname) volajte v scripte iba raz!

Vzor
---------------
thread plugins\_des_obj::DestructibleObjects("destroy_brush");

I==============================================================================================I
*/

DestructibleObjects(targetname)
{
	if(!isdefined(targetname))
		return;

	ent = getentarray(targetname, "targetname");
	if(!isdefined(level.escape_fx))
		level.escape_fx = [];
	
	if(!isdefined(ent))
	{
		DebugOnSpawn("trigger undefined: "+targetname);
		return;
	}
	
	if(isdefined(level.activedesobj))
		return;
	
	level.activedesobj = true; //ochrana proti **** :D
	
	precacheShader("black");
	precacheShader("white");
	
	fxlist = [];
	newfxlist = [];
	
	for(i = 0;i < ent.size;i++)
	{
		if(!isdefined(ent[i].script_noteworthy))
			continue;
			
		fxlist[fxlist.size] = ent[i].script_noteworthy;
	}
	
	if(isdefined(fxlist))
	{
		for(i = 0;i < fxlist.size;i++)
		{
			if(!isdefined(fxlist[i]))
				continue;
				
			for(c = 0;c < fxlist.size;c++)	
			{
				if(!isdefined(fxlist[c]))
					continue;
					
				if(fxlist[i] == fxlist[c] && i != c)	
				{
					fxlist[i] = undefined;
					break;
				}
			}
			
			if(isdefined(fxlist[i]))
				newfxlist[newfxlist.size] = fxlist[i];
		}
		
		if(isdefined(newfxlist))
		{
			for(i = 0;i < newfxlist.size;i++)
			{
				level.escape_fx[newfxlist[i]] = LoadFX( newfxlist[i] );
			}
		}
	}
	
	for(i = 0;i < ent.size;i++)
	{
		if(isdefined(ent[i].script_noteworthy))
		{
			ent[i] thread destroy_brush(ent[i].script_noteworthy);
		}
		else
			ent[i] thread destroy_brush(undefined);
	}
	
}

destroy_brush(fx)
{
	if(!isdefined(self.target))
	{
		DebugOnSpawn("Brush undefined: "+self.targetname);
		return;
	}
	
	PluginInfo("Destructible Objects", "PetX", "0.2");
	
	wait 0.1;
	
	//DebugOnSpawn("^1"+fx);
	
	brush = getent(self.target, "targetname");	
		
	if(isdefined(self.count))
		dmg = self.count;
	else
	{
		dmg = 1;
	}
	
	if(isdefined(fx))	
	{
		fx = level.escape_fx[fx];
	}
	
	origin = brush.origin;
	currentdmg = 0;
	
	
	if(!isdefined(self.count) || !isdefined(fx))
	{
		//SpawnDebug("=======");
		if(!isdefined(self.count))
			DebugOnSpawn("^1Damage set to 1!");
		//if(!isdefined(fx))
			//SpawnDebug("^1Effect undefined!!");		
		//SpawnDebug("=======");
	}
	
	while(1)
	{
		self waittill( "damage", damage, player, direction_vec, P, type );
		
		if(!isdefined(player.dmgprogressbar))
			player createhud();
		
		currentdmg += damage;
		player modify_hud(currentdmg,damagebyplayers(dmg));
		player thread show_hud(1);
		player thread hide_hud(5);
		iprintln("end: "+damagebyplayers(dmg)+" start: "+currentdmg);
		
		if(currentdmg >= damagebyplayers(dmg))
		{	
			self delete();
			brush delete();
			
			if(isdefined(fx))
				PlayFX( fx, origin);
				
			return;
		}
	}
}

damagebyplayers(damage)
{
	p = 10; //+10 percent pre kazdeho hraca
	player = GetAllPlayers(true, "allies");
	
	dmg = int((damage*((p*player)+100))/100);
	
	return dmg;
}

modify_hud(start,end)
{
	x = int((start*288)/end);
	
	if(x > 288)
		x = 288;
	
	self.dmgprogressbar setShader("white", x, 8);
}

show_hud(time)
{
	self.dmgprogressbackground FadeOverTime( time );
	self.dmgprogressbackground.alpha = 0.5;
	self.dmgprogressbar FadeOverTime( time );
	self.dmgprogressbar.alpha = 1;
}

hide_hud(time)
{
	wait time/2;
	self.dmgprogressbackground FadeOverTime( time/2 );
	self.dmgprogressbackground.alpha = 0;
	self.dmgprogressbar FadeOverTime( time/2 );
	self.dmgprogressbar.alpha = 0;
}

createhud()
{
	self.dmgprogressbackground = newClientHudElem(self);				
	self.dmgprogressbackground.alignX = "center";
	self.dmgprogressbackground.alignY = "middle";
	self.dmgprogressbackground.x = 320;
	self.dmgprogressbackground.y = 385;
	self.dmgprogressbackground.alpha = 0.5;
	self.dmgprogressbackground setShader("black", 292, 14);
	
	self.dmgprogressbar = newClientHudElem(self);				
	self.dmgprogressbar.alignX = "left";
	self.dmgprogressbar.alignY = "middle";
	self.dmgprogressbar.x = (320 - (288 / 2.0));
	self.dmgprogressbar.y = 385;
	self.dmgprogressbar.alpha = 1;
	self.dmgprogressbar setShader("white", 0, 8);
}