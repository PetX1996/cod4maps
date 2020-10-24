main()
{
thread rotor_2();
}
rotor_2()
{
	trig = getEnt( "trap3", "targetname" );
	brush = getEnt( "rotor2", "targetname" );

	trig waittill( "trigger", who );
	trig delete();
	
	maps\mp\mp_deathrun_zero\coins::AddCoin( 3, level.coinPrice );

	while( isDefined( brush ) )
	{
		brush rotateRoll( -180, 5 );
		wait 3;
	}
}