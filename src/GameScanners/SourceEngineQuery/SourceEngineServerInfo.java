public class SourceEngineServerInfo
{
	public SourceEngineServerInfo(byte[] buffer, long ping, String address)
	{
	}

	public static String getGameType(byte[] buffer)
	{
		/*
		for(byte data : buffer)
			System.out.print((char) (data & 0xff));
		*/
		
		if(isCSServer(buffer))
			return "cs";
		else if(isDOTAServer(buffer))
			return "dota";
		else if(isCSGOServer(buffer))
			return "csgo";
		else
			return "";
	}

	private static boolean isDOTAServer(byte[] buffer)
	{
		StringBuffer buf = new StringBuffer();
		StringBuffer gameName = new StringBuffer();

		int index = 6;

		index += RawByteParser.parseString(index, buffer, buf);
		index += RawByteParser.parseString(index, buffer, buf);
		index += RawByteParser.parseString(index, buffer, gameName);

		if(gameName.toString().equals("dota"))
			return true;
		else
			return false;
	}

	private static boolean isCSGOServer(byte[] buffer2)
	{
		return true;
	}

	private static boolean isCSServer(byte[] buffer)
	{
		StringBuffer buf = new StringBuffer();
		StringBuffer gameName = new StringBuffer();

		int index = 5;         // Discard first 4 bytes

		index += RawByteParser.parseString(index, buffer, buf);
		index += RawByteParser.parseString(index, buffer, buf);
		index += RawByteParser.parseString(index, buffer, buf);
		index += RawByteParser.parseString(index, buffer, gameName);

		if(gameName.toString().equals("cstrike"))
			return true;
		else
			return false;

	}
}
