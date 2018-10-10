import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;


public class UDPReceiver implements Runnable {
	int port=9876;
	
	public static void main(String args[]) {
		UDPReceiver UDP_R = new UDPReceiver();
		Thread t1=new Thread(UDP_R);
		t1.start();
	}
	
	
	public void run() {
		try {
			
			DatagramSocket serverSocket = new DatagramSocket(port);
		      byte[] receiveData = new byte[8];

		      System.out.printf("Listening on udp:%s:%d%n",
		              InetAddress.getLocalHost().getHostAddress(), port);     
		      DatagramPacket receivePacket = new DatagramPacket(receiveData,
		                         receiveData.length);
			 
	
		while(true)
	      {
	            serverSocket.receive(receivePacket);
	            String sentence = new String( receivePacket.getData(), 0,
	                               receivePacket.getLength() );
	            System.out.println("RECEIVED: " + sentence);
	            // now send acknowledgement packet back to sender     
	            InetAddress IPAddress = receivePacket.getAddress();
	            String sendString = "polo";
	            byte[] sendData = sendString.getBytes("UTF-8");
	            DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length,
	                 IPAddress, receivePacket.getPort());
	            serverSocket.send(sendPacket);
	      }
		
		}catch(IOException e) {
			System.out.println(e);
		}
	}
	
	
}