main()
{
rings = getent( "rings", "targetname" );
while(1)
{
rings waittill ("trigger");
thread rings();
}
}
rings()
{
origin = getent( "origin", "targetname" ); //brana 1
level.origin2 = getent( "origin2", "targetname" ); // brana2

trigger = spawn( "trigger_radius", origin.origin, 0, 40, 40);
trigger thread teleport();
wait (10);
trigger delete();
}

teleport()
{
 while (1)
 {
    self waittill("trigger",player);
    player setorigin(level.origin2.origin);
    player setplayerangles(level.origin2.angles);
 }
}