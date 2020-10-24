main()
{

	//***************************//
    //maps\mp\_load::main();
	
	//***** script ******//
	maps\mp\mp_dr_jurapark\traps::main();
	maps\mp\mp_dr_jurapark\visual::main();
	//maps\mp\mp_dr_jurapark\mp_dr_jurapark::main();

	//***************************//

        game["allies"] = "sas";
        game["axis"] = "opfor";
        game["attackers"] = "axis";
        game["defenders"] = "allies";
        game["allies_soldiertype"] = "woodland";
        game["axis_soldiertype"] = "woodland";
}