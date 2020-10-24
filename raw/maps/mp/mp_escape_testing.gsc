main()
{
	maps\mp\_load::main();

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");	
	
	//thread plugins\maps\_bots::AddBot( "emitor", "podlozka" );
	thread TestEntAtt();
}

TestEntAtt()
{
	wait 5;
	ent = GetEnt( "abcd", "targetname" );

}