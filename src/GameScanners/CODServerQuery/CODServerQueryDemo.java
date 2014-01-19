import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class CODServerQueryDemo {
    private static final byte[] SERVER_REQUEST = { (byte) 0xff, (byte) 0xff,
	    (byte) 0xff, (byte) 0xff, (byte) 0x67, (byte) 0x65, (byte) 0x74,
	    (byte) 0x73, (byte) 0x74, (byte) 0x61, (byte) 0x74, (byte) 0x75,
	    (byte) 0x73, (byte) 0x00 };

    private static final String[] ROOT_IP_ADDRESSES = { "172.16.1.",
	    "172.16.2.", "172.16.3.", "172.16.4.", "172.16.5.", "172.16.6.",
	    "172.16.7.", "172.16.8.", "172.16.9.", "172.16.10.", "172.16.13.",
	    "172.16.14.", "172.16.15.", "172.16.16.", "172.16.17.",
	    "172.16.18.", "172.16.19.", "172.16.20.", "172.17.1.", "172.17.2.",
	    "172.17.7.", "172.17.9." };

    private static final int PORT = 28960;

    private static DatagramSocket[] sockets = new DatagramSocket[255 * ROOT_IP_ADDRESSES.length];

    public static void main(String[] args) throws IOException,
	    InterruptedException {
	// System.out.println("Preparing Sockets.");
	prepareSockets();
	// System.out.println("Sockets Prepared.");

	byte[] buffer = new byte[1000];

	// Create Request Packet
	// System.out.println("Creating Request Packet.");
	DatagramPacket requestPacket = new DatagramPacket(buffer, 1); // Packet
								      // for
								      // Sending
								      // Request
	requestPacket.setData(SERVER_REQUEST);
	// System.out.println("Request Packet Created.");

	// System.out.println("Sending Requests.");
	sendRequests(requestPacket, buffer);
	System.out.println("All Requests Sent.");

	// System.out.println("Sleeping for 20ms.");
	Thread.sleep(20);

	// System.out.println("Getting Responses.");
	getResponse(buffer);
	// System.out.println("Responses Recorded.");

	// System.out.println("Closing Sockets.");
	closeSockets();
	// System.out.println("Sockets Closed.");
    }

    private static void getResponse(byte[] buffer) throws IOException {
	for (int rootAddress = 0; rootAddress < ROOT_IP_ADDRESSES.length; rootAddress++) {
	    System.out.println("Scanning Root Address : "
		    + ROOT_IP_ADDRESSES[rootAddress]);
	    for (int machineAddress = 0; machineAddress <= 254; machineAddress++) {
		int socketIndex = (rootAddress * 255) + machineAddress;
		// Try receiving packet. If found, Display Server Information.
		String address = ROOT_IP_ADDRESSES[rootAddress]
			+ machineAddress;
		System.out.println("Scanning : " + address + ":" + PORT
			+ " using Socket : " + socketIndex);

		buffer = new byte[1000];
		// Request
		DatagramPacket serverInfoPacket = new DatagramPacket(buffer,
			1000); // Packet for
			       // Receiving
		// Information

		sockets[socketIndex].setSoTimeout(1);

		try {
		    sockets[socketIndex].receive(serverInfoPacket);

		    System.out.print(new CODServerInfo(serverInfoPacket
			    .getData(), address).toString());
		} catch (Exception e) {
		    // DO NOTHING.
		}
	    }
	}
    }

    private static void sendRequests(DatagramPacket requestPacket, byte[] buffer) {
	for (int rootAddress = 0; rootAddress < ROOT_IP_ADDRESSES.length; rootAddress++) {
	    System.out.println("Scanning Root Address : "
		    + ROOT_IP_ADDRESSES[rootAddress]);
	    for (int machineAddress = 0; machineAddress <= 254; machineAddress++) {
		int socketIndex = (rootAddress * 255) + machineAddress;

		String address = ROOT_IP_ADDRESSES[rootAddress]
			+ machineAddress;

		// System.out.println("Scanning : " + address + ":" + PORT +
		// " using Socket : " + socketIndex);

		buffer = new byte[1000];
		// Request
		// Prepare socket for Broadcast
		try {
		    sockets[socketIndex].setBroadcast(true);

		    // Prepare Server Request Packet
		    requestPacket.setAddress(InetAddress.getByName(address));
		    requestPacket.setPort(PORT);

		    // Send Request Packet
		    sockets[socketIndex].send(requestPacket);

		    // Set Data Receive Timeout
		    // sockets[socketIndex].setSoTimeout(50);
		} catch (Exception e) {
		    e.printStackTrace();
		    return;
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

	// System.out.println("All sockets closed.");
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

	// System.out.println("All sockets prepared.");
    }
}
