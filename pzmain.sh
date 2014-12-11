#!/bin/bash

################# Utility Functions and Variables #####################
function pzGetNow(){ 

    pzNow=$(date +%y.%m.%dT%H.%M ) 
    if [ "$#" -eq '1' ] ; then

        echo "Time: $pzNow"
        echo "Command: $1"
    fi
}
function pzCheckStarted(){	

    pzGetNow "pzCheckStarted: Hmm lets see..."
	pzPid=$(ps aux | grep "SCREEN -dm" | grep -v "grep" |  tr -s " " |cut -d " " -f2 | head -n1 ) 

	[ -z "$pzPid" ] && pzGetNow "pzCheckStarted: nothing here boss." &&  return 1 

    pzGetNow "pzCheckStarted: The server is up and running at '$pzPid' boss :) " &&  return 0
}
function pzScreenCmd(){

	pzGetNow "pzScreenCmd $1" 
	pzCheckStarted ||  return 
	screen -S "$pzPid" -p 0 -X stuff "$1" 
}
function pzCmd(){ 

	local exp="$1\015"
	pzScreenCmd "$exp"
}
function pzMsg(){

	pzCmd "servermsg $1" 
}
