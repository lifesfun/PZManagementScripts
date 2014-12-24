#!/bin/bash 

################## Server Core Commands #########################

function pzStart(){ 

	pzGetNow "pzStart: Starting..." 
	pzCheckStarted  && return 0  

	mv $pzMpPath/map* $pzMapPath &>/dev/null 
	mv $pzZPath/screenlog.0 /var/log/pz/"$pzNow"_screenlog.0
	touch $pzZPath/screenlog.0
	mv $pzZPath/console.txt  /var/log/pz/"$pzNow"_console.txt
	touch $pzZPath/console.txt
	find $pzZPath/Logs -type f -exec mv {} /var/log/pz/ \; &>/dev/null 

	screen -dm -L $pzPath/projectzomboid-dedi-server.sh  
	if pzCheckStarted ; then  
		pzGetNow "pzStart: Started"  
		pzGetNow "pzStart: Server was started from a stopped state." >/var/mail/pz   
		sleep 120s 
		pzMsg "The server has been rebooted. Welcome Back!"
	else
		pzBot
	fi
}
function pzStop(){ 

	pzGetNow "pzStop: Lets stop this baddie." 
	pzCmd save 
	pzRmZs
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
	pzStart
}
