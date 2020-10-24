main()
{
	level._effect[ "smoke_large" ]	              = loadfx( "smoke/smoke_large" );
	level._effect[ "dust_wind_slow_yel_loop" ]    = loadfx( "dust/dust_wind_slow_yel_loop" );

/#
	if ( getdvar( "clientSideEffects" ) != "1" )
		maps\createfx\mp_tabuk_fx::main();
#/		
}
