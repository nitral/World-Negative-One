import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SourceEngineQueryDemo {

    private static final byte[] SERVER_REQUEST = { (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0x54, (byte) 0x53, (byte) 0x6F, (byte) 0x75, (byte) 0x72, (byte) 0x63, (byte) 0x65,
	    (byte) 0x20, (byte) 0x45, (byte) 0x6E, (byte) 0x67, (byte) 0x69, (byte) 0x6E, (byte) 0x65, (byte) 0x20, (byte) 0x51, (byte) 0x75, (byte) 0x65, (byte) 0x72, (byte) 0x79, (byte) 0x00 };

    private static List<String> rootIPAddresses = new ArrayList<>();

    private static final int PORT = 27015;

    private static final String CONFIG_FILE_PATH = "./config.cfg";
    private static final String ROOT_IP_FILE_PATH = "./ip_list.cfg";
    private static final String CS_FILE_PATH = "../../tmp/cs_server_list.txt";
    private static final String CSGO_FILE_PATH = "../../tmp/csgo_server_list.txt";
    private static final String DOTA_FILE_PATH = "../../tmp/dota_server_list.txt";
    private static final String BANNED_IP_FILE_PATH = "./banned.cfg";
    
    private static final String HUB_CS_FILE_PATH = "../../system/scripts/cs_files/cs.txt";
    private static final String HUB_CSGO_FILE_PATH = "../../system/scripts/csgo_files/csgo.txt";
    private static final String HUB_DOTA_FILE_PATH = "../../system/scripts/dota_files/dota.txt";

    private static DatagramSocket[] sockets;

    private static ArrayList<String> bannedIPList = new ArrayList<>();

    public static void main(String[] args) throws IOException, InterruptedException {
	init();
	int numberOfSockets = sockets.length;
	byte[] buffer = new byte[255];

	// Create Request Packet
	DatagramPacket requestPacket = new DatagramPacket(buffer, 1); // Packet
								      // for
								      // Sending
								      // Request
	requestPacket.setData(SERVER_REQUEST);

	List<String> addressesToRead = new ArrayList<>();
	int iteration = 1;
	while (true) {
	    int socketToUse = 0;
	    for (int rootAddress = 0; rootAddress < rootIPAddresses.size(); rootAddress++) {
		System.out.println("[" + iteration + "] Exploring Root Path: " + rootIPAddresses.get(rootAddress));
		for (int machineAddress = 0; machineAddress <= 254; machineAddress++) {
		    sendRequest(rootAddress, machineAddress, socketToUse, requestPacket, buffer);
		    addressesToRead.add(rootIPAddresses.get(rootAddress) + "." + machineAddress);
		    socketToUse = (socketToUse + 1) % numberOfSockets;
		    if (socketToUse == 0) {
			Thread.sleep(150);
			for (int socketIndex = 0; socketIndex < numberOfSockets; socketIndex++) {
			    getResponse(addressesToRead.get(socketIndex), socketIndex, buffer);
			}
			addressesToRead.clear();
		    }
		}
	    }
	    iteration++;
	    // Dump and Clean Temporary Server List Files
	    try {
		writeFilesToHub();
		cleanFiles();
	    } catch(Exception e) {
		e.printStackTrace();
	    }
	}
    }

    private static void writeFilesToHub() throws IOException {
	writeCSHubFile();
	writeCSGOHubFile();
	writeDOTAHubFile();
    }

    private static void writeCSHubFile() throws IOException {
	FileWriter fw = new FileWriter(new File(HUB_CS_FILE_PATH), false);
	fw.write("");
	fw.close();
	fw = new FileWriter(new File(HUB_CS_FILE_PATH), true);
	fw.append("				             COUNTER STRIKE 1.6 SERVERS' LIST\n");
	fw.append("                                                                         Last Updated at - " + new Date().toString() + "\n");
	fw.append("\n");
	fw.append("Server Name               l                IP                l   Players(Bots)/Max   l            Map            l       Password       l\n");
	fw.append("-----------------------------------------------------------------------------------------------------------------------------------------------------------------\n");
	BufferedReader bufferedReader = new BufferedReader(new FileReader(new File(CS_FILE_PATH)));
	String in;
	while((in = bufferedReader.readLine()) != null) {
	    fw.append(in + "\n");
	}
	fw.close();
	bufferedReader.close();
    }
    
    private static void writeCSGOHubFile() throws IOException {
	FileWriter fw = new FileWriter(new File(HUB_CSGO_FILE_PATH), false);
	fw.write("");
	fw.close();
	fw = new FileWriter(new File(HUB_CSGO_FILE_PATH), true);
	fw.append("		        COUNTER STRIKE : Global Offensive SERVERS' LIST\n");
	fw.append("                                                      Last Updated at - " + new Date().toString() + "\n");
	fw.append("\n");
	fw.append("Server Name               l                IP                l           Map            l\n");
	fw.append("---------------------------------------------------------------------------------------------------\n");
	BufferedReader bufferedReader = new BufferedReader(new FileReader(new File(CSGO_FILE_PATH)));
	String in;
	while((in = bufferedReader.readLine()) != null) {
	    fw.append(in + "\n");
	}
	fw.close();
	bufferedReader.close();
    }
    
    private static void writeDOTAHubFile() throws IOException {
	FileWriter fw = new FileWriter(new File(HUB_DOTA_FILE_PATH), false);
	fw.write("");
	fw.close();
	fw = new FileWriter(new File(HUB_DOTA_FILE_PATH), true);
	fw.append("		                                   DOTA SERVERS' LIST\n");
	fw.append("                                                           Last Updated at - " + new Date().toString() + "\n");
	fw.append("\n");
	fw.append("Server Name               l                IP                l\n");
	fw.append("----------------------------------------------------------------------\n");
	BufferedReader bufferedReader = new BufferedReader(new FileReader(new File(DOTA_FILE_PATH)));
	String in;
	while((in = bufferedReader.readLine()) != null) {
	    fw.append(in + "\n");
	}
	fw.close();
	bufferedReader.close();
    }

    private static void cleanFiles() throws IOException {
	FileWriter fw = new FileWriter(new File(CS_FILE_PATH), false);
	fw.write("");
	fw.close();
	fw = new FileWriter(new File(CSGO_FILE_PATH), false);
	fw.write("");
	fw.close();
	fw = new FileWriter(new File(DOTA_FILE_PATH), false);
	fw.write("");
	fw.close();
    }

    private static void init() throws IOException {
	BufferedReader bufferedReader = new BufferedReader(new FileReader(new File(CONFIG_FILE_PATH)));
	Integer numberOfSockets = Integer.parseInt(bufferedReader.readLine());
	readRootIPAddresses();
	prepareSockets(numberOfSockets);
	prepareBannedIPList();
	Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
	    public void run() {
		closeSockets();
	    }
	}));
	bufferedReader.close();
    }

    private static void readRootIPAddresses() throws IOException {
	BufferedReader bufferedReader = new BufferedReader(new FileReader(new File(ROOT_IP_FILE_PATH)));
	String ip;
	while ((ip = bufferedReader.readLine()) != null) {
	    rootIPAddresses.add(ip);
	}
	bufferedReader.close();

    }

    private static void prepareBannedIPList() throws IOException {
	BufferedReader bufferedReader = new BufferedReader(new FileReader(new File(BANNED_IP_FILE_PATH)));
	String ip;
	while ((ip = bufferedReader.readLine()) != null) {
	    bannedIPList.add(ip);
	}
	bufferedReader.close();
    }

    private static void getResponse(String address, int socketIndex, byte[] buffer) throws SocketException {
	// Check if IP is in Excluded IP List
	if (bannedIPList.contains(address))
	    return;

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
		String out = new CSServerInfo(serverInfoPacket.getData(), address).toString();
		System.out.println(out);
		appendServerInfo(gameType, out);
	    } else if (gameType.equals("csgo")) {
		String out = new CSGOServerInfo(serverInfoPacket.getData(), address).toString();
		System.out.println(out);
		appendServerInfo(gameType, out);
	    } else if (gameType.equals("dota")) {
		String out = new DOTAServerInfo(serverInfoPacket.getData(), address).toString();
		System.out.println(out);
		appendServerInfo(gameType, out);
	    } else {
		// At the moment never gets executed as CSGO determiner
		// always return true.
		System.out.println("\n[WARNING] Unresolved Game Type FOUND at address = " + address + ":27015\n");
	    }
	} catch (Exception e) {
	    // DO NOTHING.
	}
    }

    private static void sendRequest(int rootAddress, int machineAddress, int socketIndex, DatagramPacket requestPacket, byte[] buffer) {
	// Create Address
	String address = rootIPAddresses.get(rootAddress) + "." + machineAddress;

	// Check if IP is in Excluded IP List
	if (bannedIPList.contains(address))
	    return;

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
	System.out.println("Closing Sockets.");
	try {
	    for (int i = 0; i < sockets.length; i++) {
		sockets[i].close();
	    }
	} catch (Exception exception) {
	    exception.printStackTrace();
	}

    }

    private static void prepareSockets(int numberOfSockets) {
	System.out.print("Preparing sockets with Local Ports: ");
	sockets = new DatagramSocket[numberOfSockets];
	try {
	    for (int i = 0; i < sockets.length; i++) {
		sockets[i] = new DatagramSocket();
		sockets[i].setBroadcast(true);
		if (i < sockets.length - 1) {
		    System.out.print(sockets[i].getLocalPort() + ", ");
		}
	    }
	    System.out.println(sockets[sockets.length - 1].getLocalPort());
	} catch (Exception exception) {
	    exception.printStackTrace();
	}
    }
}
