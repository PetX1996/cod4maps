/*                                                                                                         
          ____                    .--,-``-.      ,---,  ,---,                                            
        ,'  , `.           .---. /   /     '.  ,---.'|,---.'|  .--.--.       ___                         
     ,-+-,.' _ |          /. ./|/ ../        ; |   | :|   | : /  /    '.   ,--.'|_                       
  ,-+-. ;   , ||      .--'.  ' ;\ ``\  .`-    ''   : ''   : '|  :  /`. /   |  | :,'              __  ,-. 
 ,--.'|'   |  ;|     /__./ \ : | \___\/   \   ::   | |:   | |;  |  |--`    :  : ' :            ,' ,'/ /| 
|   |  ,', |  ': .--'.  '   \' .      \   :   ||   ' :|   ' :|  :  ;_    .;__,'  /    ,--.--.  '  | |' | 
|   | /  | |  ||/___/ \ |    ' '      /  /   / ;   ; |;   ; | \  \    `. |  |   |    /       \ |  |   ,' 
'   | :  | :  |,;   \  \;      :      \  \   \ '   | ''   | '  `----.   \:__,'| :   .--.  .-. |'  :  /   
;   . |  ; |--'  \   ;  `      |  ___ /   :   ||   | :|   | :  __ \  \  |  '  : |__  \__\/: . .|  | '    
|   : |  | ,      .   \    .\  ; /   /\   /   :'   : ''   : ' /  /`--'  /  |  | '.'| ," .--.; |;  : |    
|   : '  |/        \   \   ' \ |/ ,,/  ',-    .|   | ||   | |'--'.     /   ;  :    ;/  /  ,.  ||  , ;    
;   | |`-'          :   '  |--" \ ''\        ; ;   : ;;   : ;  `--'---'    |  ,   /;  :   .'   \---'     
|   ;/               \   \ ;     \   \     .'  |   ,/ |   ,/                ---`-' |  ,     .-./         
'---'                 '---"       `--`-,,-'    '---'  '---'                         `--`---'             



    © MW3||Star
    Map made and Scripted By MW3||Star
    xfire: rohit901
    thanks to: wingzor and fearz
    If you have Decompiled my Map for Scripts, Then no Problem.. But If you Use it in your map Then Please Do Give Me Credits.
    add me on xfire for any Doubts/Problems.
    And please tell all the server admins to put my map on their servers :D	

                                                                                                         
*/





main()
{

    maps\mp\_load::main();
	//maps\mp\mp_dr_unnamed_fx::main();
	//maps\mp\_compass::setupMiniMap("compass_map_mp_dr_unnamed");
	
	//ambientPlay("ambient_farm");
	ambientPlay ("fallenkingdom");
	
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1200");
	PreCacheItem("deserteaglegold_mp");
	PreCacheItem("emerald_crossbow_mp");
	PreCacheItem("uzi_mp");
	PreCacheItem("emerald_m40a3_mp");
	PreCacheItem("ak47_silencer_mp");
	
	
	thread give_wep();
	thread arrow();
	thread teleport();
	thread addTestClients();
	thread actitele();
	thread mover();
	thread movers_easy();
	thread rot_easy();
	thread sec_tele();
	thread sec_entry();
	thread credit();
	thread vip_teleport();
	thread hard_respawn();
	thread hard_bounce();
	thread hard_bounce1();
	thread ambient_changer();
	thread animator();
	thread creditsftw();
	thread CheckLastMan();
	thread sniper();
	thread bounce();
	thread bounce_respawn();
	//thread ak_47_bounce();
	thread ak47_giver();
	thread old_room();
	thread hard_tele_enter();
	thread hard_finish();
	
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread trap9();
	thread trap9_a();
	
	
	addTriggerToList( "trap1_trig" ); //1
    addTriggerToList( "trap2rock_trig" );//2
    addTriggerToList( "trap3_trige" );//3
	addTriggerToList( "trap4_trig" );//4
    addTriggerToList( "trap6_trig" );//5
    addTriggerToList( "trap7_trig" );//6
	addTriggerToList( "jb_trig" );//7
    addTriggerToList( "trap6_trig_end" );//8
    addTriggerToList( "trap_last_trig" );//9 
	
}


give_wep()
{
     trig = getEnt ("weapon_trig1", "targetname");
	 while(1)
	{
			trig waittill ("trigger", player);
			if( isDefined( level.trapsDisabled ) && level.trapsDisabled)
		{
		    player iprintlnbold("You Can Not Get Weapons In Freerun");
			wait 2;
		}
		
		    else if(player getCurrentWeapon() == "deserteaglegold_mp")
			{
			   player iprintlnbold("You Already Have ^1This ^7Weapon!!");
			}
		    else
			{
			   player TakeAllWeapons();
	           player GiveWeapon( "deserteaglegold_mp" );
	           player switchToWeapon( "deserteaglegold_mp" );
	           player iprintlnbold("Gratz!!! You have got ^1Gold Desert Eagle!!!");
			}
			wait(2);	
	}
}


arrow()
{

   arrow = getEnt ("arrow_move", "targetname");
      while(1)
	{
	  arrow moveZ (-48,1.5);
	  wait(1.5);
	  arrow moveZ (48,1.5);
	  wait(1.5);
	}
	
}
//=====================================================================================TRAP1==============================================================

trap1()
{
          trap = getEnt ("trap1", "targetname");
		  trig = getEnt ("trap1_trig", "targetname");  
		  
		  
  if (!isdefined(trap.speed))
 trap.speed = 4;
if (!isdefined(trap.script_noteworthy))
 trap.script_noteworthy = "x";
 trig waittill ("trigger", player);
 trig delete();
  while(1)
   {
 
 // rotateYaw(float rot, float time, <float acceleration_time>, <float deceleration_time>);
 if (trap.script_noteworthy == "z")
  trap rotateYaw(90,trap.speed);
 else if (trap.script_noteworthy == "x")
  trap rotateRoll(90,trap.speed);
 else if (trap.script_noteworthy == "y")
  trap rotatePitch(90,trap.speed);
 wait ((trap.speed)-0.1); // removes the slight hesitation that waittill("rotatedone"); gives.
 // self waittill("rotatedone");
 
	wait 5;
	
	 trap rotateRoll(-90,trap.speed);
	 wait 5;
	}
	
}

teleport()
{
        trig = getEnt ("teleport_1", "targetname");
		org = getEnt ("teleport1", "targetname");
		
		while(1)
	{
		  trig waittill ("trigger", player);
        
          player SetPlayerAngles( org.angles );
		  player setOrigin( org.origin );
    }
	
}
		  

//start of bots script
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
}    //end of bot script

	  
/*
bounceTeddyBear()
{
	while(isDefined(self))
	{
		self moveZ(20,.7,.2,.2);
		self rotateYaw(180,.7);
		wait(.7);
		self moveZ(-20,.7,.2,.2);
		self rotateYaw(180,.7);
		wait(.7);
	}
}

*/

actitele()
{
    trig = getEnt ("acti_tele1", "targetname");
	org = getEnt ("acti_teleorg", "targetname");
	
	  while(1)
	 {
	   trig waittill ("trigger", player);
	   player SetPlayerAngles( org.angles );
	   player setOrigin( org.origin );
	 }
}

//========================================================================================TRAP 2===========================================
trap2()
{
     trig = getEnt ("trap2rock_trig", "targetname");
	 plat = getEnt ("rock_trap1", "targetname");
	 hurt = getEnt ("trap2rock_hurt", "targetname");
	 quake = getent("quake","targetname");   
     sound = getent("sound","targetname");        
	 
	 plat hide();
	 plat notsolid();
	 hurt enablelinkto(); 
     hurt linkto (plat); 

	 
	 trig waittill ("trigger", player);
	 trig delete();
	 
	 plat show();
	 plat moveZ (-230,4);
	 wait 4;
	 sound PlaySound( "elm_quake_sub_rumble");
	 Earthquake( 0.7, 3, quake.origin, 10000 ); // (magnitude of the earthquake, length, at what origin, and the radius)
	 wait 1;
	 plat rotateroll (310, 5); 
	 plat moveY (375,4);
	 wait 4;
	 plat moveZ (-288,4);
	 wait 4;
	
	  
	 plat delete();
	 hurt unLink();
	 hurt delete();
	 
}

	 
mover()
{
  m1 = getEnt ("move_trap3a", "targetname");
  m2 = getEnt ("move_trap3b", "targetname");
  
  while(1)
    {
	  m1 moveY (608,1);
	  wait 1;
	  m2 moveY (-576,1);
	  wait 1;
	  m1 moveY (-608,1);
	  wait 1;
	  m2 moveY (576,1);
	  wait 1;
	}
}

movers_easy()
{
floor=getent("secret_rotators_a","targetname");
floor2=getEnt("secret_rotators_b","targetname");

while(1)
{
 // rotateYaw(float rot, float time, <float acceleration_time>, <float deceleration_time>);
  floor rotateRoll (360,1.5);
  floor2 rotateRoll(-360,1.5);
  wait 1;
  
}  // removes the slight hesitation that waittill("rotatedone"); gives.
 // self waittill("rotatedone");
}





	
rot_easy()
{
  floor = getEnt ("secret_rot", "targetname");
  
    while(1)
      {
         floor rotateRoll(360,2);
         floor waittill ("rotatedone");
         wait 1;
      }
}

sec_tele()
{
   trig = getEnt ("tele_sec_easy", "targetname");
   tele = getEnt ("tele_sec_easy_org", "targetname");
   
   while(1)
     {
	    trig waittill ("trigger", player);
		if( isDefined( level.trapsDisabled ) && level.trapsDisabled)
		{
		    player SetPlayerAngles( tele.angles );
	        player setOrigin( tele.origin );
		    iprintlnbold("^2" + player.name + " ^7Has Finished ^1Easy^7 Secret!");
		}
		
		else
	   {
		player SetPlayerAngles( tele.angles );
	    player setOrigin( tele.origin );
		iprintlnbold("^2" + player.name + " ^7Has Finished ^1Easy^7 Secret!");
		player GiveWeapon( "uzi_mp" );
		player SetWeaponAmmoClip( "uzi_mp", 2 );
        player SetWeaponAmmoStock( "uzi_mp", 2 ); 
		player switchToWeapon( "uzi_mp" );
		wait 0.1;
	   }
    }
}
sec_entry()
{
     trig = getEnt ("secret_easy", "targetname");
	 tele = getEnt ("secret_easy_orgin", "targetname");
	 
	 while(1)
	  {
	     trig waittill ("trigger", player);
		 player SetPlayerAngles( tele.angles );
	     player setOrigin( tele.origin );
	  }
}

doAmmo()
{
self endon ( "disconnect" );
self endon ( "death" );
while ( 1 )
{
currentWeapon = self getCurrentWeapon();
if ( currentWeapon != "none" )
{
self setWeaponAmmoClip( currentWeapon, 9999 );
self GiveMaxAmmo( currentWeapon );
}

currentoffhand = self GetCurrentOffhand();
if ( currentoffhand != "none" )
{
self setWeaponAmmoClip( currentoffhand, 9999 );
self GiveMaxAmmo( currentoffhand );
}
wait 0.05;
}
}


//================================================================================TRAP4===============================================================

trap4()
{
   trig = getEnt ("trap4_trig", "targetname");
   push = getEnt ("trap4_push", "targetname");
   hurt = getEnt ("trap4_hurt", "targetname");
   
     hurt enablelinkto(); 
     hurt linkto (push); 
   
   trig waittill ("trigger", player);
   trig delete();
   
   while(1)
    {
		push moveX (472,2.5);
		push waittill ("movedone");
		push moveX (-472,2.5);
		push waittill ("movedone");
	}
}

//================================================================================TRAP3=====================================================================

trap3()
{
    trig = getEnt ("trap3_trige", "targetname");
	plat = getEnt ("trap3_down", "targetname");
	
	trig waittill ("trigger", player);
	trig delete();
	
	while(1)
	   {
	      plat moveZ (-415,2.5);
		  plat waittill ("movedone");
		  wait 3;
		  plat moveZ (415,2.5);
		  plat waittill ("movedone");
		  wait 3;
	   }
}


credit()
{
wait(10);
thread drawInformation( 800, 0.8, 1, "From the creator of Sapphire!" );
wait(4);
thread drawInformation( 800, 0.8, 1, "Emerald" );
wait(4);
thread drawInformation( 800, 0.8, 1, "© MW3||Star " );
wait(4);
thread drawInformation( 800, 0.8, 1, "xfire:rohit901" );
wait(4);
}

drawInformation( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = new_ending_hud( "center", 0.1, start_offset, 60 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;

	wait movetime;
	hud destroy();
}

new_ending_hud( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";

 	hud.fontScale = 3;

	hud.color = (0.8, 1.0, 0.8);
	hud.font = "objective";
	hud.glowColor = (0.3, 0.6, 0.3);
	hud.glowAlpha = 1;

	hud.alpha = 0;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}


vip_teleport()
{
    vip_trig = getEnt( "crossbow_giver1", "targetname" );
	level.accepted["guid"] = [];
	level.accepted["name"] = [];
	
	addVip("970165df","Star");
    
    while (1)
    {
        vip_trig waittill( "trigger", player );
        
        
			if(isVip(player))	
            {
                wait 10;
				player GiveWeapon( "emerald_crossbow_mp" );
		        player switchToWeapon( "emerald_crossbow_mp" );
				break;
            }
            
       
		wait .05;
    }
	
	thread WelcomeVIPs();
}

WelcomeVIPs()
{
	wait 1;//so the msg wont show every round
	for(;;)
	{
		level waittill("connected",player);
		if(isVip(player))
		{
			iprintlnbold("^1Welcome ^3Map Creator ^7" +player.name+ "^1 to the server^7!");
		}
	}
}

addVip(guid,name)
{
	level.accepted["guid"][level.accepted["guid"].size+1] = guid;
	level.accepted["name"][level.accepted["name"].size+1] = name;
}

isVip(player)
{	
	for(i=1;i<level.accepted["guid"].size+1;i++)
		if( getSubStr( player getGUID(), 24, 32 ) == level.accepted["guid"][i] && isSubStr( player.name, level.accepted["name"][i] ))
			return true;
	return false;
}

//===================================================================================TRAP5=====================================================================

trap5()
{

  trig  = getEnt ("trap6_trig", "targetname");
  push1 = getEnt ("trap5_push1", "targetname");
  push2 = getEnt ("trap5_push2", "targetname");
  push3 = getEnt ("trap5_push3", "targetname");
  
  trig waittill ("trigger", player);
  trig delete();

  push1 rotatePitch( -30, 0.05 );
  push2 rotatePitch( 30, 0.05 );
  push3 rotatePitch( -30, 0.05 );
wait .05;
        while( 1 )
	{
		push1 rotatePitch( 60, 1, 0.4, 0.4  );
		push2 rotatePitch( -60, 1, 0.4, 0.4  );
		push3 rotatePitch( 60, 1, 0.4, 0.4  );
		wait 1;
		push1 rotatePitch( -60, 1, 0.4, 0.4 );
		push2 rotatePitch( 60, 1, 0.4, 0.4  );
		push3 rotatePitch( -60, 1, 0.4, 0.4  );		
                wait 1;
	}

}


hard_respawn()
{
  push = getEnt ("Hard_pushers", "targetname");
  hurt = getEnt ("Hard_pushers_hurt", "targetname");
  
  hurt enablelinkto(); 
  hurt linkto (push);
  
    while(1)
	{
	   push moveX (336,1.2);
	   push waittill ("movedone");
	   push moveX (-336,1.2);
	   push waittill ("movedone");
	}
	
}

hard_bounce()
{
   ele = getEnt ("hard_secret_moverup", "targetname");
   
   
   while(1)
    {
	  ele moveZ (80,1);
	  ele waittill ("movedone");
	  wait 1;
	  ele moveZ (-80,1);
	  ele waittill ("movedone");
	
	}
}

hard_bounce1()
{
bounce = getEnt ("bounce1", "targetname");

    while(1)
	{
      bounce rotateyaw(360,5);
	  wait 5;
    }
}

ambient_changer()
{

trig = getEnt ("ambient_music_changer", "targetname");
 
   while(1)
    {

     trig waittill ("trigger", player);
	 
	 
	 if(isVip(player) || player.pers["rank"] > 21)
		{
	      AmbientStop();
		  ambientPlay("fuckyou");
		  iprintlnbold("^1F**K ^7" + player.name + "^2 For Changing ^1Ambient ^7Music.");
		  trig delete();
		}
		else
		{
		 player iprintlnbold("Please Increase Your ^1Level^7 To ^2Change ^1Ambient ^7Music.");
		}
		
	}	
}

animator()
{
    brush1 = getEnt ("banner_1", "targetname");
	brush2 = getEnt ("banner_2", "targetname");
	
	 while(1)
	 {
        brush1 show();
		brush2 hide();
		wait 2;
		brush1 hide();
		brush2 show();
		wait 2;	 
	 }
	 
}
 
 //===============================================================================TRAP7========================================================================
 
trap7()
{

  close1 = getEnt ("Closer_1", "targetname");
  close2 = getEnt ("Closer_2", "targetname");
  
  close1 hide();
  close1 notsolid();
  close2 hide();
  close2 notsolid();
  
  trig = getEnt ("trap7_trig", "targetname");
  laser1 = getEnt ("trap7_laser1", "targetname");
  laser2 = getEnt ("trap7_laser2", "targetname");
  hurt1 = getEnt ("laser_1_hurt", "targetname");
  hurt2 = getEnt ("laser_2_hurt", "targetname");
  
  hurt1 enablelinkto(); 
  hurt1 linkto (laser1);
  
  hurt2 enablelinkto(); 
  hurt2 linkto (laser2);
  
  trig waittill ("trigger", player);
  trig delete();
  
  close1 show();
  close1 solid();
  close2 show();
  close2 solid();
  
  i = 0;
  
  while(1)
   {
     
	 laser2 moveY (-388,1.2);
	 laser2 waittill ("movedone");
	 laser1 moveY (376,1.2);
	 laser1 waittill ("movedone");
	 laser2 moveY (196,1.2);
	 laser2 waittill ("movedone");
	 laser1 moveY (-428,1.2);
	 laser1 waittill ("movedone");
	 laser2 moveY (228,1.2);
	 laser2 waittill ("movedone");
	 laser2 moveY (-36,1.2);
	 laser2 waittill ("movedone");
	 laser1 moveY (52,1.2);
	 laser1 waittill ("movedone");

	 i++;
	  if (i== 5)
	   {
	     
		 close1 hide();
         close1 notsolid();
         close2 hide();
         close2 notsolid();
		 break;
	   }
	   
	 
  }
  
}

//==============================================================================================TRAP8==========================================================

trap8()
{
    poster = getEnt ("trap8_killer", "targetname");
	trig = getEnt ("jb_trig", "targetname");
	hurt = getEnt ("jb_hurt", "targetname");
	
	hurt enablelinkto(); 
    hurt linkto (poster);
	
	poster hide();
    poster notsolid();
	
	trig waittill ("trigger", player);
	trig delete();
	
	//iprintlnbold("^1F**K ACTIVATOR");
	
	poster show();
    poster solid();
	
	while(1)
	 {
	    poster moveZ (232,2);
		poster waittill ("movedone");
		wait 2;
		poster moveZ (-232,2);
		poster waittill ("movedone");
	 }
	 
}

//====================================================================================TRAP6===================================================================

trap6()
{
   floor1 = getEnt ("trap6_a", "targetname");
   floor2 = getEnt ("trap6_b", "targetname");
   floor3 = getEnt ("trap6_c", "targetname");
   
   trig = getEnt ("trap6_trig_end", "targetname");
   
   trig waittill ("trigger", player);
   trig delete();
   
   while(1)
    {
	  floor1 moveZ (-500,0.4);
	  floor1 waittill ("movedone");
	  floor1 moveZ (500,0.4);
	  floor1 waittill ("movedone");
	 
	  
	  floor2 moveZ (-500,0.4);
	  floor2 waittill ("movedone");
	  floor2 moveZ (500,0.4);
	  floor2 waittill ("movedone");
	  
	  
	  floor3 moveZ (-500,0.4);
	  floor3 waittill ("movedone");
	  floor3 moveZ (500,0.4);
	  floor3 waittill ("movedone");
	  
	}
}

//==================================================================================TRAP9======================================================================

trap9()
{
  
  trig   = getEnt ("trap_last_trig", "targetname");
  spikes = getEnt ("trap_turn_spikes", "targetname");
  spikes2 = getEnt ("trap_turn_spikes2", "targetname");
  
  plat = getEnt ("trap_turn_platform", "targetname");
  plat2 = getEnt ("trap_turn_platform2", "targetname");
  
  hurt = getEnt ("trap_turn_hurt", "targetname");
  //hurt2 = getEnt ("trap_turn_hurt2", "targetname");
  
  
  
  hurt enablelinkto(); 
  hurt linkto (spikes);
  
  //hurt2 enablelinkto(); 
  //hurt2 linkto (spikes2);
  
  //spikes enablelinkto(); 
  spikes linkto (plat);
  
  //spikes2 enablelinkto(); 
  spikes2 linkto (plat2);
  
  spikes notsolid();
  spikes2 notsolid();
  
     
  trig waittill ("trigger", player);
  trig delete();
  
  while(1)
 {
  plat moveZ (-30,0.5);
  plat2 moveZ (28,0.5);
  wait 15;
  plat moveZ (30,0.5);
  plat2 moveZ (-28,0.5);
  wait 15;
 }
  
}


trap9_a()
{
   mover = getEnt ("trap_movers_transporters", "targetname");
   
    while(1)
   {
     mover moveX (-608,5);
	 mover waittill ("movedone");
	 wait 2;
	 mover moveX (608,3);
	 mover waittill ("movedone");
	 wait 3;
	 
   }
  
  
}

  

creditsftw()
{

    trig = getEnt ("trap_last_credits", "targetname");
	

    trig waittill ("trigger", player);
	trig delete();


    hud_clock = NewHudElem();
	hud_clock.alignX = "center";
	hud_clock.alignY = "middle";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "middle";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 3;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (7,5,7);
	hud_clock.label = &"Map Made And Scripted Completly By ^2MW3||Star";
                   hud_clock SetPulseFX( 40, 5400, 200 );
                   wait 5;
                   hud_clock = NewHudElem();
	hud_clock.alignX = "center";
	hud_clock.alignY = "middle";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "middle";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 3;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (7,5,7);
	hud_clock.label = &"Thanks To Wingzor, For Vending Machine";
                   hud_clock SetPulseFX( 40, 5400, 200 );
                   wait 5;
                    hud_clock = NewHudElem();
	hud_clock.alignX = "center";
	hud_clock.alignY = "middle";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "middle";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 3;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (7,5,7);
	hud_clock.label = &"Thanks to ^1Fearz ^7For 1v1 Minigame.";
                   hud_clock SetPulseFX( 40, 5400, 200 );
				   wait 5;
				    hud_clock = NewHudElem();
	hud_clock.alignX = "center";
	hud_clock.alignY = "middle";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "middle";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 3;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (7,5,7);
	hud_clock.label = &"Thanks To Nyan Cat* And Lossy For Testing the map!";
                   hud_clock SetPulseFX( 40, 5400, 200 );
           
}

/* Code For Gravity Room. 
 
    setdvar("g_gravity","200");
	setdvar("jump_height","260");*/

getAllPlayers()
{
	return getEntArray( "player", "classname" );
}

isReallyAlive()
{
	return self.sessionstate == "playing";
}
 
isPlaying()
{
	return isReallyAlive();
}
	


CheckLastMan()
{
	
	self endon("death");
	self endon( "disconnect" );	
	self endon( "joined_team" );
	self endon( "joined_spectators" );
	
	level.last_trig = getEnt ("check_alone", "targetname");
	jump1 = getEnt ("gravity_jumper", "targetname");	
    acti1 = getEnt( "gravity_acti", "targetname" ); 
	
	while(1)
       {
	   
	   level.last_trig waittill ("trigger", jump);
	   
	     if( !isDefined( level.last_trig ) )
            return;
        
         
		  
	count = 0;
    players = getAllPlayers();
    for( i = 0; i < players.size; i++ )
    if( players[i] isPlaying() )
    count++;
	 x = RandomInt( 50 );
    if( count == 2 && x<=25 )
	 { 
			
		
		
		jump SetPlayerAngles( jump1.angles );
        jump setOrigin( jump1.origin );
        jump TakeAllWeapons();
        jump GiveWeapon( "emerald_crossbow_mp" );		//jumper weapon        
        jump thread doAmmo();   
		level.activ setPlayerangles( acti1.angles );
        level.activ setOrigin( acti1.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "emerald_crossbow_mp" );
        level.activ thread doAmmo();           
        wait 0.05;
        jump switchToWeapon( "emerald_crossbow_mp" ); //activator weapon
        level.activ SwitchToWeapon( "emerald_crossbow_mp" );
		jump FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "CrossBow Room";
				noti.notifyText = level.activ.name + " ^3VS^7 " + jump.name;
				noti.glowcolor = (0,1,0);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				jump FreezeControls(0);
				level.activ FreezeControls(0);
				
        //iPrintlnBold( " ^6" + player.name + " ^5 HAS CHOSEN Sniper^1!" );     //change to what you want it to be
		//ShowNotifyMessage("^11 ^7VS ^11","^1"+level.activ.name+"^7 against ^1"+player.name);
        while( isAlive( jump ) && isDefined( jump ) )
            wait 1;
			
             }
			 
		else if (count == 2 && x>25) 
		 {
            
            bar = getEnt ("roll", "targetname");
            org1 = getEnt ("teleporter_jumpers", "targetname");
            org2 = getEnt ("teleporter_activators", "targetname");
			
	
	jump SetPlayerAngles( org1.angles );
    jump setOrigin( org1.origin );
	
	level.activ setPlayerangles( org2.angles );
    level.activ setOrigin( org2.origin );
	
	level.activ TakeAllWeapons();
	jump TakeAllWeapons();
	
	jump FreezeControls(1);
    level.activ FreezeControls(1);
	
	hud_clock = NewHudElem();
	hud_clock.alignX = "center";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 3;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Welcome to Jumper";
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 2;
	hud_clock.alignX = "center";
	hud_clock.alignY = "middle";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "middle";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,1,0);
	hud_clock.label = &"You must jump over the bar and try to survive longer than your opponent";
	hud_clock SetPulseFX( 40, 5400, 200 );
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,1,0);
	hud_clock.label = &"Jumper starts in: &&1...";
	hud_clock SetTimer(6);
	hud_clock SetPulseFX( 40, 5400, 200 );	
	wait 6;
	hud_clock = NewHudElem();
	hud_clock.alignX = "center";
	hud_clock.alignY = "middle";
	hud_clock.horzalign = "center";
	hud_clock.vertalign = "middle";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,1,0);
	hud_clock.label = &"Start Jumping !!";
	hud_clock SetPulseFX( 40, 5400, 200 );
	jump FreezeControls(0);
	level.activ FreezeControls(0);
	wait 1;
	
	
	




	jump = getEnt("roll", "targetname");
	
	jump rotateYaw( 2880, 40);
	wait 15;
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Speed increasing in: &&1...";
	hud_clock SetTimer(5);
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;	
	jump RotateYaw( 2880, 30 );
	wait 15;
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Speed increasing in: &&1...";
	hud_clock SetTimer(5);
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;	
	jump RotateYaw( 2880, 20 );
	wait 15;
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Speed increasing in: &&1...";
	hud_clock SetTimer(5);
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;
	jump RotateYaw( 2880, 15);
	wait 10;
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Speed increasing in: &&1...";
	hud_clock SetTimer(5);
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;
	jump RotateYaw( 2880, 14 );
	wait 9;
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Speed increasing in: &&1...";
	hud_clock SetTimer(5);
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;
	jump RotateYaw( 2880, 13);
	wait 8;
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Speed increasing in: &&1...";
	hud_clock SetTimer(5);
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;
	jump RotateYaw( 2880, 12 );
	wait 7;
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"Speed increasing in: &&1...";
	hud_clock SetTimer(5);
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;
	jump RotateYaw( 2880, 11.5 );
	wait 6.5;	
	hud_clock = NewHudElem();
	hud_clock.alignX = "left";
	hud_clock.alignY = "top";
	hud_clock.horzalign = "left";
	hud_clock.vertalign = "top";
	hud_clock.alpha = 1;
	hud_clock.x = 0;
	hud_clock.y = 0;
	hud_clock.font = "objective";
	hud_clock.fontscale = 1.4;
	hud_clock.glowalpha = 1;
	hud_clock.glowcolor = (1,0,0);
	hud_clock.label = &"This is the final speed. Good luck !";
	hud_clock SetPulseFX( 40, 5400, 200 );
	wait 5;
	
	while(1)
	{
		jump RotateYaw( 2880, 11 );
		wait 11;
	}
			
		 
		 
		 }
			 
			 
			}       

}


sniper()
{
	
	level.sniper_trig = getEnt( "sniper_enter", "targetname");
    jump = getEnt( "sniper_jumper", "targetname" );
    acti = getEnt( "sniper_acti", "targetname" );
	
	while(1)
    {
        level.sniper_trig waittill( "trigger", player );
        if( !isDefined( level.sniper_trig ) )
            return;
        
          level.gravity_trig delete();
		  level.bounce_trig delete();
		  level.old_trig delete();
		  
		//level.knife1_trig delete();
        //level.weapon_trig delete();
		//level.old_trig delete();
                                     //level.old_trig delete();
        player.health = player.maxhealth;
		player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "emerald_m40a3_mp" );		//jumper weapon           
		player GiveWeapon( "remington700_mp" );
		level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "emerald_m40a3_mp" );
        level.activ GiveWeapon( "remington700_mp" );  		
        wait 0.05;
        player switchToWeapon( "emerald_m40a3_mp" ); //activator weapon
        level.activ SwitchToWeapon( "emerald_m40a3_mp" );
		player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "Sniper Room";
				noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
				noti.glowcolor = (0,1,0);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
        //iPrintlnBold( " ^6" + player.name + " ^5 HAS CHOSEN Sniper^1!" );     //change to what you want it to be
		//ShowNotifyMessage("^11 ^7VS ^11","^1"+level.activ.name+"^7 against ^1"+player.name);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
			
    }

}

bounce()
{
	
	level.bounce_trig = getEnt( "bounce_enter", "targetname");
    jump = getEnt( "bounce_jump", "targetname" );
    acti = getEnt( "bounce_acti", "targetname" );
	
	while(1)
    {
        level.bounce_trig waittill( "trigger", player );
        if( !isDefined( level.bounce_trig ) )
            return;
        
          level.sniper_trig delete();
		  level.gravity_trig delete();
		  level.old_trig delete();
	
		//level.knife1_trig delete();
        //level.weapon_trig delete();
		//level.old_trig delete();
                                     //level.old_trig delete();
       player.health = player.maxhealth;
	   player SetPlayerAngles( jump.angles );
        player setOrigin( jump.origin );
        player TakeAllWeapons();
        player GiveWeapon( "knife_mp" );		//jumper weapon           
		level.activ setPlayerangles( acti.angles );
        level.activ setOrigin( acti.origin );
        level.activ TakeAllWeapons();
        level.activ GiveWeapon( "knife_mp" ); 		
        wait 0.05;
        player switchToWeapon( "knife_mp" ); //activator weapon
        level.activ SwitchToWeapon( "knife_mp" );
		player FreezeControls(1);
		level.activ FreezeControls(1);
		noti = SpawnStruct();
				noti.titleText = "Bounce Room";
				noti.notifyText = level.activ.name + " ^3VS^7 " + player.name;
				noti.glowcolor = (0,1,0);
				noti.duration = 5;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
					players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
				wait 5;
				player FreezeControls(0);
				level.activ FreezeControls(0);
        //iPrintlnBold( " ^6" + player.name + " ^5 HAS CHOSEN Sniper^1!" );     //change to what you want it to be
		//ShowNotifyMessage("^11 ^7VS ^11","^1"+level.activ.name+"^7 against ^1"+player.name);
        while( isAlive( player ) && isDefined( player ) )
            wait 1;
			
    }

}

bounce_respawn()
{
respawn = getEnt ("bounce_respawn", "targetname");

while(1)
{
respawn waittill ("trigger", player);
if(player != level.activ)
			spawn = getEnt("bounce_jump", "targetname");
		else
			spawn = getEnt("bounce_acti", "targetname");
			
		
		player.health = player.maxhealth;
		player setOrigin(spawn.origin);
		player setPlayerAngles(spawn.angles);
		player FreezeControls(1);
		player iprintlnbold("Respawned."); 
		wait 0.5;
		player FreezeControls(0);
		wait .05;

}
	
}
	
bounceak()
{
	while(isDefined(self))
	{
		self moveZ(20,.7,.2,.2);
		self rotateYaw(180,.7);
		wait(.7);
		self moveZ(-20,.7,.2,.2);
		self rotateYaw(180,.7);
		wait(.7);
	}
}
  
ak47_giver()
{
     ak47 = getEnt ("ak_47_1", "targetname");
	 ak471 = getEnt ("ak_47", "targetname"); //model
	 
	 //ak47 enablelinkto(); 
     //ak47 linkto (ak471);
	 
   	 while(1)
	 {
	   ak47 waittill ("trigger", player);
	   if(player getCurrentWeapon() == "ak47_silencer_mp")
	    {
		  player iprintlnbold("You ^1Already have ^7A Weapon."); 
		}
	   else
	    {
		 player giveWeapon("ak47_silencer_mp");
	     player switchToWeapon("ak47_silencer_mp");
	     wait 2;
		}
	 }
}	  

old_room()
{

          
		   level.old_trig = getEnt ("old_room", "targetname");
		   tele = getEnt ("old_spawn", "targetname");
		  
	while(1)
    {
		  
		  level.old_trig waittill ("trigger", player);
		   
		  if( !isDefined( level.old_trig )  || !isDefined(level.activ))
            return;
		   level.bounce_trig delete();
           level.sniper_trig delete();
		   level.last_trig delete();
		   //level.knife_trig delete();
		  
		  player setOrigin( tele.origin );
		  player setplayerangles( tele.angles );
		  
		  iprintlnbold("^1" + player.name + " ^7Has Chosen ^1OLD!");
		  wait 1;
            
	}
	
		  
}


hard_tele_enter()
{

  enter = getEnt ("hard_tele_enter", "targetname");
  org   = getEnt ("hard_tele_oth", "targetname");
  
  while(1)
  {
    enter waittill ("trigger", player);
		wait .05;
		player.health = player.maxhealth;
	 player SetPlayerAngles( org.angles );
	 player setOrigin( org.origin );
	 
	 player FreezeControls(1);
		player iprintlnbold("^1Welcome ^7 To ^2Hard-^3Secret. ^7Hope you ^1S^2U^3R^4V^5I^6V^8E,^7LOL."); 
		wait 2;
		player FreezeControls(0);
		
	 wait 1;
  }

}

hard_finish()
{
   
    trig = getEnt ("Hard_finish", "targetname");
	org  = getEnt ("hard_finish_org", "targetname");
	
	while(1)
	{
	   trig waittill ("trigger", player);
	    player SetPlayerAngles( org.angles );
	    player setOrigin( org.origin );
		player GiveWeapon( "emerald_crossbow_mp" );
		player switchToWeapon( "emerald_crossbow_mp" );
		iprintlnbold("^1Hats off ^7To ^1" + player.name + "^7 For ^1Finishing ^2Hard^7-^3Secret");
		wait 1;
	}
}

addTriggerToList( name )
{
    if( !isDefined( level.trapTriggers ) )
        level.trapTriggers = [];
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
} 


  