main()
{

doortriggers = getentarray("doortrigger","targetname");
for(i=0;i<doortriggers.size;i++)
doortriggers[i] thread door_think();
}

door_think()
{
self.doormoving = false;
self.doorclosed = true;
self.doormodel = getent(self.target, "targetname");

while (1)
{
self waittill("trigger");
if(!self.doormoving)
self thread door_move();
}
}

door_move()
{
self.doormoving = true;
if(self.doorclosed)
{
self.doormodel rotateyaw(90,1,0.5,0.5);
self.doormodel waittill("rotatedone");
self.doorclosed = false;
}
else
{
self.doormodel rotateyaw(-90,1,0.5,0.5);
self.doormodel waittill("rotatedone");
self.doorclosed = true;
}
self.doormoving = false;
}
