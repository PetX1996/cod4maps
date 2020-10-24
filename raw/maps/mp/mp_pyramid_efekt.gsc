main()
{

        level._effect[ "firelp_barrel_pm" ]			        = loadfx( "fire/firelp_barrel_pm" );                                                                                   
        
	thread efekty();
}
efekty()
{
firelp_barrel_pm = playloopedFx(level._effect["firelp_barrel_pm"], 0.5, ( 392, -8, 1334), 0, anglestoforward ((270,0,0)), anglestoup((0,0,0)));	
firelp_barrel_pm = playloopedFx(level._effect["firelp_barrel_pm"], 0.5, ( 600, -8, 1334), 0, anglestoforward ((270,0,0)), anglestoup((0,0,0)));
}
