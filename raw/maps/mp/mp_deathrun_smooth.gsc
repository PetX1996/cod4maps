/* Map by Headdy. Feel free to contact me on xfire: headdygaming.

Map Information:
Traps: 10
Size: Small / Medium > Time around 30-40 sec without traps.
Goal to reach: Just to make a 'good' map, to be proud of, well here is it.
Credits:

Braxi - The Mod
DeBaksteenNL - All the Graphical Content
Poyser - Additional Help
Xenon - Tutorials <lel>
Raid-Gaming.
Lossy - All the help and feedback he gave, thanks man.

Thanks for reading my shit scripts, fucker. Feel free to fucking steal all scripts and fucking use them somewhere else I DONT FUCKING CARE.
Good luck.

*/

// Got some scripts from: Darmuhv2, Sick.

// This is the Beta version, do not hand this map out to anyone.
main()
{
maps\mp\_load::main(); 

thread trap1();
thread trap2();
thread trap3();
thread trap5();
thread trap6();
thread trap7();
thread trap8();
thread trap9();
thread trap10();
thread kniferoom();
thread sniperroom();
thread startdoors();
thread addTestClients();
thread topbar();
thread welcome(); // Alternative version of Mapperwelcome, this is on name, not guid. < Namechanger noobs.. > but I like it more, so fuck these noobs who want to steal my name. 
thread infospam();
thread trap11();
thread trap12push();
thread trap12mover();
thread old();
thread jump();
thread endmap();
//thread ammo();
//thread walk();
thread secretopen(); // There is no secret, just to troll some bitches while shooting the trigger above the startdoor, there is a little gap where you can shoot in, it will say secret is open, noob search etc.
thread openactidoor();
thread weap();

precacheItem("colt45_mp");
precacheItem( "m1014_grip_mp" );	

    addTriggerToList( "trap1_trig" );
    addTriggerToList( "trap2_trig" );
    addTriggerToList( "trap3_trig" ); 
	addTriggerToList( "trap5_triggeryolowater" );
    addTriggerToList( "trap6_triggeryolowater" );
    addTriggerToList( "trap7_trig" ); 
    addTriggerToList( "trap8_spin" );
    addTriggerToList( "trap9_trig" ); 
    addTriggerToList( "trap10_triggeryolowater" );
	addTriggerToList( "trap11_trig" );
	addTriggerToList( "trap12_trig" );
	
game["allies"] = "marines";
game["axis"] = "opfor";
game["attackers"] = "axis";
game["defenders"] = "allies";
game["allies_soldiertype"] = "desert";
game["axis_soldiertype"] = "desert";
}
/////////////////////////////////////// Triggers
addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}
/////////////////////////////////////// Walk on the outside for Activator
walk()
{
	trig = getEnt ("outside_trig", "targetname");
	glass = getEnt ("outside", "targetname");
    trig waittill( "trigger", who );
	iprintLn ("^2The door to outside is open! Activator can now see you closer.. ;)");
	trig delete();
	
	{
    glass notSolid();
	}
}
///////////////////////////////////////
trap1()
{
	brushGroup1 = getEntArray( "trap1a", "targetname" );
    brushGroup2 = getEntArray( "trap1b", "targetname" );
	trig = getEnt ("trap1_trig", "targetname");
    trig waittill( "trigger");
	iprintLn ("^2Trigger 1 used");
	trig delete();
	
	
	{
	brushGroup1[randomInt(brushGroup1.size)] notSolid();
    brushGroup2[randomInt(brushGroup2.size)] notSolid();
	}
}
////////////////////////////////////////
trap2()
{
	trap2 = getEnt( "trap2", "targetname" );
	trig = getEnt ("trap2_trig", "targetname");
    trig waittill( "trigger", who );
	iprintLn ("^2Trigger 2 used");
	trig delete();
	
	{					// No, I don't want to make a random one, because it's already used @ the first trap
    trap2 notSolid();
	}
}
//////////////////////////////////////// 
trap3()
{
	trap3 = getEnt ("trap3", "targetname");
	trig = getEnt ("trap3_trig", "targetname");
	trig waittill( "trigger");
	iprintLn ("^2Trigger 3 used");
	trig delete();
	
	{
	
	trap3 moveZ(288,2);
	trap3 moveZ(-288,2);
	wait 10;
	trap3 moveZ(288,2);
	trap3 moveZ(-288,2);	
	
	}
}
////////////////////////////////////// Trap 4 removed.
/////////////////////////////////////
trap5()
{
	trap5 = getEnt ("trap5", "targetname");
	trig = getEnt ("trap5_triggeryolowater", "targetname");
	trig waittill( "trigger");
	iprintLn ("^2Trigger 5 used");
	trig delete();
	
	{
	trap5 rotateroll(360,3);
	wait 1;
	}
}
////////////////////////////////////
trap6()
{
	trap6 = getEnt ("trap6yolowater", "targetname");
	trig = getEnt ("trap6_triggeryolowater", "targetname");
    trig waittill( "trigger");
	iprintLn ("^2Trigger 6 used");
	trig delete();
	
	{
	trap6 moveZ(224,4);
	trap6 waittill("movedone");
	trap6 delete();
	}
}
//////////////////////////////////
trap7()
{
	trap7 = getEnt ("trap7", "targetname");
	trig = getEnt ("trap7_trig", "targetname");
    trig waittill( "trigger");
	iprintLn ("^2Trigger 7 used");
	trig delete();
	
	{
	trap7 moveZ(-160,0.5);
	wait 2;
	trap7 moveZ(160,0.5);
	}
}
//////////////////////////////////
trap8()
{
	trap8 = getEnt ("trap8", "targetname");
	trig = getEnt ("trap8_trig", "targetname");
    trig waittill( "trigger");
	iprintLn ("^2Trigger 8 used");
	trig delete();
	
	while(1)
	{
	trap8 rotateyaw(720,4);
	wait 2;
	trap8 rotateyaw(360,3);
	}
}
//////////////////////////////////
trap9()
{
	trap9 = getEnt ("trap9", "targetname");
	trig = getEnt ("trap9_trig", "targetname");
    trig waittill( "trigger");
	iprintLn ("^2Trigger 9 used");
	trig delete();
	
	while(1)
	{
	trap9 rotatepitch(360,5);
	wait 1;
	}
}
//////////////////////////////////
trap10()
{
	trap10 = getEnt ("trap10yolowater", "targetname");
	trig = getEnt ("trap10_triggeryolowater", "targetname");
    trig waittill( "trigger");
	iprintLn ("^2Trigger 10 used");
	trig delete();
	
	while(1)
	{
	trap10 rotateYaw(360,2);
	wait 3;
	trap10 rotateYaw(360,0.5);
	wait 1;
	}
}
//////////////////////////////////
trap11()
{
	trap11 = getEnt ("trap11", "targetname");
	trig = getEnt ("trap11_trig", "targetname");
    trig waittill( "trigger", player);
	iprintLn ("^2Trigger 11 used");
	trig delete();
	
	{
	trap11 notSolid();
	}
}
//////////////////////////////////
trap12mover()
{
	trap12 = getEnt ("trap12", "targetname");
	trig = getEnt ("trig_mover", "targetname");
    trig waittill( "trigger", player);
	iprintLn ("^2Trigger of the mover used");
	trig delete();
	
	while(1)
	{
	wait 2;
	trap12 moveX(768,4);
	trap12 waittill("movedone");
	wait 1;
	trap12 moveX(-768,4);
	trap12 waittill("movedone");
	wait 1;
	}
}
//////////////////////////////////
trap12push()
{
	trap12pusher = getEnt ("trap12push", "targetname");
	trig = getEnt ("trap12_trig", "targetname");
    trig waittill( "trigger", player);
	iprintLn ("^2Trigger 12 used");
	trig delete();
	
	{
	trap12pusher moveY(-624,1);
	wait 5;
	trap12pusher moveY(624,1);
	wait 1;
	}
}
//////////////////////////////////
kniferoom()
{
    level.knife_trig = getEnt( "teleportknife", "targetname");
    jump = getEnt( "enter_knife_room", "targetname" );
    acti = getEnt( "activator_enter_knife", "targetname" );
    
    while(1)
    {
        level.knife_trig waittill( "trigger", player );
        if( !isDefined( level.knife_trig ) )
            return;
        
        level.sniper_trig delete();
		level.jump_trig delete();
		level.old_trig delete();
		
        player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "tomahawk_mp" ); //jumper weapon        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "tomahawk_mp" );        
        wait 0.05;
		player.maxhealth = 100;
		level.activ.maxhealth = 100;
        player switchToWeapon( "tomahawk_mp" ); //activator weapon
        level.activ SwitchToWeapon( "tomahawk_mp" );
        iPrintlnBold( " ^6" + player.name + " ^5Entered Knife." );     //change to what you want it to be
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}
//////////////////////////////////
sniperroom()
{
    level.sniper_trig = getEnt( "teleportsniper", "targetname");
    jump = getEnt( "enter_sniper_room", "targetname" );
    acti = getEnt( "activator_enter_sniper", "targetname" );
    
    while(1)
    {
        level.sniper_trig waittill( "trigger", player );
        if( !isDefined( level.sniper_trig ) )
            return;
        
        level.knife_trig delete();
		level.jump_trig delete();
		level.old_trig delete();
		
        player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "m40a3_mp" ); //jumper weapon        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "m40a3_mp" );        
        wait 0.05;
        player switchToWeapon( "m40a3_mp" ); //activator weapon
		player.maxhealth = 100;
		level.activ.maxhealth = 100;
        level.activ SwitchToWeapon( "m40a3_mp" );
        iPrintlnBold( " ^6" + player.name + " ^5Entered Sniper." );     //change to what you want it to be
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}
jump()
{
    level.jump_trig = getEnt( "teleportjump", "targetname");
    jump = getEnt( "enter_jumper_room", "targetname" );
    acti = getEnt( "activator_enter_jump", "targetname" );
    
    while(1)
    {
        level.jump_trig waittill( "trigger", player );
        if( !isDefined( level.jump_trig ) )
            return;
        
        level.knife_trig delete();
		level.sniper_trig delete();
		level.old_trig delete();
		
		
        player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "tomahawk_mp" ); //jumper weapon        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "tomahawk_mp" );        
        wait 0.05;
        player switchToWeapon( "tomahawk_mp" ); //activator weapon
		player.maxhealth = 100;
		level.activ.maxhealth = 100;
        level.activ SwitchToWeapon( "tomahawk_mp" );
        iPrintlnBold( " ^6" + player.name + " ^5Entered The Jump Room." );     //change to what you want it to be
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}
old()
{
    level.old_trig = getEnt( "teleportold", "targetname");
    jump = getEnt( "enter_old", "targetname" );
    acti = getEnt( "activator_enter_old", "targetname" );
    
    while(1)
    {
        level.old_trig waittill( "trigger", player );
        if( !isDefined( level.old_trig ) )
            return;
        
        level.knife_trig delete();
		level.sniper_trig delete();
		level.jump_trig delete();
		
        player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "tomahawk_mp" ); //jumper weapon        
        level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "tomahawk_mp" );        
        wait 0.05;
        player switchToWeapon( "tomahawk_mp" ); //activator weapon
		player.maxhealth = 100;
		level.activ.maxhealth = 100;
        level.activ SwitchToWeapon( "tomahawk_mp" );
        iPrintlnBold( " ^6" + player.name + " ^5Entered Old! Get the activator!" );     //change to what you want it to be
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
    }
}
// Ammo for the Sniper Room
ammo()
{
 level.ammotrig = getent("ammo", "targetname");
 level.ammotrig = getent("ammo1", "targetname");
	

	while(1)
	    {
		level.ammotrig waittill( "trigger", player );
		player givemaxammo ( "m40a3_mp" );
		player iprintlnbold ("^3Ammo Filled!");
	    }    
}
//////////////////////////////////////////////////////////
startdoors()
{
	startdoor = getEnt ("startdoorjumper", "targetname");
	acti = getEnt ("actidoor", "targetname");
	{
	wait 2;
	iPrintLnBold("^1Waiting for 10 seconds");
	wait 5;
	iPrintLnBold("5 seconds left!");
	acti moveZ(-228,2);
	iPrintLnBold("Activator's door is opened!");
	wait 2;
	iPrintLnBold("3");
	wait 1;
	iPrintLnBold("2");
	wait 1;
	iPrintLnBold("1");
	wait 1;
	iPrintLnBold("Start door for Jumpers opening!");
	startdoor moveZ(432,5);
	}
}
openactidoor()
{
	open = getEnt ("open", "targetname");
	trig = getEnt ("openactidoor", "targetname");
    trig waittill( "trigger", player);
	iprintLn ("^2Extra Acti Room Opened!");
	trig delete();
	
	{
	open moveZ(-403,6);
	wait 1;
	player iPrintLnBold("^1You have now access to trap 12!");
	}
}
///////////////////// B0ts

addTestClients()
{
    setDvar("scr_testclients", "");
    wait 1;
    for(;;)
    {
        if(getdvarInt("scr_testclients") > 0)
            break;
        wait 1;
    }
    testclients = getdvarInt("scr_testclients");
    setDvar( "scr_testclients", 0 );
    for(i=0;i<testclients;i++)
    {
        ent[i] = addtestclient();

        if (!isdefined(ent[i]))
        {
            println("Could not add test client");
            wait 1;
            continue;
        }
        ent[i].pers["isBot"] = true;
        ent[i] thread TestClient("autoassign");
    }
    thread addTestClients();
}
TestClient(team)
{
    self endon( "disconnect" );

    while(!isdefined(self.pers["team"]))
        wait .05;
        
    self notify("menuresponse", game["menu_team"], team);
    wait 0.5;
}

//////////////////////////////////////////// Secrets
secretopen()
{
	trig = getEnt ("secretopen", "targetname");
    trig waittill( "trigger", player);
	iprintLn ("^2Secret opened!");
	trig delete();
	
	{
	iPrintLnBold("^1Player: ^5"+ player.name + " ^1has opened the secret!");
	}
}
/////////////////////////////////////// Mapperwelcome
welcome()
{

	
	while(true)
	{
		level waittill ("connected", user);
		
		if ((user.name == "Headdy") || (user.name == "[Raid]Headdy") || (user.name == "headdyy.") || (user.name == "thimoo.") || (user.name == "Headdy"))
		{
			iPrintLnBold("^1Map maker ^5"+ user.name + " ^1in da damn server!");
		}
	}
}
/////////////////////////////////////// Top bar
topbar()
{
	if( isDefined( self.logoText ) )
		self.logoText destroy();

	self.logoText = newHudElem();
	self.logoText.y = 10;
	self.logoText.alignX = "center";
	self.logoText.alignY = "middle";
	self.logoText.horzAlign = "center_safearea";

	self.logoText.alpha = 0;
	self.logoText.sort = -3;
	self.logoText.fontScale = 1.6;
	self.logoText.archieved = true;

	for(;;)
	{
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2Map Made By ^1Headdy");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2Xfire: ^1headdygaming");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2Braxi.org");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2Raid-Gaming");
		wait 5;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2Please ^1report bugs!");
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2A big thanks to BaksteenNL for all the graphical content!");
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2A big thanks to Lossy! You're great!");
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 1;
		self.logoText setText("^2Thanks to Ultra for testing!");
		self.logoText fadeOverTime(1);
		self.logoText.alpha = 0;
		wait 1;
	}
}
infospam()
{

	for(;;)
	{
	wait 20;
	iprintln ("^1Map By Headdy");
	wait 30;
	iprintln ("^2Feel free to report bugs on xfire!!");
	wait 30;
	iprintln ("^3Thanks to Lossy!");
	wait 20;
	iprintln("^5Raid-Gaming");
	}
}
////////////////////////////////////////////// Finish
endmap()
{
	trig = getent("endmap_trig", "targetname");
	
	
	{
		trig waittill ( "trigger", player );
		{
			iPrintLnBold("^1Player: ^5"+ player.name + " ^1has finished the map!");
			player iPrintLnBOld("You get no XP, that's for noobies.");
		}
	}
}
// Random xp award will work with this, so no XP is given by the map itself.

weap() // From Skypillar. I have no idea if I can use it from Wingzor.
{
weap = getEnt("weap_trig", "targetname");	// trigger
precacheItem("colt45_mp"); // Precaches
precacheItem( "m1014_grip_mp" );	
enabled = true;
while(1)
{
weap waittill("trigger", player); // wait til player uses

if( isDefined( level.trapsDisabled ) && level.trapsDisabled) // Not in free
{
player iPrintLnBold("^1No weapon in free run."); // Message for not in free
enabled = false;
}

if(!isDefined(player.used))
{
player.used = false;
}

if(isDefined(player.used) && player.used == true) // Player has already a gun.
{
player iPrintlnBold("Ehm, 1 is enough..."); // 1 is enough.
}

if(isDefined(player.used) && player.used == false && enabled == true) // Player has no weapon yet.
{
	player GiveWeapon("colt45_mp"); // Give weapons.
	player GiveWeapon("m1014_grip_mp");
	player SwitchToWeapon( "deserteaglegold_mp" );
	player iPrintLnBold("Have fun with the weapons!");
	player.used = true; // Now it the script sees player has the weapons.
}
}
}












