main()
{
thread text();
//thread trap0();
thread trap2();
//thread trap3();
thread trap4();
//thread trap5();
thread trap6();
thread trap7();
thread trap8();
//thread trap9();
thread trap10();
thread fany();
level._effect[ "fire" ] = loadfx( "muzzleflashes/cobra_20mm_flash_mp" );
}


text()
{
while(1)
{
	iprintln ("^3Map by ^1PetX");
	wait 10;
	iprintln ("^4Thanks: ^2K4r3l01, R3MIEN");
	wait 10;
	iprintln ("^2www.4gf.cz");
    wait 10;
	iprintln ("^5For Gamers Fusion");
	wait 60;
}
}


trap0()
{
start = getent( "start" , "targetname" );
v = getent( "vrtula" , "targetname" );
wait 15;
start movez (-193, 1);
wait 10;

while (1)
  {
  v RotateYaw( 360, 2, 0.5, 0.5 );
  wait 10;
  }
}

trap2()
{
kill = getent ("t2_kill" ,"targetname");
trig = getent ("t2_trig" ,"targetname");
t2 = getent ("t2" , "targetname");

t2 waittill ("trigger");
t2 delete ();

trig enableLinkTo();
trig linkTo( kill );
trig thread killtrigger();
kill movez (-109, 4);

wait 6;
trig unLink();
trig delete();
kill movez (109, 4);
}

killtrigger()
{
while (1)
{
self waittill ("trigger", player);
player suicide();
}
}

trap3()
{
move = getent ("t3_move" ,"targetname");

while (1) 
{
move movey (-256, 3, 0.5, 0.5);
move waittill ("movedone");
move movey (256, 3, 0.5, 0.5);
move waittill ("movedone");
}
}

trap4()
{
t4 = getent ("t4" , "targetname");
kill = getent ("t4_kill" ,"targetname");
trig = getent ("t4_trig" ,"targetname");

t4 waittill ("trigger");
t4 delete ();

trig enableLinkTo();
trig linkTo( kill );
trig thread killtrigger();
kill rotatepitch (-180, 0.5);

wait 0.5;

trig unLink();
trig delete();
}

trap5()
{
rotate = getent( "t5_rotate" , "targetname" );
t5 = getent ("t5" , "targetname");
red = getent ("red5" ,"targetname"); //origin

t5 waittill ("trigger");
t5 delete ();
fx = PlayLoopedFX( level._effect["redflash"], 1, red.origin );

    while( 1 )
	{
    cas = 7;
	rotate rotatepitch( -360, cas );
    wait cas;
	}
}

trap6()
{
player1 = getent ("t6_player1" ,"targetname"); //origin
player2 = getent ("t6_player2" ,"targetname"); //origin
vrtula = getent ("t6_vrtula" ,"targetname"); //origin

player2 notsolid();

orig1 = player1.origin;
orig2 = player2.origin;
vrtula thread rotate(1);

while(1)
{
cas = 1.5;
player2 moveto(orig1,cas);
player1 moveto(orig2,cas);
wait cas+0.1;
player1 notsolid();
player2 solid();

player1 moveto(orig1,cas);
player2 moveto(orig2,cas);
wait cas+0.1;
player1 solid();
player2 notsolid();
}
}

trap7()
{
kill = getent ("t7_kill" ,"targetname");
door = getent ("t7_door" ,"targetname");
trig = getent ("t7_trig" ,"targetname");
fire = getent ("t7_fire" ,"targetname");
trig_fire = getent ("t7_firetrig" ,"targetname");
t7 = getent ("t7" , "targetname");

kill rotateroll(-18,0.5);
door movex (-202,5);

t7 waittill ("trigger");
t7 delete ();

door movex (202,5);
wait 5;

trig waittill("trigger");
kill rotateroll(36,0.8);

wait 2;
fx = PlayFX( level._effect["fire"], fire.origin , fire.angles);
trig_fire thread killtrigger();
wait 0.5;
trig_fire delete();

}

trap8()
{
t8 = getent ("t8" , "targetname");
level.trig1 = getent ("t8_trig1" ,"targetname");
level.kill1 = getent ("t8_kill1" ,"targetname");
level.trig2 = getent ("t8_trig2" ,"targetname");
level.kill2 = getent ("t8_kill2" ,"targetname");

level.kill1 movez(64,0.5);
level.kill2 movez(64,0.5);
wait 0.5;

t8 waittill ("trigger");
t8 delete ();

if ( randomInt(99)%2 == 0 )
thread kill2();
else
thread kill1(); 
}

kill1()
{
cas = 0.3;

level.kill1 movez (-176, cas );
wait 0.2;
level.trig1 thread killtrigger();
wait 0.2;
level.trig1 delete();
}

kill2()
{
cas = 0.3;

level.kill2 movez (-176, cas );
wait 0.2;
level.trig2 thread killtrigger();
wait 0.2;
level.trig2 delete();
}

trap10()
{
door = getent( "t10_door" , "targetname" );
t10 = getent ("t10" , "targetname");
kill = getent ("t10_kill" , "targetname");
trig = getent ("t10_trig" , "targetname");
//trig_door = getent ("t10_doortrig" , "targetname");

t10 waittill ("trigger");
t10 delete ();

//trig_door enableLinkTo();
//trig_door linkTo( door );
//trig_door thread killtrigger();
door rotateyaw ( 90, 2 );
wait 2;
//trig_door unlink();
//trig_door delete();

wait 2;

trig thread killtrigger();

	for( x = 0 ; x < 20 ; x++)
	{
	kill rotateyaw (-360, 0.3);
	wait 0.3;
	}

trig delete();	
	
wait 1;

door rotateyaw ( -90, 2 );
}

rotate(rychlost)
{
      while(1)
      {
       self rotateyaw (360, rychlost);
       wait rychlost;
      }
}

fany()
{
	fan = getentarray( "fan1", "targetname" );
	fan_end = getentarray( "fan_end", "targetname" );
 
	if(isdefined(fan))
	{
		thread removeKillTrigger();
		for( i = 0; i < fan.size; i++ )
			fan[i] thread fan_off();
	}
	
	if(isdefined(fan_end))
	{
		for( i = 0; i < fan_end.size; i++ )
			fan_end[i] thread rotate(10);
	}
}

fan_off()
{
trig = getent("fan_use" , "targetname");

level.fan_use = false;

self thread rotate_fan();

trig waittill("trigger");
trig setHintString("");

level.fan_use = true;
}

rotate_fan()
{
      while(1)
      {
       self rotateyaw (360, 1);
       wait 1;
	   
	   	if ( isDefined(level.fan_use) ) 
		{
			if ( level.fan_use == true )
            {			
			self thread spomalenie();
			return;
			}
		}	
      }
}


removeKillTrigger() {
	level waittill("zmaz_trigger");
	
	kill_trig = getent("fan_kill_trig" , "targetname");
	if ( isDefined(kill_trig) )  {
		kill_trig delete();
	}
}

spomalenie()
{


	for( x = 1.5 ; x < 4.5 ;)
	{
		self rotateyaw (360, x);
		wait x; 
		

    if ( x == 3 ) {
		level notify("zmaz_trigger");
	}

			
		x = x+0.5;
	}

	//if ( !isDefined(level.kill_trig) ) 
	//{
    //kill_trig = getent("fan_kill" , "targetname");

    //kill_trig delete();
	//iprintln ("delete");
	//return;
	//}
}

