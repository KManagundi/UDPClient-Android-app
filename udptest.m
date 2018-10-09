%Close the socket if already inuse
instrreset
clear
clc

%close the serial ports in already open

if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

cnt = 0;
flag=0;
start_flag=1;

% Initializations for UDP

UDPComIn=udp('192.168.43.6','LocalPort',9876,'TimeOut', 1/20);
set(UDPComIn,'DatagramTerminateMode','on');
fopen(UDPComIn);


%preparing to read data
mData=zeros(1,768);
%mPktCnt = zeros(1,65000);

%start UDP communication
while(start_flag)
   
    data=fscanf(UDPComIn);
    if(strcmpi(data,'stop'))
        
         fprintf('Stopped Serial read \n');
          fprintf('Total number of frames read are %d\n',cnt);
        start_flag=1;
        cnt = 0;
        flag=0;
        fclose(fileID);
        %Closing Serial Port
        fclose(s1);
        delete(s1);
    elseif(strcmpi(data,'start'))
        tic;
        filename='C:\Users\kmana\Desktop\Matlab\MLX_Read.csv';
        cnt = cnt+1;
        flag=1;
        % Initializations for Serialport
        s1 = serial('COM8');    %define serial port to read the Arduino
        s1.BaudRate=256000;     %define baud rate
        s1.InputBufferSize=2^21; % increase the buffer size 2^29 is the maximum accepted
        s1.Terminator = 'CR';
        s1.ReadAsyncMode = 'continuous';
        fopen(s1);
        fileID = fopen(filename,'w');
        
        fprintf('Started Serial read \n');
        
        sSerialData = fscanf(s1); %read sensor
        t = strsplit(sSerialData,','); % same character as the Arduino code
        for j=1:768
            mData(j) = str2double(t(j));
            fprintf(fileID, '%2.2f,', mData(j));
        end
        %mData();
        fprintf(fileID, '\n');
    elseif(flag==1)
        cnt = cnt+1;
        flag=1;
        start_flag=1;
        fprintf('Continuing to read\n');
        sSerialData = fscanf(s1); %read sensor
        t = strsplit(sSerialData,','); % same character as the Arduino code
        for j=1:768
            mData(j) = str2double(t(j));
            fprintf(fileID, '%2.2f,', mData(j));
        end
        %mData();
        fprintf(fileID, '\n');
        
        
    elseif(strcmpi(data,'close'))
        if(flag==1)
            fclose(s1);
            delete(s1);
            fprintf('Closing Serial port first\n');
        end
        flag=0;
        start_flag=0;
        %Closing UDP communication
        fclose(UDPComIn);
        %Deleting UDP communication
        delete(UDPComIn)
        delete(instrfindall);    % close the serial port
        fprintf('Ending UDP Communication\n');
        
    end
end
%CodeEnd-