main()
{
	thread mackac1();
}

mackac1()
{
	trig = getEnt( "tmackac1", "targetname" );
	brush = getEnt( "mackac1", "targetname" );

	trig waittill( "trigger", who );
	trig delete();

	brush moveY( -370, 3 );
	wait 4;
	brush moveY( 370, 3 );
}