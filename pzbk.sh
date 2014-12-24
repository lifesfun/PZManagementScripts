#!/bin/bash
##### Backup Functions #####

function pzBkConf(){
    pzBkPath="/var/backups/pzbackup"
    [ -d "$pzBkPath" ] || mkdir "$pzBkPath" 
    pzAzPath="$pzBkPath"/archive 
    [ -d "$pzAzPath" ] || mkdir "$pzAzPath" 
}
function pzBk(){
	pzBkConf
	pzGetNow "pzBackup: Saving the past..." 
	local bkName="$pzNow"_bk.tar
	pzCmd save
	cd "$pzAzPath" 
	tar -C "$pzAzPath" -cpf "$bkName" "$pzMpPath" "$pzZPath"/Server "$pzZPath"/db 
}
function pzAz(){
    pzBkConf
    local day=$(date +%y.%m.%d )
    local archive="$pzAzPath"/"$day"_pzAz.tar
    local latest="$(find $pzAzPath -type f -name "$day*_bk.tar" | tail -1 )" || exit
    mv "$latest" "$archive" &&  rm -rf "$day"*T*
	if [ -f "$archive" ] ; then 
		[ -f "$archive"'.gz' ] && rm "$archive"'.gz'  
		gzip "$archive" 
	fi
}
