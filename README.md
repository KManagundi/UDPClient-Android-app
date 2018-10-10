# UDPClient-Android-app

In ---->>> UnitTest(2)

IPADDRESS Text box -> Text editor to enter the IPADDRESS
PORT text box      -> Text editor to enter the Port 

OnClick Start button -> Start packet is sent to the server
Onclick Stop button -> Stop packet is sent to the server
Onclick close button -> close packet is sent to the server

---------------------------------------------------------------
A UDP server on matlab that opens a serial port and starts reading from serial port on reception of start packets and continues to read untill a Stop packet is received. When a 'STOP' packet is received it closes the serial port but the UDP socekt is still open for the next start untill the CLOSE button is clicked. On reception of 'STOP' packet the UDP socket and also closed.

---------------------------------------------------------------
A UDP Server/Receiver implemented in Java Threads. 
