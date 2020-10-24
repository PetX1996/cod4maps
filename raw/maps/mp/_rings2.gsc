main()
{
rings = getent( "rings", "targetname" );
level.port = false;
thread teleport();

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

//level.port = false;

level.trigger = spawn( "trigger_radius", origin.origin, 0, 40, 40);


level.port = true;
wait (10);
level.port = false;
//level.trigger delete();
}

teleport()
{
 while (1)
 {
    while(level.port)
    {
    level.trigger waittill("trigger",player);
    player setorigin(level.origin2.origin);
    player setplayerangles(level.origin2.angles);
    }
 wait 0.01;
 }
}