main()
{

        level._effect[ "dust_spiral_runner" ]			        = loadfx( "dust/dust_spiral_runner" );                                                                                   
        level._effect[ "dust_wind_slow_yel_loop" ]			= loadfx( "dust/dust_wind_slow_yel_loop" );
        
	thread efekty();
}
efekty()
{
dust_spiral = playloopedFx(level._effect["dust_spiral_runner"], 0.05, ( 2672, 640, 508), 0, anglestoforward ((270,0,0)), anglestoup((0,0,0)));	
dust = playloopedFx(level._effect["dust_wind_slow_yel_loop"], 1, ( -384, -448, 608), 0, anglestoforward ((270,0,0)), anglestoup((0,0,0)));
}
