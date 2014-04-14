import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class CODServerQueryDemo {

	private static final byte[] SERVER_REQUEST = { (byte) 0xff, (byte) 0xff, (byte) 0xff, (byte) 0xff, (byte) 0x67, (byte) 0x65, (byte) 0x74, (byte) 0x73, (byte) 0x74, (byte) 0x61, (byte) 0x74,
			(byte) 0x75, (byte) 0x73, (byte) 0x00 };

	private static final String[] ROOT_IP_ADDRESSES = { "172.17.1.", "172.17.2.", "172.17.9.", "172.17.11.", "172.17.12.", "172.17.13.", "172.17.14.", "172.17.15.", "172.17.16.", "172.17.17.",
			"172.17.18.", "172.17.19.", "172.17.20.", "172.17.21.", "172.17.22.", "172.17.23.", "172.17.24.", "172.17.25.", "172.17.26.", "172.17.27.", "172.17.28.", "172.17.29.", "172.17.30.",
			"172.17.31.", "172.17.32.", "172.17.33.", "172.17.34.", "172.17.35.", "172.17.36.", "172.17.37." };

	private static final int PORT = 28960;

	private static DatagramSocket[] sockets = new DatagramSocket[255 * ROOT_IP_ADDRESSES.length];

	public static void main(String[] args) throws IOException, InterruptedException {
		prepareSockets();

		byte[] buffer = new byte[1000];

		// Create Request Packet
		DatagramPacket requestPacket = new DatagramPacket(buffer, 1); 						// Packet for Sending Request
		requestPacket.setData(SERVER_REQUEST);

		sendRequests(requestPacket, buffer);

		Thread.sleep(20);

		getResponse(buffer);

		closeSockets();
	}

	private static void getResponse(byte[] buffer) throws IOException {
		for (int rootAddress = 0; rootAddress < ROOT_IP_ADDRESSES.length; rootAddress++) {
			for (int machineAddress = 0; machineAddress <= 254; machineAddress++) {
				// Create Address
				int socketIndex = (rootAddress * 255) + machineAddress;
				String address = ROOT_IP_ADDRESSES[rootAddress] + machineAddress;

				// Request Packet for Receiving Information
				buffer = new byte[1000];
				DatagramPacket serverInfoPacket = new DatagramPacket(buffer, 1000);

				sockets[socketIndex].setSoTimeout(1);

				// Try receiving packet. If found, Display Server Information.
				try {
					sockets[socketIndex].receive(serverInfoPacket);
					System.out.print(new CODServerInfo(serverInfoPacket.getData(), address).toString());
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

				buffer = new byte[1000];

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
