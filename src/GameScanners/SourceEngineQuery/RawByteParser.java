public class RawByteParser {

	/**
	 * Extracts a C formatted string out of the byte buffer. The buffer is not affected by this method. The resulting string is stored into the StringBuffer.
	 * 
	 * @param offset
	 *            Index of the first character of the string to be extracted
	 * @param data
	 *            Byte buffer where the string is.
	 * @param res
	 *            StringBuffer where the string will be stored
	 * @return the length of the extracted string plus the null character.
	 */
	public static int parseString(int offset, byte[] data, StringBuffer res) {
		int i = offset;
		while (data[i] != 0) {
			char c = RawByteParser.parseChar(i, data);
			res.append(c);
			i++;
		}
		return i - offset + 1;
	}

	/**
	 * Read a long C value from the data buffer. This method takes 4 bytes of the buffer and convert them into a single long. The buffer is not affected by this method.
	 * 
	 * @param offset
	 *            index of the first byte to be parsed
	 * @param data
	 *            byte buffer.
	 * @return the long value.
	 */
	public static long parseLong(int offset, byte[] data) {
		long a = (data[offset]) & 0xffL;
		long b = (data[offset + 1] << 8) & 0xff00L;
		long c = (data[offset + 2] << 16) & 0xff0000L;
		long d = (data[offset + 3] << 24) & 0xff000000L;
		long res = a + b + c + d;
		return res;
	}

	/**
	 * Read a byte value from the data buffer and returns the unsigned representation. The buffer is not affected by this method.
	 * 
	 * @param offset
	 *            index of the first byte to be parsed
	 * @param data
	 *            byte buffer.
	 * @return the byte parsed.
	 */
	public static byte parseByte(int offset, byte[] data) {
		return (byte) (data[offset] & 0xff);
	}

	/**
	 * Read a char value from the data buffer. The buffer is not affected by this method.
	 * 
	 * @param offset
	 *            index of the char to be parsed
	 * @param data
	 *            byte buffer.
	 * @return the char parsed.
	 */
	public static char parseChar(int offset, byte[] data) {
		return (char) (data[offset] & 0xff);
	}
}
