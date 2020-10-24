main()
{

	//***************************//
    maps\mp\_load::main();
	maps\mp\mp_sg_hatak_fx::main();

	thread antibug();
	
	//***** STARGATE ******//
	maps\mp\stargate\_door_hatak::init();
	maps\mp\stargate\_door_sgc::init();
	maps\mp\stargate\_rings::main();
	maps\mp\stargate\sgc_base::main();

	//***************************//

        game["allies"] = "sas";
        game["axis"] = "opfor";
        game["attackers"] = "axis";
        game["defenders"] = "allies";
        game["allies_soldiertype"] = "woodland";
        game["axis_soldiertype"] = "woodland";
}

//******************************************//
//************ANTIBUG SYSTEM****************//
//******************************************//
//*********** CREATED PetX *****************//
//******************************************//
//***********THANKS Strejda*****************//
//******************************************//

antibug()
{
	wait 1;
	
	trig = spawn( "trigger_radius", (-1940,1031,-623) , 0, 4019, 503); //Spawn( <classname>, <origin>, <flags>, <radius>, <height> )
	trig thread start_sec();
	/*trig = spawn( "trigger_radius", (2110,1623,370) , 0, 130, 185); //Spawn( <classname>, <origin>, <flags>, <radius>, <height> )
	trig thread start_sec();	*/
}
	
start_sec()
{	
	while(1)
	{
		players = getentarray("player","classname");
		for(i = 0;i<players.size;i++)
		{
			player = players[i];
			if(isplayer(player)&&isalive(player)&&player IsTouching(self))
			{	
				player iprintlnbold("This is ^1BUG!! ^7You ^1killed!!");
				player suicide();
			}
		}
		wait 0.5;
	}
}