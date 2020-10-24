main()
{

	level._effect[ "gaterun" ]	           			= loadfx( "stargate/gate_run" );
	level._effect[ "gaterun_off" ]	           		= loadfx( "stargate/gate_run_off" );
	level._effect[ "gatestart" ]	           		= loadfx( "stargate/gate_start" );
	level._effect[ "rings" ]	           		= loadfx( "stargate/rings" );
	level._effect[ "greenstatic" ]					= loadfx( "misc/lift_light_green" );

/#
	if ( getdvar( "clientSideEffects" ) != "1" )
		maps\createfx\mp_test_fx::main();
#/		
}