main()
{

	//***************************//
    //maps\mp\_load::main();
	
	thread hmota();
	
	//***** script ******//
	maps\mp\mp_ze_factory\_traps::main();
	//maps\mp\mp_dr_jurapark\visual::main();
	//maps\mp\mp_dr_jurapark\mp_dr_jurapark::main();

	//***************************//

        game["allies"] = "sas";
        game["axis"] = "opfor";
        game["attackers"] = "axis";
        game["defenders"] = "allies";
        game["allies_soldiertype"] = "woodland";
        game["axis_soldiertype"] = "woodland";
}

hmota()
{
	orig = getent("trigger_hmota", "targetname");
	
	trig = spawn("trigger_radius", orig.origin, 0, 100, 500);
	trig SetContents( 1 );
}