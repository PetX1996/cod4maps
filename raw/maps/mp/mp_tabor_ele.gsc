main()
{
  level.elevatorDown = true;
  level.elevatorMoving = false;
  thread elevator_start();
}

elevator_start()
{
  elevator = getentarray ("switch","targetname");
  if ( isdefined(elevator) )
  for (i = 0; i < elevator.size; i++)
  elevator[i] thread elevator_think();
}

elevator_think()
{
  while (1)
  {
   self waittill ("trigger");
   if (!level.elevatorMoving)
   thread elevator_move();
  }
}

elevator_move()
{
  elevatormodel = getent ("elevator", "targetname");
  level.elevatorMoving = true;
  speed = 1;
  height =334;
  if (level.elevatorDown) 
  {
   elevatormodel playsound ("elevator");
   elevatormodel movez (height, speed);
   elevatormodel waittill ("movedone");
   level.elevatorDown = false;
  }
  else
  {
   elevatormodel playsound ("elevator");
   elevatormodel movez (height - (height * 2), speed);
   elevatormodel waittill ("movedone");
   level.elevatorDown = true;
  }
  level.elevatorMoving = false;
}
