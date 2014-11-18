import java.io.FileWriter;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;

public class SourceEngineQueryDemo {

	private static final byte[] SERVER_REQUEST = { (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0x54, (byte) 0x53, (byte) 0x6F, (byte) 0x75, (byte) 0x72, (byte) 0x63, (byte) 0x65,
			(byte) 0x20, (byte) 0x45, (byte) 0x6E, (byte) 0x67, (byte) 0x69, (byte) 0x6E, (byte) 0x65, (byte) 0x20, (byte) 0x51, (byte) 0x75, (byte) 0x65, (byte) 0x72, (byte) 0x79, (byte) 0x00 };

	private static final String[] ROOT_IP_ADDRESSES = { "172.17.1.", "172.17.2.", "172.17.9.", "172.17.11.", "172.17.12.", "172.17.13.", "172.17.14.", "172.17.15.", "172.17.16.", "172.17.17.",
			"172.17.18.", "172.17.19.", "172.17.20.", "172.17.21.", "172.17.22.", "172.17.23.", "172.17.24.", "172.17.25.", "172.17.26.", "172.17.27.", "172.17.28.", "172.17.29.", "172.17.30.",
			"172.17.31.", "172.17.32.", "172.17.33.", "172.17.34.", "172.17.35.", "172.17.36.", "172.17.37." };

	private static final int PORT = 27015;

	private static String CS_FILE_PATH = "../../tmp/cs_server_list.txt";
	private static String CSGO_FILE_PATH = "../../tmp/csgo_server_list.txt";
	private static String DOTA_FILE_PATH = "../../tmp/dota_server_list.txt";

	private static DatagramSocket[] sockets = new DatagramSocket[255 * ROOT_IP_ADDRESSES.length];

	private static ArrayList<String> excludedIPList = new ArrayList<>();

	public static void main(String[] args) throws IOException, InterruptedException {
		prepareSockets();

		prepareExclusiveIPList();

		byte[] buffer = new byte[255];

		// Create Request Packet
		DatagramPacket requestPacket = new DatagramPacket(buffer, 1); 						// Packet for Sending Request
		requestPacket.setData(SERVER_REQUEST);

		sendRequests(requestPacket, buffer);

		Thread.sleep(20);

		getResponse(buffer);

		closeSockets();
	}

	private static void prepareExclusiveIPList() {
		// EMPTY LIST
	}

	private static void getResponse(byte[] buffer) throws IOException {
		for (int rootAddress = 0; rootAddress < ROOT_IP_ADDRESSES.length; rootAddress++) {
			for (int machineAddress = 0; machineAddress <= 254; machineAddress++) {
				// Create Address
				int socketIndex = (rootAddress * 255) + machineAddress;
				String address = ROOT_IP_ADDRESSES[rootAddress] + machineAddress;

				// Check if IP is in Excluded IP List
				if (excludedIPList.contains(address))
					continue;

				// Request Packet for Receiving Information
				buffer = new byte[255];
				DatagramPacket serverInfoPacket = new DatagramPacket(buffer, 255);

				sockets[socketIndex].setSoTimeout(1);

				// Try receiving packet. If found, Display Server Information.
				try {
					sockets[socketIndex].receive(serverInfoPacket);

					// Determine GameType
					String gameType = SourceEngineServerInfo.getGameType(serverInfoPacket.getData());
					if (gameType.equals("cs")) {
						appendServerInfo(gameType, new CSServerInfo(serverInfoPacket.getData(), address).toString());
					} else if (gameType.equals("csgo")) {
						appendServerInfo(gameType, new CSGOServerInfo(serverInfoPacket.getData(), address).toString());
					} else if (gameType.equals("dota")) {
						appendServerInfo(gameType, new DOTAServerInfo(serverInfoPacket.getData(), address).toString());
					} else {
						// At the moment never gets executed as CSGO determiner always return true.
						System.out.println("\n[WARNING] Unresolved Game Type FOUND at address = " + address + ":27015\n");
					}
				} catch (Exception e) {
					// DO NOTHING.
				}
			}
		}
	}

	private static void sendRequests(DatagramPacket requestPacket, byte[] buffer) {
		for (int rootAddress = 0; rootAddress < ROOT_IP_ADDRESSES.length; rootAddress++) {
			for (int machineAddress = 0; machineAddress <= 254; machineAddress++) {
				// Create Address
				int socketIndex = (rootAddress * 255) + machineAddress;
				String address = ROOT_IP_ADDRESSES[rootAddress] + machineAddress;

				// Check if IP is in Excluded IP List
				if (excludedIPList.contains(address))
					continue;

				buffer = new byte[255];

				// Prepare socket for Broadcast
				try {
					sockets[socketIndex].setBroadcast(true);

					// Prepare Server Request Packet
					requestPacket.setAddress(InetAddress.getByName(address));
					requestPacket.setPort(PORT);

					// Send Request Packet
					sockets[socketIndex].send(requestPacket);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private static void appendServerInfo(String gameType, String appendData) {
		if (gameType.equals("cs")) {
			try {
				FileWriter CS_WRITER = new FileWriter(CS_FILE_PATH, true);
				CS_WRITER.write(appendData);
				CS_WRITER.close();
			} catch (Exception exception) {
				exception.printStackTrace();
			}
		} else if (gameType.equals("csgo")) {
			try {
				FileWriter CSGO_WRITER = new FileWriter(CSGO_FILE_PATH, true);
				CSGO_WRITER.write(appendData);
				CSGO_WRITER.close();
			} catch (Exception exception) {
				exception.printStackTrace();
			}
		} else if (gameType.equals("dota")) {
			try {
				FileWriter DOTA_WRITER = new FileWriter(DOTA_FILE_PATH, true);
				DOTA_WRITER.write(appendData);
				DOTA_WRITER.close();
			} catch (Exception exception) {
				exception.printStackTrace();
			}
		}
	}

	private static void closeSockets() {
		try {
			for (int i = 0; i < sockets.length; i++) {
				sockets[i].close();
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		}

	}

	private static void prepareSockets() {
		try {
			for (int i = 0; i < sockets.length; i++) {
				sockets[i] = new DatagramSocket();
				sockets[i].setBroadcast(true);
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		}
	}
}
