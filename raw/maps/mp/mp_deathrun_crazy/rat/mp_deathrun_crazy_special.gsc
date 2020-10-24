main()
{
thread use_touch_trigger();
thread door();
}


use_touch_trigger()
{
	use = getentarray( "special_gula", "targetname" );
 
	if(isdefined(use))
	{
		for( i = 0; i < use.size; i++ )
			use[i] thread moved();
	}
}
 
moved()
{
	while(1)
	{
    self waittill ("trigger");
    self thread pohyb();
	}
}

pohyb()
{
gula = getEnt( self.target, "targetname" );
orig_trig = getEnt( gula.target, "targetname" );
trig = getEnt( orig_trig.target, "targetname" );
origin1 = getEnt( trig.target, "targetname" );
origin2 = getEnt( origin1.target, "targetname" );
barikada = getEnt( origin2.target, "targetname" );
self delete();

cas1 = 5;
cas2 = 2;

barikada movez (-120, 1);
wait 0.4;

trig enableLinkTo();
trig linkTo( orig_trig );
trig thread killtrigger();

gula moveto(origin1.origin, cas1);

gula thread rotate(cas1,cas2);

orig_trig moveto(origin1.origin, cas1);
gula waittill("movedone");
gula moveto(origin2.origin, cas2);
orig_trig moveto(origin2.origin, cas2);
gula waittill("movedone");

trig unLink();
trig delete();
orig_trig delete();
}

killtrigger()
{
	while (1)
	{
	self waittill ("trigger", player);
	player suicide();
	}
}

rotate(cas1,cas2)
{
self rotatepitch (-360, (cas1+cas2)/2);
wait (cas1+cas2)/2;
self rotatepitch (-360, (cas1+cas2)/2);
}

door()
{
trig = getent ( "special_door_trig", "targetname");
door = getent ( "special_door", "targetname");

trig waittill ("trigger");

door movey(128, 3);
}