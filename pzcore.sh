#!/bin/bash 

################## Server Core Commands #########################

function pzStart(){ 

	pzGetNow "pzStart: Starting..." 
	pzCheckStarted  && return 0  

	mv $pzMpPath/map* $pzMapPath &>/dev/null 
	mv $pzZPath/screenlog.0 /var/log/pz/$pzNow_screenlog.0
	touch $pzZPath/screenlog.0
	mv $pzZPath/console.txt  /var/log/pz/$pzNow_console.txt
	touch $pzZPath/console.txt
	find $pzZPath/Logs -type f -exec mv {} /var/log/pz/ \; &>/dev/null 

	screen -dm -L $pzPath/projectzomboid-dedi-server.sh  
	pzCheckStarted && sleep 60s && pzMsg "The server has been rebooted. Welcome Back!"
}
function pzStop(){ 

	pzGetNow "pzStop: Lets stop this baddie." 
	pzCmd save 
	i=0
	while pzCheckStarted  ; do    
		pzGetNow "pzStop: Pew->Pew-> >'$pzPid'"
		kill "$pzPid" 
		i=$(( i + 1 ))
	done
	pzGetNow "pzStop: Killed '$i' processes."
}
function pzRestart(){ 
	
	pzGetNow "pzRestart" 
	pzStop
	pzRmZs
	pzStart
}
