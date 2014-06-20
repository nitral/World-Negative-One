var playerState = true;

function playerStop (ID)
{
	musicPlayer = document.getElementById(ID);
	musicPlayer.pause();
	musicPlayer.currentTime = 0;
}

function playerStart(ID)
{
	musicPlayer = document.getElementById(ID);
	musicPlayer.play();
}

function toggle(ID)
{
	if(playerState == true)
	{
		playerStop(ID)
		playerState = false;
	}
	else
	{
		playerStart(ID)
		playerState = true;
	}
}