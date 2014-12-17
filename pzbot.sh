#!/bin/bash

function pzCheckErrors(){  
	    pzGetNow "pzCheckErrors: Derp.. Derp.. Checking for errors"
	errors="java.nio.BufferOverflowException java.nio.BufferUnderflowException java.lang.NullPointerException"
	for error in $errors ; do
		if grep "$error" "$pzZPath/screenlog.0"  ; then 
		    pzGetNow "pzCheckErrors: Errors detected."
		    echo "$error"
			return 0
		fi	
	done
    return 1
}
function pzBot(){

	sleep 1
	pzGetNow "pzBot: I am here to help!" 
	if pzCheckErrors ; then 

		pzGetNow "pzCheck: Errors detected. Attempting to fix.."
		pzStop
		pzFix
		pzStart
	elif ! pzCheckStarted  ; then 

		pzGetNow "pzCheck: Server is off. Attempting to start..."
		pzStart
	else 
		pzGetNow "pzBot: All Done. The server is started!" 
	fi	
}

