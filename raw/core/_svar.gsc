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
	UpdateSvars(true);
}

InSVStartGameType()
{
	UpdateSvars(false);
}

 UpdateSvars(isInit)
{
	// ============================================================== //
	// LOGIC
	core\include\_svar::Init(isInit, "LEnable", 0, 1);
	
	core\include\_svar::Init(isInit, "DEVEnabled", 0, 1);
	
	/*ISVAR::Init(isInit, "logic", ITYPE::TYPE_BOOL, 1);
	ISVAR::Init(isInit, "autospawn", ITYPE::TYPE_BOOL, 0);
	ISVAR::Init(isInit, "flying", ITYPE::TYPE_BOOL, 0);
	
	// ======  GAME LOGIC ====== //
	// ========================= //
	ISVAR::Init(isInit, "logic_playersToStart", ITYPE::TYPE_INTEGER, 2);
	
	ISVAR::Init(isInit, "logic_preMatchStartTime", ITYPE::TYPE_INTEGER, 5);
	
	ISVAR::Init(isInit, "logic_startHumansTime", ITYPE::TYPE_INTEGER, 10);
	ISVAR::Init(isInit, "logic_startMonsterTime", ITYPE::TYPE_INTEGER, 10);
	ISVAR::Init(isInit, "logic_startHumansTimeAdd", ITYPE::TYPE_INTEGER, 0);
	ISVAR::Init(isInit, "logic_startMonsterTimeAdd", ITYPE::TYPE_INTEGER, 5);
	
	ISVAR::Init(isInit, "logic_pickMonsters", ITYPE::TYPE_FLOAT, 0.25);
	ISVAR::Init(isInit, "logic_pickSystem", ITYPE::TYPE_STRING, "mix");
	
	ISVAR::Init(isInit, "logic_timeLimit", ITYPE::TYPE_FLOAT, 10);
	ISVAR::Init(isInit, "logic_roundLimit", ITYPE::TYPE_INTEGER, 10);
	
	ISVAR::Init(isInit, "logic_respawnTime", ITYPE::TYPE_INTEGER, 5);
	
	ISVAR::Init(isInit, "logic_mapVoting", ITYPE::TYPE_BOOL, 0);
	
	// ======  CHECKPOINT ====== //
	// ========================= //
	ISVAR::Init(isInit, "checkpoint_deadTime", ITYPE::TYPE_INTEGER, 20);
	
	// ======  SURVIVAL  ====== //
	// ======================== //
	ISVAR::Init(isInit, "location_multi", ITYPE::TYPE_FLOAT, 0.2);
	ISVAR::Init(isInit, "location_time", ITYPE::TYPE_INTEGER, 30);
	ISVAR::Init(isInit, "location_prepareTime", ITYPE::TYPE_INTEGER, 10);
	ISVAR::Init(isInit, "location_spaceTime", ITYPE::TYPE_INTEGER, 10);
	
	// =========  ACP ========== //
	// ========================= //
	ISVAR::Init(isInit, "b3_allow", ITYPE::TYPE_BOOL, 0); // je b3 zapnutá?
	if (COMPILER::TargetConfiguration != COMPILER::TargetConfiguration_FinalRelease)
	{
		ISVAR::Init(isInit, "b3_startacp", ITYPE::TYPE_STRING, "1:120"); // vypnutá b3, nastaví každému toto
		ISVAR::Init(isInit, "b3_startxp", ITYPE::TYPE_INTEGER, 100); // vypnutá b3, nastaví každému toto
	}
	ISVAR::Init(isInit, "acp_developers", ITYPE::TYPE_BOOL, 1); // 1 = testovanie developerov pod¾a guidu
	
	// ========== STATS =========== //
	// ============================ //
	ISVAR::Init(isInit, "stats_clearMPData", ITYPE::TYPE_INTEGER, 2); // 0 - nemaže ; 1 - maže vždy ; 2 - maže pod¾a verzie
	ISVAR::Init(isInit, "stats_version", ITYPE::TYPE_INTEGER, 2); // verzia hry
	
	// ========  RANK  ======== //
	// ======================== //
	ISVAR::Init(isInit, "score_kill", ITYPE::TYPE_INTEGER, 100);
	ISVAR::Init(isInit, "score_headshot", ITYPE::TYPE_INTEGER, 200);
	ISVAR::Init(isInit, "score_damage_allies", ITYPE::TYPE_FLOAT, 0.5);
	ISVAR::Init(isInit, "score_damage_axis", ITYPE::TYPE_FLOAT, 0.25);
	
	ISVAR::Init(isInit, "score_checkpoint", ITYPE::TYPE_INTEGER, 100);
	ISVAR::Init(isInit, "score_spawnpoint", ITYPE::TYPE_INTEGER, 50);
	ISVAR::Init(isInit, "score_endMapFirst", ITYPE::TYPE_INTEGER, 500);
	ISVAR::Init(isInit, "score_endMapSecond", ITYPE::TYPE_INTEGER, 250);
	ISVAR::Init(isInit, "score_endMapThird", ITYPE::TYPE_INTEGER, 125);
	ISVAR::Init(isInit, "score_endMapOther", ITYPE::TYPE_INTEGER, 0);
	
	ISVAR::Init(isInit, "score_location", ITYPE::TYPE_INTEGER, 25);
	
	ISVAR::Init(isInit, "price_restoreAmmo", ITYPE::TYPE_INTEGER, 0);
	
	// ======  PLAYERS  ======= //
	// ======================== //
	ISVAR::Init(isInit, "p_healthMin_allies", ITYPE::TYPE_INTEGER, 100);
	ISVAR::Init(isInit, "p_healthMax_allies", ITYPE::TYPE_INTEGER, 300);
	ISVAR::Init(isInit, "p_healthMin_axis", ITYPE::TYPE_INTEGER, 1000);
	ISVAR::Init(isInit, "p_healthMax_axis", ITYPE::TYPE_INTEGER, 5000);
	
	ISVAR::Init(isInit, "p_speedMin_allies", ITYPE::TYPE_INTEGER, 80);
	ISVAR::Init(isInit, "p_speedMax_allies", ITYPE::TYPE_INTEGER, 110);
	ISVAR::Init(isInit, "p_speedMin_axis", ITYPE::TYPE_INTEGER, 80);
	ISVAR::Init(isInit, "p_speedMax_axis", ITYPE::TYPE_INTEGER, 120);
	
	ISVAR::Init(isInit, "p_knifeDamageAllies", ITYPE::TYPE_INTEGER, 135);
	ISVAR::Init(isInit, "p_knifeDamageAxisMin", ITYPE::TYPE_INTEGER, 50);
	ISVAR::Init(isInit, "p_knifeDamageAxisMax", ITYPE::TYPE_INTEGER, 200);

	// ======  QUICK VOTING  ======= //
	// ============================= //	
	ISVAR::Init(isInit, "qVote_time", ITYPE::TYPE_INTEGER, 15);
	ISVAR::Init(isInit, "qVote_delay", ITYPE::TYPE_INTEGER, 30);*/
}