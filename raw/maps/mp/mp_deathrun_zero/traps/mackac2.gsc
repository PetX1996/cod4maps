main()
{
	thread mackac2();
}

mackac2()
{
	trig = getEnt( "trap4", "targetname" );

	trig waittill( "trigger", who );
	trig delete();
	
	maps\mp\mp_deathrun_zero\coins::AddCoin( 4, level.coinPrice );

	brush = undefined;
	
	if ( randomInt(99)%2 == 0 )
		brush = getEnt( "mackac2", "targetname" );
	else
		brush = getEnt( "mackac22", "targetname" );

	
	brush moveX( -1350, 3 );
	wait 5;
	brush moveX( 1350, 3 );
}