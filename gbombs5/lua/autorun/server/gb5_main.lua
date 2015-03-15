AddCSLuaFile()
util.AddNetworkString( "gbombs5_cvar" )
util.AddNetworkString( "gbombs5_net" )
SetGlobalString ( "gb_ver", 5 )

net.Receive( "gbombs5_cvar", function( len, pl ) 
	if( !pl:IsAdmin() ) then return end
	local cvar = net.ReadString();
	local val = net.ReadFloat();
	if( GetConVar( tostring( cvar ) ) == nil ) then return end
	if( GetConVarNumber( tostring( cvar ) ) == tonumber( val ) ) then return end

	game.ConsoleCommand( tostring( cvar ) .." ".. tostring( val ) .."\n" );

end );


function gb5_initialize()
	Msg("\n Garry's Bombs 5 successfully initialised!")
end
hook.Add( "InitPostEntity", "gb5_initialize", gb5_initialize )


function gb5_spawn(ply)
	ply.gasmasked=false
	ply.hazsuited=false
	net.Start( "gbombs5_net" )        
		net.WriteBit( false )
		ply:StopSound("breathing")
	net.Send(ply)
end
hook.Add( "PlayerSpawn", "gb5_spawn", gb5_spawn )	