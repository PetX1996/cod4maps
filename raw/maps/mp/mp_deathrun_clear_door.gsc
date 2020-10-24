main()
{
thread door_b();
thread door_c();
}

door_b()
{
	trig = getent ("door_b_trig" , "targetname");
	trig waittill ("trigger",player);
	trig delete ();
	ambientPlay("doorb_clear");
}

door_c()
{
	trig = getent ("door_c_trig" , "targetname");
	door_c = getent ("door_c" ,"targetname" );
    teleport = getent ("teleport1" ,"targetname" );
	trig waittill ("trigger",player);
	trig delete ();
	player deathrun\include\_mapper::CFinishMap();
	iprintlnbold ("^3---^1" + player.name + "^3--- ^2open FINAL door!");
	door_c movex (-129, 3, 0.5, 0.5);
    wait 5;
	teleport thread teleport();
}

teleport()
{
orig = getent ("heli2" , "targetname");

self waittill ("trigger" , player);
player setorigin(orig.origin);
player setplayerangles(orig.angles);
self delete();
}