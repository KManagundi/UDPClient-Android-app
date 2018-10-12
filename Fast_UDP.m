instrreset
clear
clc

setGlobalflag(0);
startflag=1;
UDPComIn=udp('192.168.1.103','LocalPort',6666,'Timeout',0.1);
set(UDPComIn,'DatagramTerminateMode','on');
fopen(UDPComIn)


while(startflag)
UDPComIn.DatagramReceivedFcn = @callbackFcn; % the callbackFcn will be called whenever a UDP packet is received
if(getGlobalflag==1)
       fprintf('Continue Serial read \n');
       flag=1;
   end
end


function callbackFcn(src,evt) % here the src is actually the udp object itself
   msg=fscanf(src)
   if(strcmpi(msg,'start'))
       setGlobalflag(1);
      fprintf('Started Serial Read \n');
       
   elseif(strcmpi(msg,'stop'))
        fprintf('Stopped Serial read \n');
        setGlobalflag(0);
   elseif(strcmpi(msg,'close'))
        fprintf('Closed UDP port \n');
      setGlobalflag(0);
   end
end

function setGlobalflag(val)
global flag
flag = val;
end

function r = getGlobalflag
global flag
r = flag;
end