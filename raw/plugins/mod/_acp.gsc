















#include scripts\_acp; 


init()
{
	thread OnConnectedPlayer();
}

OnPlayerConnected() 
{
	while( true )
	{
		level waittill( "connected", player );
		
		player thread AddACPButton();
	}
}

AddACPButton()
{
	self endon( "disconnect" );

	while( true )
	{
		self waittill( "ACP_list_complete" );
		
		
		AddButton( 0, "MyButton", "Call my function by clicking", 40, ::MyFunction );
	}
}

MyFunction()
{
	iprintlnbold( "Admin ^1"+self.name+" ^7clicked on custom ACP button!" );
}
