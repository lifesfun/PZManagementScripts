#!/bin/bash

function pzRmZs(){ 

	pzGetNow "pzRmZs" 
	rm  $pzMapPath/zom* &>/dev/null
}
function pzFix(){

	pzGetNow "pzFix" 
	rm $pzMapPath/map_t.bin &>/dev/null
	rm $pzMapPath/map_meta.bin &>/dev/null
}
function pzWatch(){
	local logs=$(find "$pzZPath"/Logs  -type f | tr "\n" " " ) 
	local screens="$files $pzZPath/screenlog.0 $pzZPath/console.txt"
	local old=$(find /var/log/pz/ -type f | tr "\n" " " )
	local mail=/var/mail/pz
	tail -f $logs $mail $screens
}
function pzUpdate(){

	. /home/pz/.steamUser
	/home/pz/steamcmd/steamcmd.sh +login $steamUser $steamPassword +force_install_dir /home/pz/ +app_update 108600 
}
function pzAutoRestart(){ 

	pzGetNow "pzAutoRestart" 

	pzMsg "Its Reboot Time! T-minus 1 minutes..." 
	sleep 1m

	pzMsg "T-minus 30 seconds..." 
	sleep 5s

	pzMsg "You can now join instantly after you get disconnected!" 
	sleep 5s

	pzMsg "T-minus 20 seconds..." 
	sleep 5s 

	pzMsg "You are on ProjectZomboid@RedditGaming.us" 
	sleep 5s 

	pzMsg "T-minus 10 seconds..." 
	sleep 5s

	pzMsg "T-minus 5 seconds..." 
	sleep 5s

	pzRestart
}
