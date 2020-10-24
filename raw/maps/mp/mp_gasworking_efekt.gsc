main()
{

        level._effect[ "watersplash_small_chtr" ]			        = loadfx( "misc/watersplash_small_chtr" );                                                                                   
        
	thread efekty();
}
efekty()
{
watersplash_small_chtr = playloopedFx(level._effect["watersplash_small_chtr"], 0.5, ( 608, 91, -249), 0, anglestoforward ((270,0,0)), anglestoup((0,0,0)));	
}
