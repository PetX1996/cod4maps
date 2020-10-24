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

InSVInit()
{
	level.MF = SpawnStruct();

	EntsInit();
	BoxesInit();
}

InSVStartGameType()
{
	thread HurtsMonitor();
	thread CollidesMonitor();
}

 EntsInit()
{
	if (core\include\_game::IsDev())
	{
		level.MF.Ents = SpawnStruct();
		
		level.MF.Ents.EntsList = [];
	}
	
	EntsSaveOrigin();
}

 EntsSaveOrigin()
{
	ents = GetEntArray();
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < ents.size; foreachg45e74f_0++)
	{ eEnt = ents[foreachg45e74f_0];
		eEnt.vOrigOrigin = eEnt.origin;
		eEnt.sOrigTargetName = eEnt.targetname;
	}
}

 BoxesInit()
{
	level.MF.Boxes = SpawnStruct();
	
	level.MF.Boxes.Hurts = [];
	level.MF.Boxes.Collides = [];
	level.MF.Boxes.BulletWalls = [];
	//level.MF.Boxes.BulletBools = [];
}

 HurtsMonitor()
{
	wait 1;
	
	while (true)
	{
		HurtsCheck();
		wait 0.05;
	}
}

 HurtsCheck()
{
	for (foreachg45e74f_1 = 0; foreachg45e74f_1 < level.MF.Boxes.Hurts.size; foreachg45e74f_1++)
	{ bg = level.MF.Boxes.Hurts[foreachg45e74f_1];
		for (foreachg45e74f_2 = 0; foreachg45e74f_2 < bg.Cuboids.size; foreachg45e74f_2++)
		{ cuboid = bg.Cuboids[foreachg45e74f_2];
			for (foreachg45e74f_3 = 0; foreachg45e74f_3 < level.players.size; foreachg45e74f_3++)
			{ pPlayer = level.players[foreachg45e74f_3];
				if (!IsAlive(pPlayer) || pPlayer.pers["team"] == "spectator")
					continue;
			
				if (IsDefined(bg.sTeam) && pPlayer.pers["team"] != bg.sTeam)
					continue;
			
				if (cuboid core\include\_shape::Cuboid_ContainsPoint(pPlayer core\include\_look::GetPlayerCenterPos()))
					pPlayer core\include\clients\_damage::DoDamage(bg.iDmg, undefined, undefined, cuboid.vOrigin, undefined);
			}
		}
	}
}

 CollidesMonitor()
{
	wait 1;
	
	while (true)
	{
		CollidesCheck();
		wait 0.05;
	}
}

 CollidesCheck()
{
	for (foreachg45e74f_4 = 0; foreachg45e74f_4 < level.MF.Boxes.Collides.size; foreachg45e74f_4++)
	{ bg = level.MF.Boxes.Collides[foreachg45e74f_4];
		for (foreachg45e74f_5 = 0; foreachg45e74f_5 < bg.Cuboids.size; foreachg45e74f_5++)
		{ cuboid = bg.Cuboids[foreachg45e74f_5];
			for (foreachg45e74f_6 = 0; foreachg45e74f_6 < level.players.size; foreachg45e74f_6++)
			{ pPlayer = level.players[foreachg45e74f_6];
				if (!IsAlive(pPlayer) || pPlayer.pers["team"] == "spectator")
					continue;
			
				if (IsDefined(bg.sTeam) && pPlayer.pers["team"] != bg.sTeam)
					continue;
			
				if (cuboid core\include\_shape::Cuboid_ContainsPoint(pPlayer core\include\_look::GetPlayerCenterPos())
					&&
					(!IsDefined(cuboid.InsidePlayers)
					|| !core\include\array\_array::Contains(cuboid.InsidePlayers, pPlayer)))
					pPlayer thread RepelPlayerAway(cuboid);
			}
		}
	}
}

 RepelPlayerAway(cuboid)
{
	if (!IsDefined(cuboid.InsidePlayers))
		cuboid.InsidePlayers = [];

	cuboid.InsidePlayers[cuboid.InsidePlayers.size] = self;
	
	fStrength = Length(self GetVelocity()) / 100;
	vDir = self GetVelocity() * -1;
	iTry = 1;
	
	doWhileJHS8G8AW9_7 = true; while (doWhileJHS8G8AW9_7 || IsDefined(self)
		&& IsAlive(self) 
		&& self.pers["team"] != "spectator"
		&& cuboid core\include\_shape::Cuboid_ContainsPoint(self core\include\_look::GetPlayerCenterPos()))
	{ doWhileJHS8G8AW9_7 = false;
		for (i = 0; i < Max(1, fStrength); i++)
			self core\include\clients\_damage::Repel(fStrength, vDir);
		
		iTry++;
		if (iTry % 50)
			vDir = (RandomFloat(2) - 1, RandomFloat(2) - 1, 0);
		
		if (iTry > 1000)
		{
			IPrintLnBold("Collide Box error");
			return;
		}
		
		wait 0.05;
	}
	
	
	cuboid.InsidePlayers = core\include\array\_array::Remove(cuboid.InsidePlayers, self);
}

// eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime
RunInCPostDamaging(args)
{
	if (IsDefined(args.eAttacker) 
		&& IsPlayer(args.eAttacker) 
		&& IsAlive(args.eAttacker) 
		&& IsAlive(self)
		&& (args.sMeansOfDeath == "MOD_PISTOL_BULLET" 
			|| args.sMeansOfDeath == "MOD_RIFLE_BULLET" 
			|| args.sMeansOfDeath == "MOD_HEAD_SHOT"))
	{
		vStart = args.eAttacker core\include\_look::GetPlayerViewPos();
		vEnd = args.vPoint;
		
		for (foreachg45e74f_8 = 0; foreachg45e74f_8 < level.MF.Boxes.BulletWalls.size; foreachg45e74f_8++)
		{ bg = level.MF.Boxes.BulletWalls[foreachg45e74f_8];
			for (foreachg45e74f_9 = 0; foreachg45e74f_9 < bg.Cuboids.size; foreachg45e74f_9++)
			{ cuboid = bg.Cuboids[foreachg45e74f_9];
				if (cuboid core\include\_shape::Cuboid_IsLineIntersect(vStart, vEnd))
				{
					args.bCancel = true;
					return;
				}
			}
		}
	}
}