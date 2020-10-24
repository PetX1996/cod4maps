#include common_scripts\utility;
main()
{
thread debug();
thread rotate();
}

debug()
{
	deb = getent ("laser_emitor", "targetname");
	for(;;)
	{
	playfxontag(level._effect[ "laser" ], deb, "tag_fx");
	wait 0.01;
	}
}

rotate()
{
	deb = getent ("laser_emitor", "targetname");
	for (;;)
	{
	deb rotateYaw ( 360, 5);
	wait 0.01;
	}
}