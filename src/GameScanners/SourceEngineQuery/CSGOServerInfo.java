public class CSGOServerInfo {

	private String address;
	private StringBuffer serverName = new StringBuffer();
	private StringBuffer map = new StringBuffer();
	private StringBuffer gameDir = new StringBuffer();
	private StringBuffer gameDesc = new StringBuffer();
	private byte[] buffer;

	public CSGOServerInfo(byte[] data, String address) {
		this.address = address;
		this.buffer = data;
		parseInformation();
	}

	private void parseInformation() {
		int index = 7;
		index += RawByteParser.parseString(index, buffer, serverName);
		index += RawByteParser.parseString(index, buffer, map);
		index += RawByteParser.parseString(index, buffer, gameDir);
		index += RawByteParser.parseString(index, buffer, gameDesc);
	}

	public String toString() {
		StringBuffer serverInfo = new StringBuffer();

		if (serverName.length() <= 8)
			serverInfo.append(serverName + "\t\t\t");
		else if (serverName.length() <= 14)
			serverInfo.append(serverName + "\t\t");
		else
			serverInfo.append(serverName + "\t");

		serverInfo.append(address + ":27015\t" + map + "\n");
		serverInfo.append("---------------------------------------------------------------------------------------------------\n");

		return serverInfo.toString();
	}
}
