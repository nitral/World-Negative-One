public class DOTAServerInfo {

	private String address;
	private StringBuffer serverName = new StringBuffer();
	private byte[] buffer;

	public DOTAServerInfo(byte[] data, String address) {
		this.address = address;
		this.buffer = data;
		parseInformation();
	}

	private void parseInformation() {
		int index = 6;
		index += RawByteParser.parseString(index, buffer, serverName);
	}

	public String toString() {
		StringBuffer serverInfo = new StringBuffer();

		if (serverName.length() <= 8)
			serverInfo.append(serverName + "\t\t\t");
		else if (serverName.length() <= 14)
			serverInfo.append(serverName + "\t\t");
		else
			serverInfo.append(serverName + "\t");

		serverInfo.append(address + ":27015\n");
		serverInfo.append("----------------------------------------------------------------------\n");

		return serverInfo.toString();
	}
}
