#include common_scripts\utility;

main()
{
thread laser();
thread text();
//thread trap0();
thread trap1();
thread trap2();
thread trap2_b();
thread trap3();
thread trap4();
thread trap5();
thread trap6();
thread trap7();
thread trap8();
thread trap8_b();
thread trap9();
thread trap10();
thread trap11();
thread lod();
thread lod2();
thread lod3();
thread lod4();
level._effect[ "redflash" ] = loadfx( "misc/icbm_post_light_red" );
level._effect[ "jed" ] = loadfx( "impacts/water_leak" );
level._effect[ "dym2" ] = loadfx( "smoke/car_damage_whitesmoke" );
level._effect[ "blesk" ] = loadfx( "misc/blesky2" );
level._effect[ "laser" ] = loadfx( "misc/laser" );
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

trap1()
{
jed = getent( "jed" , "targetname" );
jed2 = getent( "jed2" , "targetname" );
dym = getent( "t1_dym" , "targetname" );
dym2 = getent( "t1_dym2" , "targetname" );
door = getent( "t1_door" , "targetname" );
red = getent ("red1" ,"targetname"); //origin
t1 = getent ("t1" , "targetname");
kill = getent ("t1_kill" , "targetname");
trig = getent ("t1_trig" , "targetname");
door_trig = getent ("plyn_door_trig" , "targetname");

door movex ( -129, 0.5 );

t1 waittill ("trigger");
t1 delete ();
fx = PlayLoopedFX(level._effect["redflash"], 1, red.origin );

door movex ( 129, 2 , 0.5, 0.5 );
wait 2;

door_trig thread killtrigger();

wait 1;

door_trig delete();

fx = PlayloopedFX(level._effect["jed"], 0.2, jed.origin, 0, anglestoforward ((90,0,0)), anglestoup((0,0,0))); 
fx2 = PlayloopedFX(level._effect["jed"], 0.2, jed2.origin, 0, anglestoforward ((90,0,0)), anglestoup((0,0,0))); 
fx3 = PlayloopedFX(level._effect["dym2"], 0.2, dym.origin); 
fx4 = PlayloopedFX(level._effect["dym2"], 0.2, dym2.origin); 

wait 2;

trig enableLinkTo();
trig linkTo( kill );
kill movez (192, 1);
wait 1;
fx delete();
fx2 delete();
trig unlink();
kill delete();
trig delete();
wait 2;

fx3 delete();
fx4 delete();
door movex ( -129, 2 , 0.5, 0.5 );
door waittill ("movedone");
}

trap2()
{
kill = getent ("t2_kill" ,"targetname");
trig = getent ("t2_trig" ,"targetname");
t2 = getent ("t2" , "targetname");
r1 = getent ("t2_rotate1" ,"targetname");
r2 = getent ("t2_rotate2" ,"targetname");

kill movez (-144, 1);

t2 waittill ("trigger");
t2 delete ();

r1 thread rotate();
r2 thread rotate();

trig enableLinkTo();
trig linkTo( kill );
kill movez (128, 2);

wait 4;
trig unLink();
trig delete();
kill movez (-128, 2);
}

trap2_b()
{
move = getent ("t2_move" ,"targetname");

while (1) 
{
move movey (-1152, 6, 2, 2);
wait 6;
move movey (1152, 6, 2, 2);
wait 6;
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
kill = getent ("t4_rotate" ,"targetname");
trig = getent ("t4_trig" ,"targetname");
red = getent ("red4" ,"targetname"); //origin

t4 waittill ("trigger");
t4 delete ();

fx = PlayLoopedFX( level._effect["redflash"], 1, red.origin );

trig enableLinkTo();
trig linkTo( kill );
kill rotatepitch (180, 3);

wait 8;

kill rotatepitch (-180, 3);
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
t6 = getent ("t6" , "targetname");
kill = getent ("t6_kill" ,"targetname");
trig = getent ("t6_trig" ,"targetname");
red = getent ("red6" ,"targetname"); //origin
origin1 = getent ("t6_orig1" ,"targetname"); //origin
origin2 = getent ("t6_orig2" ,"targetname"); //origin
origin3 = getent ("t6_orig3" ,"targetname"); //origin
origin4 = getent ("t6_orig4" ,"targetname"); //origin

t6 waittill ("trigger");
t6 delete ();

fx = PlayLoopedFX( level._effect["redflash"], 1, red.origin );
fx1 = PlayLoopedFX( level._effect["blesk"], 1, origin1.origin );
fx2 = PlayLoopedFX( level._effect["blesk"], 1, origin2.origin );
fx3 = PlayLoopedFX( level._effect["blesk"], 1, origin3.origin );
fx4 = PlayLoopedFX( level._effect["blesk"], 1, origin4.origin );

trig enableLinkTo();
trig linkTo( kill );
kill movez (176, 0.05);

wait 10;

fx1 delete();
fx2 delete();
fx3 delete();
fx4 delete();

trig unLink();
trig delete();
kill delete();
}

trap7()
{
part1 = getentarray ("part1" ,"targetname");
part2 = getentarray ("part2" ,"targetname");
part3 = getentarray ("part3" ,"targetname");
part4 = getentarray ("part4" ,"targetname");
part5 = getentarray ("part5" ,"targetname");
part6 = getentarray ("part6" ,"targetname");
part7 = getentarray ("part7" ,"targetname");
part8 = getentarray ("part8" ,"targetname");
part9 = getentarray ("part9" ,"targetname");
part10 = getentarray ("part10" ,"targetname");
part11 = getentarray ("part11" ,"targetname");
part12 = getentarray ("part12" ,"targetname");
part13 = getentarray ("part13" ,"targetname");

red = getent ("red7" ,"targetname"); //origin
t7 = getent ("t7" , "targetname");

t7 waittill ("trigger");
t7 delete ();
fx = PlayLoopedFX(level._effect["redflash"], 1, red.origin );

part1[randomInt(part1.size)] notsolid();
part2[randomInt(part2.size)] notsolid();
part3[randomInt(part3.size)] notsolid();
part4[randomInt(part4.size)] notsolid();
part5[randomInt(part5.size)] notsolid();
part6[randomInt(part6.size)] notsolid();
part7[randomInt(part7.size)] notsolid();
part8[randomInt(part8.size)] notsolid();
part9[randomInt(part9.size)] notsolid();
part10[randomInt(part10.size)] notsolid();
part11[randomInt(part11.size)] notsolid();
part12[randomInt(part12.size)] notsolid();
part13[randomInt(part13.size)] notsolid();
}

trap8()
{
t8 = getent ("t8" , "targetname");
kill = getent ("t8_kill" ,"targetname");
trig = getent ("t8_trig" ,"targetname");
red = getent ("red8" ,"targetname"); //origin

kill movex (176, 3);

t8 waittill ("trigger");
t8 delete ();

fx = PlayLoopedFX( level._effect["redflash"], 1, red.origin );

trig enableLinkTo();
trig linkTo( kill );
kill movex (-176, 3);

wait 8;

kill movex (176, 3);
trig unLink();
trig delete();
}

trap8_b()
{
move = getent ("t8_move" ,"targetname");

while (1) 
{
move movey (-832, 4, 1, 1);
wait 4;
move movey (832, 4, 1, 1);
wait 4;
}
}

trap9()
{
part1 = getentarray ("t9_a" ,"targetname");
part2 = getentarray ("t9_b" ,"targetname");
t9 = getent ("t9" , "targetname");

t9 waittill ("trigger");
t9 delete ();

part1[randomInt(part1.size)] delete();
part2[randomInt(part2.size)] delete();
}

trap10()
{
door = getent( "t10_dvere" , "targetname" );
red = getent ("red10" ,"targetname"); //origin
t10 = getent ("t10" , "targetname");
kill = getent ("t10_kill" , "targetname");
trig = getent ("t10_trig" , "targetname");
door_trig = getent ("mackac_door_trig" , "targetname");

door movex ( -129, 0.5 );

t10 waittill ("trigger");
t10 delete ();
fx = PlayLoopedFX(level._effect["redflash"], 1, red.origin );

door movex ( 129, 2 , 0.5, 0.5 );
wait 2;

door_trig thread killtrigger();

wait 1;

door_trig delete();

trig enableLinkTo();
trig linkTo( kill );
kill movex (448, 8);
wait 10;
kill movex (-448, 8);
wait 8;
trig unlink();
trig delete();
wait 1;

door movex ( -129, 2 , 0.5, 0.5 );
door waittill ("movedone");
}

trap11()
{
	laser1 = getent( "laser1" , "targetname" ); //laser1=deb1
	laser2 = getent( "laser2" , "targetname" ); //laser2=deb2
	orig1_laser = getent( "laser1_orig" , "targetname" ); //laser1=deb1
	orig2_laser = getent( "laser2_orig" , "targetname" ); //laser2=deb2
	door = getent( "t11_door" , "targetname" );
	red = getent ("red11" ,"targetname"); //origin
	t11 = getent ("t11" , "targetname");
	trig = getent ("laser1_trig" , "targetname");
	trig2 = getent ("laser2_trig" , "targetname");
	deb1 = getent ("laser_emitter", "targetname");
	deb2 = getent ("laser_emitter2", "targetname");
	orig1_deb = getent ("laser_emitter_orig", "targetname");
	orig2_deb = getent ("laser_emitter2_orig", "targetname");
	door_trig = getent ("lasery_door_trig" , "targetname");

	door movex ( -129, 0.5 );

	t11 waittill ("trigger");
	t11 delete ();
	fx = PlayLoopedFX(level._effect["redflash"], 1, red.origin );

	//thread laser();

	door movex ( 129, 2 , 0.5, 0.5 );
	wait 2;

	door_trig thread killtrigger();

	wait 1;

	door_trig delete();

	laser1_orig1 = orig1_laser.origin;
	laser2_orig2 = orig2_laser.origin;
	deb1_orig1 = orig1_deb.origin;
	deb2_orig2 = orig2_deb.origin;

	laser1_orig = laser1.origin;
	laser2_orig = laser2.origin;
	deb1_orig = deb1.origin;
	deb2_orig = deb2.origin;

	a = RandomIntRange(15,432);
	b = RandomIntRange(30,432);
	c = RandomIntRange(60,432);
	d = RandomIntRange(90,432);
	e = RandomIntRange(120,432);
	f = RandomIntRange(150,432);


	trig enableLinkTo();
	trig linkTo( laser1 );
	laser1 movey (0-a, a/150);
	deb1 movey (0-a, a/150);

	trig2 enableLinkTo();
	trig2 linkTo( laser2 );
	laser2 movey (b, b/150);
	deb2 movey (b, b/150);

	wait 3;

	laser1 moveto (laser1_orig1, e/100);
	deb1 moveto (deb1_orig1, e/100);
	wait 1;
	laser2 moveto (laser2_orig2, e/100);
	deb2 moveto (deb2_orig2, e/100);

	wait 5;

	laser1 movey (c, c/150);
	deb1 movey (c, c/150);

	laser2 movey (0-d, d/150);
	deb2 movey (0-d, d/150);

	wait 3;

	laser1 moveto (laser1_orig1, f/100);
	laser2 moveto (laser2_orig2, f/100);
	deb1 moveto (deb1_orig1, f/100);
	deb2 moveto (deb2_orig2, f/100);

	wait 5;

	laser1 movey (e, c/150);
	deb1 movey (e, c/150);

	laser2 movey (0-f, d/150);
	deb2 movey (0-f, d/150);

	wait 3;

	laser1 moveto (laser1_orig, b/150);
	laser2 moveto (laser2_orig, b/150);
	deb1 moveto (deb1_orig, b/150);
	deb2 moveto (deb2_orig, b/150);

	wait 3;
	
	laser1 movey (0-e, c/150);
	deb1 movey (0-e, c/150);

	laser2 movey (f, d/150);
	deb2 movey (f, d/150);

	wait 3;
	
	laser1 moveto (laser1_orig1, f/100);
	laser2 moveto (laser2_orig2, f/100);
	deb1 moveto (deb1_orig1, f/100);
	deb2 moveto (deb2_orig2, f/100);

	wait 5;

	laser1 movey (e, c/150);
	deb1 movey (e, c/150);

	laser2 movey (0-f, d/150);
	deb2 movey (0-f, d/150);

	wait 3;

	laser1 moveto (laser1_orig, b/150);
	laser2 moveto (laser2_orig, b/150);
	deb1 moveto (deb1_orig, b/150);
	deb2 moveto (deb2_orig, b/150);

	wait 3;

	trig unlink();
	trig2 unlink();
	wait 1;

	door movex ( -129, 2 , 0.5, 0.5 );
	door waittill ("movedone");
}

killtrigger()
{
while (1)
{
self waittill ("trigger", player);
player suicide();
}
}

lod()
{
lod = getent( "lod" , "targetname" );
lod1 = getent( "lod1" , "targetname" );
trig = getent( "lod_trig" , "targetname" );

trig waittill("trigger");
z = 60;
lod movex (-3072, z , 20 , 20);
lod1 movex (-3072, z , 20 , 20);
}

lod2()
{
t = getent ("l1" , "targetname");

t waittill ("trigger");
t delete ();

if ( randomInt(99)%2 == 0 )
thread kill2();
else
thread kill1(); 
}

kill1()
{
kill = getent ("lod1_kill1" ,"targetname");
trig = getent ("lod1_trig1" ,"targetname");

trig enableLinkTo();
trig linkTo( kill );
kill movez (-240, 1);

wait 8;

kill movez (240, 8);
trig unLink();
trig delete();
}

kill2()
{
kill = getent ("lod1_kill2" ,"targetname");
trig = getent ("lod1_trig2" ,"targetname");

trig enableLinkTo();
trig linkTo( kill );
kill movez (-240, 1);

wait 6;

kill movez (240, 8);
trig unLink();
trig delete();
}

lod3()
{
t = getent ("l2" , "targetname");
kill = getent ("lod2_kill" ,"targetname");
trig = getent ("lod2_trig" ,"targetname");

t waittill ("trigger");
t delete ();

trig enableLinkTo();
trig linkTo( kill );

while (1)
{
kill rotateyaw (180, 3);
wait 8;
kill rotateyaw (-180, 3);
wait 8;
}
}

lod4()
{
t = getent ("l4" , "targetname");
kill1 = getent ("l4_kill1" ,"targetname");
kill2 = getent ("l4_kill2" ,"targetname");

kill1 movez (-144, 1);
kill2 movez (-144, 1);

t waittill ("trigger");
t delete ();

if ( randomInt(99)%2 == 0 )
thread kill2_2();
else
thread kill1_2(); 
}

kill1_2()
{
kill = getent ("l4_kill1" ,"targetname");
trig = getent ("l4_trig1" ,"targetname");

trig enableLinkTo();
trig linkTo( kill );
kill movez (144, 1);

wait 5;

kill movez (-144, 5);
trig unLink();
trig delete();
}

kill2_2()
{
kill = getent ("l4_kill2" ,"targetname");
trig = getent ("l4_trig2" ,"targetname");

trig enableLinkTo();
trig linkTo( kill );
kill movez (144, 1);

wait 5;

kill movez (-144, 5);
trig unLink();
trig delete();
}

laser()
{ 
 level._effect[ "laser" ] = loadfx( "misc/laser" );

while (1)
{ 
 wait 5;

 thread create_laser();
 thread create_laser3();
 thread create_laser2();
 thread create_laser4();
 
 wait 120;
}
}

create_laser()
{
level.laser = getentarray ("laser_emitter","targetname");

for(i=0; i<level.laser.size; i++)
{
level.laser[i] thread call_laser();
}
}
call_laser()
{
      //while(1)
      //{
       PlayFXontag( level._effect[ "laser" ], self, "tag_fx" );
                      //wait 0.001;
      //}
}

create_laser3()
{
level.laser3 = getentarray ("laser1","targetname");

for(i=0; i<level.laser3.size; i++)
{
level.laser3[i] thread call_laser3();
}
}
call_laser3()
{
      //while(1)
      //{
       PlayFXontag( level._effect[ "laser" ], self, "tag_fx" );
                      //wait 0.001;
      //}
}

create_laser2()
{
level.laser2 = getentarray ("laser_emitter2","targetname");

for(i=0; i<level.laser2.size; i++)
{
level.laser2[i] thread call_laser2();
}
}
call_laser2()
{
      //while(1)
      //{
       PlayFXontag( level._effect[ "laser" ], self, "tag_fx" );
                      //wait 0.001;
      //}
}

create_laser4()
{
level.laser4 = getentarray ("laser2","targetname");

for(i=0; i<level.laser4.size; i++)
{
level.laser4[i] thread call_laser4();
}
}
call_laser4()
{
      //while(1)
      //{
       PlayFXontag( level._effect[ "laser" ], self, "tag_fx" );
                      //wait 0.001;
      //}
}

rotate()
{
      while(1)
      {
       self rotatepitch (360, 3);
       wait 3;
      }
}