import java.util.ArrayList;

public class CODServerInfo
{
	private boolean compassShowEnemies;
	private StringBuffer gameType = new StringBuffer();
	private StringBuffer gameName = new StringBuffer();
	private StringBuffer map = new StringBuffer();
	private StringBuffer protocol = new StringBuffer();
	private StringBuffer version = new StringBuffer();
	private boolean allowAnonymous;
	private boolean disableClientConsole;
	private int floodProtect;
	private StringBuffer serverName = new StringBuffer();
	private StringBuffer maxPlayers = new StringBuffer();
	private StringBuffer maxPing = new StringBuffer();
	private StringBuffer maxRate = new StringBuffer();
	private StringBuffer minPing = new StringBuffer();
	private byte privateClients;
	private boolean hasPunkbuster;
	private boolean isPure;
	private boolean voiceEnabled;
	private StringBuffer maxUIClients = new StringBuffer();
	private boolean hasPassword;
	private boolean hasMod;

	private ArrayList<String> playerList = new ArrayList<>();
	private byte numPlayers;

	private String address;

	private byte[] buffer;

	/** Creates a new instance of CSServerInfo */
	public CODServerInfo(byte[] buffer, String address)
	{
		this.buffer = buffer;
		this.address = address;

		parseInformation();
	}

	public void parseInformation()
	{
		int index = 20;         // Discard first 20 bytes

		StringBuffer stringBuffer = new StringBuffer();

		while(!stringBuffer.toString().equals("g_compassShowEnemies"))
		{
			stringBuffer = new StringBuffer();
			index += RawByteParser.parseString(index, buffer, stringBuffer);
		}
		// index += RawByteParser.parseString(index, buffer, stringBuffer);
		if(buffer[index] == 48)
			compassShowEnemies = false;
		else
			compassShowEnemies = true;
		index += 2;
		// System.out.println(compassShowEnemies);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, gameType);
		// System.out.println(gameType);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, gameName);
		// System.out.println(gameName);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, map);
		// System.out.println(map);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, protocol);
		// System.out.println(protocol);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, version);
		// System.out.println(version);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		if(buffer[index] == 48)
			allowAnonymous = false;
		else
			allowAnonymous = true;
		index += 2;
		// System.out.println(allowAnonymous);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		if(buffer[index] == 48)
			disableClientConsole = false;
		else
			disableClientConsole = true;
		index += 2;
		// System.out.println(disableClientConsole);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		floodProtect = buffer[index] - 48;
		// System.out.println("FLOOD PROTECT = " + floodProtect);
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, serverName);
		// System.out.println(serverName);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, maxPlayers);
		// System.out.println(maxPlayers);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, maxPing);
		// System.out.println(maxPing);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, maxRate);
		// System.out.println(maxRate);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, minPing);
		// System.out.println(minPing);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		privateClients = (byte) (buffer[index] & 0xFF - 48);
		index += 2;
		// System.out.println(privateClients);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		if(buffer[index] == 48)
			hasPunkbuster = false;
		else
			hasPunkbuster = true;
		index += 2;
		// System.out.println(hasPunkbuster);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		if(buffer[index] == 48)
			isPure = false;
		else
			isPure = true;
		index += 2;
		// System.out.println(isPure);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		if(buffer[index] == 48)
			voiceEnabled = false;
		else
			voiceEnabled = true;
		index += 2;
		// System.out.println(voiceEnabled);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		index += RawByteParser.parseString(index, buffer, maxUIClients);
		// System.out.println(stringBuffer);
		// System.out.println("MAX UI CLIENTS = " + maxUIClients);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		if(buffer[index] == 48)
			hasPassword = false;
		else
			hasPassword = true;
		index += 2;
		// System.out.println(hasPassword);
		index += RawByteParser.parseString(index, buffer, stringBuffer);
		// System.out.println(stringBuffer);
		if(buffer[index] == 48)
			hasMod = false;
		else
			hasMod = true;
		index += 2;
		// System.out.println(hasMod);

		// Making Player List
		numPlayers = 0;
		while(true)
		{
			String playerStats = "";
			while(((char) (buffer[index] & 0xFF)) != 10)
			{
				if(((char) (buffer[index] & 0xFF)) == 0)
					break;
				playerStats += (char) (buffer[index++] & 0xFF);
				// System.out.println("a" + ((char) (buffer[index] & 0xFF)));
			}
			index++;
			String[] splitPlayerStats = playerStats.split(" ");

			if(splitPlayerStats[0] == "")
				break;

			String playerName = "";
			for(int i = 2 ; i < splitPlayerStats.length ; i++)
				playerName += splitPlayerStats[i];
			playerList.add(playerName.substring(1, playerName.length() - 1));
			// System.out.println(playerList.get(numPlayers));
			numPlayers++;
			// System.out.println(numPlayers);
		}

		// Determine Game Type
		if(gameType.toString().equals("dm"))
			gameType = new StringBuffer("Free - for - All");
		else if(gameType.toString().equals("dom"))
			gameType = new StringBuffer("Domination");
		else if(gameType.toString().equals("koth"))
			gameType = new StringBuffer("Headquarters");
		else if(gameType.toString().equals("sab"))
			gameType = new StringBuffer("Sabotage");
		else if(gameType.toString().equals("sd"))
			gameType = new StringBuffer("Search & Destroy");
		else if(gameType.toString().equals("war"))
			gameType = new StringBuffer("Team Deathmatch");

	}

	public String toString()
	{
		StringBuffer serverInfo = new StringBuffer();

		if(serverName.length() < 8)
			serverInfo.append(serverName + "\t\t\t");
		else if(serverName.length() <= 14)
			serverInfo.append(serverName + "\t\t");
		else
			serverInfo.append(serverName + "\t");

		serverInfo.append(address + ":28960\t\t" + numPlayers + "/" + maxPlayers + "\t\t" + map + "\t\t"
				+ gameType + "\t\t");
		if(hasPassword)
			serverInfo.append("Yes\n\n");
		else
			serverInfo.append("No\n\n");

		serverInfo.append("--=-= Players List =-=--\n");
		for(int i = 0 ; i < playerList.size() - 1 ; i++)
			serverInfo.append(playerList.get(i) + ", ");

		if(playerList.size() == 0)
			serverInfo.append("\n");
		else
			serverInfo.append(playerList.get(playerList.size() - 1) + "\n");

		serverInfo.append("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n");

		return serverInfo.toString();
	}
}
