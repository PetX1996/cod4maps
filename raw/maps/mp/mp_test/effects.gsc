main()
{	
	level._effect[ "greenstatic" ]		= loadfx( "misc/lift_light_green" );
	thread createeffect();
	level.showeffect = false;
	thread test();
}
createeffect()
{
level.showeffect = false;
level.effect = getentarray ("test","targetname");

for(i=0; i<level.effect.size; i++)
{
level.effect[i] thread calleffect();
}
}
calleffect()
{
      while(1)
      {
              while(level.showeffect)
              {
                      PlayFX( level._effect[ "greenstatic" ], self.origin );
                      wait 0.1;
              }
              wait 0.05;
      }
}
test()
{
level.showeffect = false;//vypne efekt
wait(10);
level.showeffect = true;//zapne efekt
wait(10);
level.showeffect = false;
wait(10);
level.showeffect = true;
wait(10);
level.showeffect = false;
}

