public class ModData
{
	private StringBuffer URLInfo = new StringBuffer();
	private StringBuffer URLDL = new StringBuffer();
	private long modVersion;
	private long modSize;
	private byte svOnly;
	private byte cldll;

	private int size = 0;

	/** Creates a new instance of ModData */
	public ModData()
	{
	}

	public void parse(byte[] data, int begin)
	{
		// URLInfodata
		int pos = begin;
		pos += RawByteParser.parseString(pos, data, URLInfo);
		pos += RawByteParser.parseString(pos, data, URLDL);
		pos++;         // jump over the empty string ("\0");
		modVersion = RawByteParser.parseLong(pos, data);
		pos += 4;
		modSize = RawByteParser.parseLong(pos, data) / (1024 * 1024);     // in MB
		pos += 4;
		svOnly = data[pos];
		pos++;
		cldll = data[pos];
		pos++;

		size = pos - begin;
	}

	public int length()
	{
		return size;
	}

	public String toString()
	{
		StringBuffer res = new StringBuffer("ModiInfo:\n");
		res.append("\nURLInfo:   \t" + URLInfo);
		res.append("\nURLDL:     \t" + URLDL);
		res.append("\nVersion:   \t" + modVersion);
		res.append("\nSize:      \t" + modSize + " mb");
		res.append("\nServerSide:\t" + svOnly);
		res.append("\nCustom dll:\t" + cldll);
		return res.toString();
	}
}
