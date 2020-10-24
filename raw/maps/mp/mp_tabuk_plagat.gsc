main()
{
    plagat = getent ("plagat", "targetname");
    plagat2 = getent ("plagat2", "targetname");
    
    while(true)
    {
       plagat movey (-2, 2);
       plagat2 movey (2, 2);
       wait (10);
       plagat movey (2, 2);
       plagat2 movey (-2, 2);
       wait (10);
    }
}