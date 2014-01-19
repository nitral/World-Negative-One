import java.io.FileWriter;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;

public class SourceEngineQueryDemo
{
	private static final byte[] SERVER_REQUEST = { (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0x54,
			(byte) 0x53, (byte) 0x6F, (byte) 0x75, (byte) 0x72, (byte) 0x63, (byte) 0x65, (byte) 0x20,
			(byte) 0x45, (byte) 0x6E, (byte) 0x67, (byte) 0x69, (byte) 0x6E, (byte) 0x65, (byte) 0x20,
			(byte) 0x51, (byte) 0x75, (byte) 0x65, (byte) 0x72, (byte) 0x79, (byte) 0x00 };

	private static final String[] ROOT_IP_ADDRESSES = { "172.16.1.", "172.16.2.", "172.16.3.", "172.16.4.",
			"172.16.5.", "172.16.6.", "172.16.7.", "172.16.8.", "172.16.9.", "172.16.10.", "172.16.13.",
			"172.16.14.", "172.16.15.", "172.16.16.", "172.16.17.", "172.16.18.", "172.16.19.",
			"172.16.20.", "172.17.1.", "172.17.2.", "172.17.7.", "172.17.9." };

	private static final int PORT = 27015;

	private static String CS_FILE_PATH = "..\\..\\tmp\\cs_server_list.txt";
	private static String CSGO_FILE_PATH = "..\\..\\tmp\\csgo_server_list.txt";
	private static String DOTA_FILE_PATH = "..\\..\\tmp\\dota_server_list.txt";

	private static DatagramSocket[] sockets = new DatagramSocket[255 * ROOT_IP_ADDRESSES.length];
	
	private static ArrayList<String> excludedIPList = new ArrayList<>();

	public static void main(String[] args) throws IOException, InterruptedException
	{
		// System.out.println("Preparing Sockets.");
		prepareSockets();
		// System.out.println("Sockets Prepared.");

		prepareExclusiveIPList();
		
		byte[] buffer = new byte[255];

		// System.out.println("Creating Request Packet.");
		// Create Request Packet
		DatagramPacket requestPacket = new DatagramPacket(buffer, 1);		// Packet for Sending Request
		requestPacket.setData(SERVER_REQUEST);
		// System.out.println("Request Packet Created.");

		// System.out.println("Sending Requests.");
		sendRequests(requestPacket, buffer);
		// System.out.println("All Requests Sent.");

		// System.out.println("Sleeping for 20ms.");
		Thread.sleep(20);

		// System.out.println("Getting Responses.");
		getResponse(buffer);
		// System.out.println("Responses Recorded.");

		// System.out.println("Closing Sockets.");
		closeSockets();
		// System.out.println("Sockets Closed.");
	}

	private static void prepareExclusiveIPList()
	{
		excludedIPList.add("172.16.14.42");
	}

	private static void getResponse(byte[] buffer) throws IOException
	{
		for(int rootAddress = 0 ; rootAddress < ROOT_IP_ADDRESSES.length ; rootAddress++)
		{
			// System.out.println("Scanning Root Address : " + ROOT_IP_ADDRESSES[rootAddress]);

			for(int machineAddress = 0 ; machineAddress <= 254 ; machineAddress++)
			{
				int socketIndex = (rootAddress * 255) + machineAddress;
				// Try receiving packet. If found, Display Server Information.
				String address = ROOT_IP_ADDRESSES[rootAddress] + machineAddress;

				// System.out.println("Scanning : " + address + ":" + PORT + " using Socket : " +
				// socketIndex);
				
				// Check if IP is in Excluded IP List
				if(excludedIPList.contains(address))
					continue;
				
				buffer = new byte[255];
				// Request
				DatagramPacket serverInfoPacket = new DatagramPacket(buffer, 255);	// Packet for
													// Receiving
				// Information
				sockets[socketIndex].setSoTimeout(1);

				try
				{
					sockets[socketIndex].receive(serverInfoPacket);

					// Determine GameType
					String gameType = SourceEngineServerInfo
							.getGameType(serverInfoPacket.getData());

					if(gameType.equals("cs"))
					{
						System.out.println(gameType);
						// appendServerInfo(gameType, new
						// CSServerInfo(serverInfoPacket.getData(), address).toString());
						System.out.print(new CSServerInfo(serverInfoPacket.getData(), address)
								.toString());
					}
					else if(gameType.equals("csgo"))
					{
						System.out.println(gameType);
						// appendServerInfo(gameType, new
						// CSGOServerInfo(serverInfoPacket.getData(), address).toString());
						System.out.print(new CSGOServerInfo(serverInfoPacket.getData(), address)
								.toString());
					}
					else if(gameType.equals("dota"))
					{
						System.out.println(gameType);
						// appendServerInfo(gameType, new
						// DOTAServerInfo(serverInfoPacket.getData(), address).toString());
						System.out.print(new DOTAServerInfo(serverInfoPacket.getData(), address)
								.toString());
					}
					else
						System.out.println("\n[WARNING] Unresolved Game Type FOUND at address = "
								+ address + ":27015\n");				// At the moment never gets
												// executed as CSGO
												// determiner always
												// return true.
				}
				catch(Exception e)
				{
					// DO NOTHING.
				}
			}
		}
	}

	private static void sendRequests(DatagramPacket requestPacket, byte[] buffer)
	{
		for(int rootAddress = 0 ; rootAddress < ROOT_IP_ADDRESSES.length ; rootAddress++)
		{
			// System.out.println("Scanning Root Address : " + ROOT_IP_ADDRESSES[rootAddress]);

			for(int machineAddress = 0 ; machineAddress <= 254 ; machineAddress++)
			{
				int socketIndex = (rootAddress * 255) + machineAddress;

				String address = ROOT_IP_ADDRESSES[rootAddress] + machineAddress;

				// System.out.println("Scanning : " + address + ":" + PORT + " using Socket : " +
				// socketIndex);
				
				// Check if IP is in Excluded IP List
				if(excludedIPList.contains(address))
					continue;
				
				buffer = new byte[255];

				// Request
				// Prepare socket for Broadcast
				try
				{
					sockets[socketIndex].setBroadcast(true);

					// Prepare Server Request Packet
					requestPacket.setAddress(InetAddress.getByName(address));
					requestPacket.setPort(PORT);

					// Send Request Packet
					sockets[socketIndex].send(requestPacket);

					// Set Data Receive Timeout
					// sockets[socketIndex].setSoTimeout(50);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		}
	}

	private static void appendServerInfo(String gameType, String appendData)
	{
		if(gameType.equals("cs"))
		{
			try
			{
				FileWriter CS_WRITER = new FileWriter(CS_FILE_PATH, true);
				CS_WRITER.write(appendData);
				CS_WRITER.close();
			}
			catch(Exception exception)
			{
				exception.printStackTrace();
			}
		}
		else if(gameType.equals("csgo"))
		{
			try
			{
				FileWriter CSGO_WRITER = new FileWriter(CSGO_FILE_PATH, true);
				CSGO_WRITER.write(appendData);
				CSGO_WRITER.close();
			}
			catch(Exception exception)
			{
				exception.printStackTrace();
			}
		}
		else if(gameType.equals("dota"))
		{
			try
			{
				FileWriter DOTA_WRITER = new FileWriter(DOTA_FILE_PATH, true);
				DOTA_WRITER.write(appendData);
				DOTA_WRITER.close();
			}
			catch(Exception exception)
			{
				exception.printStackTrace();
			}
		}
	}

	private static void closeSockets()
	{
		try
		{
			for(int i = 0 ; i < sockets.length ; i++)
			{
				sockets[i].close();
			}
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
		}

	}

	private static void prepareSockets()
	{
		try
		{
			for(int i = 0 ; i < sockets.length ; i++)
			{
				sockets[i] = new DatagramSocket();
				sockets[i].setBroadcast(true);
			}
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
		}
	}
}
