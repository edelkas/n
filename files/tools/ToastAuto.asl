state("N++")
{
	int levelID : 0x0004B698, 0xC, 0x88, 0x1C, 0xA0;
	int gameTime : "npp.dll", 0xE8F4B8, 0x7CC8;
}

start
{
	vars.totalTime = 0.0;
}

update
{
	if (current.gameTime > old.gameTime) {
		vars.totalTime+=(current.gameTime-old.gameTime)/60.0;
	}
	return true;
}

split
{
	if (current.levelID > old.levelID) {return true;}
}

isLoading
{
	return true;
}

gameTime
{
	return TimeSpan.FromSeconds(System.Convert.ToDouble(vars.totalTime));
}