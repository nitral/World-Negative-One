public class CSServerInfo
{
	private StringBuffer ipAndPort = new StringBuffer();
	private StringBuffer serverName = new StringBuffer();
	private StringBuffer map = new StringBuffer();
	private StringBuffer gameDir = new StringBuffer();
	private StringBuffer gameDesc = new StringBuffer();
	private byte numPlayers;
	private byte maxPlayers;
	private byte netVersion;
	private byte dedicated;
	// private boolean isDedicated;
	private byte os;
	private byte password;
	private boolean hasPassword;
	private byte isMod;
	private ModData modInfo = new ModData();
	private byte secure;
	// private boolean isSecure;
	private byte numBots;
	private String address;

	private byte[] buffer;

	/** Creates a new instance of CSServerInfo */
	public CSServerInfo(byte[] buffer, String address)
	{
		this.buffer = buffer;
		this.address = address;

		parseInformation();
	}

	private void parseInformation()
	{
		int index = 4;         // Discard first 4 bytes

		char m = RawByteParser.parseChar(index, buffer);
		if(m != 'm')
			return;
		index++;

		index += RawByteParser.parseString(index, buffer, ipAndPort);
		index += RawByteParser.parseString(index, buffer, serverName);
		index += RawByteParser.parseString(index, buffer, map);
		index += RawByteParser.parseString(index, buffer, gameDir);
		index += RawByteParser.parseString(index, buffer, gameDesc);

		numPlayers = buffer[index];
		index++;
		maxPlayers = buffer[index];
		index++;

		netVersion = buffer[index];
		index++;
		dedicated = buffer[index];
		index++;
		os = buffer[index];
		index++;
		password = buffer[index];
		index++;
		if(password == 1)
			hasPassword = true;
		else
			hasPassword = false;
		isMod = buffer[index];
		index++;
		if(isMod == 1)
			modInfo.parse(buffer, index);
		index += modInfo.length();

		secure = buffer[index];
		index++;
		numBots = buffer[index];
		index++;
	}

	public String toString()
	{
		StringBuffer serverInfo = new StringBuffer();
		
		if(serverName.length() <= 8)
			serverInfo.append(serverName + "\t\t\t");
		else if(serverName.length() <= 14)
			serverInfo.append(serverName + "\t\t");
		else
			serverInfo.append(serverName + "\t");
		
		serverInfo.append(address + ":27015\t\t" + numPlayers + "(" + numBots + ")/" + maxPlayers);
		
		if(numPlayers < 10)
			serverInfo.append("\t\t");
		else
			serverInfo.append("\t");
		
		serverInfo.append(map + "");
		
		if(map.length() < 8)
			serverInfo.append("\t\t\t");
		else
			serverInfo.append("\t\t");

		if(hasPassword)
			serverInfo.append("Yes\n");
		else
			serverInfo.append("No\n");
		serverInfo.append("-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n");

		return serverInfo.toString();
	}
}
