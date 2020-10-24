
















PluginInfo(name, author, version)
{
	if(!isdefined(level.plugins))
		level.plugins = [];
	
	size = level.plugins.size;
	level.plugins[size]["name"] = name;
	level.plugins[size]["author"] = author;
	level.plugins[size]["ver"] = version;
}

PluginsError( text )
{
	if( !isDefined( level.MapErrors ) )
		level.MapErrors = [];
	
	level.MapErrors[level.MapErrors.size] = "^3Plugins - ^7"+text;
}
