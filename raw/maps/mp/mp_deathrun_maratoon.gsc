main()
{
thread Trap1();
thread Trap2();
thread Trap3();
thread Trap4();
thread Open();
thread End();
}

Trap1()
{
trap1=getent("trap1","targetname");
trigger=getent("multiple","targetname");
while(1)
{
trigger waittill ("trigger");
wait 1;
trap1 moveX (22000,300);
trap1 waittill ("movedone");
}
}

Trap2()
{
trap2=getent("trap2","targetname");
trigger=getent("trigtrap2","targetname");
while(1)
{
trigger waittill ("trigger");
wait 1;
Trap2 movez (-60,2);
Trap2 waittill ("movedone");
}
}

Trap3()
{
trap3=getent("trap3","targetname");
trigger=getent("trigtrap3","targetname");
while(1)
{
trigger waittill ("trigger");
wait 1;
Trap3 movey (316,3);
Trap3 waittill ("movedone");
wait 10;
Trap3 movey (-316,3);
Trap3 waittill ("movedone");
wait 60;
}
}

Trap4()
{
trap4=getent("trap4","targetname");
trigger=getent("trigtrap4","targetname");
while(1)
{
trigger waittill ("trigger");
wait 1;
Trap4 movez (250,1);
Trap4 waittill ("movedone");
}
}

Open()
{
open=getent("open","targetname");
trigger=getent("trigopen","targetname");
while(1)
{
trigger waittill ("trigger");
wait 1;
Open movez (250,3);
Open waittill ("movedone");
}
}

End()
{
end=getent("end","targetname");
while(1)
{
wait 20;
end movey (-178,5);
end waittill ("movedone");
}
}