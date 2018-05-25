type LANType 
	netID as integer //ID of network 
	netName as string //Name of network 
	port as integer //Port used 
	clientID as integer //ID of this client 
	clientName as string //Name of client 
	joined as integer //1: joined network 
	minClients as integer //Min. clients in network 
	maxClients as integer //Max. clients in network
endtype

//*** Sets the initial values for network data ***
function SetNetworkData(name as string, prt as integer, min as integer, max as integer) 
	result as LANType 
	result.netID = 0
	result.netName = name
	result.port = prt 
	result.clientID = 0 
	result.clientName = ""
	result.joined = 0 
	result.minClients = min 
	result.maxClients = max
endfunction result

//*** Returns 1 if executed on host machine; 0 if on client *** 
function IsNetworkHost(netid as integer) 
	if GetNetworkServerID(netid) = GetNetworkMyClientID(netid) 
		result = 1 
	else 
		result = 0 
	endif
endfunction result

//*** Creates network host and adds clients ***
function SetUpNetwork(LAN ref as LANType, butimg as string) 
	buttons as integer[2]
	hosted as integer
	listenerID as integer
	
	//*** Show Host and Client buttons *** 
	buttons[1] = CreateGUIButton(10,50,10,5,butimg,"Host") 
	buttons[2] = CreateGUIButton(21,50,10,5,butimg,"Client") 
	listenerID = CreateBroadcastListener(45631)
	repeat 
		if GetBroadcastMessage(listenerID) and hosted = 0
			hosted = 1
			DeleteGUIButton(buttons[1])
			DeleteBroadcastListener(listenerID)
		endif
			
		//*** If Host button pressed *** 
		if HandleGUIButton(buttons[1]) and LAN.joined = 0 
			//*** Host network *** 
			LAN.clientName = Str(GetMilliseconds()) 
			LAN.netID = HostNetwork(LAN.netName,LAN.clientName, LAN.port) 
			//*** Mark as joined *** 
			LAN.joined = 1 
			//*** If Client button pressed *** 
		elseif HandleGUIButton(buttons[2]) and LAN.joined = 0 
			//*** Join network *** 
			LAN.clientName = Str(GetMilliseconds()) 
			LAN.netID = JoinNetwork(LAN.netName,LAN.clientName) 
			//*** Mark as joined *** 
			LAN.joined = 1 
		endif 
		Sync() 
	until LAN.joined 
	//*** Delete Host and Client buttons *** 
	DeleteGUIButton(buttons[1]) 
	DeleteGUIButton(buttons[2])
endfunction
