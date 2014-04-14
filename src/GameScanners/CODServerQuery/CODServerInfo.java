import java.util.ArrayList;

public class CODServerInfo {

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

	// Creates a new instance of CSServerInfo
	public CODServerInfo(byte[] buffer, String address) {
		this.buffer = buffer;
		this.address = address;
		parseInformation();
	}

	public void parseInformation() {
		int index = 20;      														   // Discard first 20 bytes

		StringBuffer stringBuffer = new StringBuffer();

		while (!stringBuffer.toString().equals("g_compassShowEnemies")) {
			stringBuffer = new StringBuffer();
			index += RawByteParser.parseString(index, buffer, stringBuffer);
		}

		// Compass Shows Enemies
		if (buffer[index] == 48)
			compassShowEnemies = false;
		else
			compassShowEnemies = true;
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, gameType);					// Game Type
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, gameName);					// Game Name
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, map);							// Map Name
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, protocol);					// Protocol Used
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, version);						// Version Number
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		// Server Allows Anonymous
		if (buffer[index] == 48)
			allowAnonymous = false;
		else
			allowAnonymous = true;
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		// Server Disabled Client Console
		if (buffer[index] == 48)
			disableClientConsole = false;
		else
			disableClientConsole = true;
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		floodProtect = buffer[index] - 48;												// Flood Protect
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, serverName);					// Server Name
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, maxPlayers);					// Max Players
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, maxPing);						// Max Ping Allowed
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, maxRate);						// Max Rate
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, minPing);						// Min Ping
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		privateClients = (byte) (buffer[index] & 0xFF - 48);							// Private Clients
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		// Server Has Punkbuster
		if (buffer[index] == 48)
			hasPunkbuster = false;
		else
			hasPunkbuster = true;
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		// Server Pure Attribute
		if (buffer[index] == 48)
			isPure = false;
		else
			isPure = true;
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		// Server has Voice Enabled
		if (buffer[index] == 48)
			voiceEnabled = false;
		else
			voiceEnabled = true;
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		index += RawByteParser.parseString(index, buffer, maxUIClients);				// Max UI Clients
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		// Server is Password Protected
		if (buffer[index] == 48)
			hasPassword = false;
		else
			hasPassword = true;
		index += 2;
		index += RawByteParser.parseString(index, buffer, stringBuffer);				// Field Name
		// Server Has Mod Enabled
		if (buffer[index] == 48)
			hasMod = false;
		else
			hasMod = true;
		index += 2;

		// Making Player List
		numPlayers = 0;
		while (true) {
			String playerStats = "";
			while (((char) (buffer[index] & 0xFF)) != 10) {
				if (((char) (buffer[index] & 0xFF)) == 0)
					break;
				playerStats += (char) (buffer[index++] & 0xFF);
			}
			index++;
			String[] splitPlayerStats = playerStats.split(" ");

			if (splitPlayerStats[0] == "")
				break;

			String playerName = "";
			for (int i = 2; i < splitPlayerStats.length; i++)
				playerName += splitPlayerStats[i];
			playerList.add(playerName.substring(1, playerName.length() - 1));
			numPlayers++;
		}

		// Determine Game Type
		if (gameType.toString().equals("dm"))
			gameType = new StringBuffer("Free - for - All");
		else if (gameType.toString().equals("dom"))
			gameType = new StringBuffer("Domination");
		else if (gameType.toString().equals("koth"))
			gameType = new StringBuffer("Headquarters");
		else if (gameType.toString().equals("sab"))
			gameType = new StringBuffer("Sabotage");
		else if (gameType.toString().equals("sd"))
			gameType = new StringBuffer("Search & Destroy");
		else if (gameType.toString().equals("war"))
			gameType = new StringBuffer("Team Deathmatch");
	}

	public String toString() {
		StringBuffer serverInfo = new StringBuffer();

		if (serverName.length() < 8)
			serverInfo.append(serverName + "\t\t\t");
		else if (serverName.length() <= 14)
			serverInfo.append(serverName + "\t\t");
		else
			serverInfo.append(serverName + "\t");

		serverInfo.append(address + ":28960\t\t" + numPlayers + "/" + maxPlayers + "\t\t" + map + "\t\t" + gameType + "\t\t");
		if (hasPassword)
			serverInfo.append("Yes\n\n");
		else
			serverInfo.append("No\n\n");

		serverInfo.append("--=-= Players List =-=--\n");
		for (int i = 0; i < playerList.size() - 1; i++)
			serverInfo.append(playerList.get(i) + ", ");

		if (playerList.size() == 0)
			serverInfo.append("\n");
		else
			serverInfo.append(playerList.get(playerList.size() - 1) + "\n");

		serverInfo
				.append("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n");

		return serverInfo.toString();
	}
}
