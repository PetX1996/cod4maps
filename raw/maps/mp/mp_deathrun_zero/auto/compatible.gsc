main()
{
	thread compatible();
}

compatible()
{
	plat = getEnt ("comp" , "targetname");
	{
	plat moveX (-5000 , 0.1 );
	}
}