#!/bin/bash
##### Backup Functions #####

function pzBkConf(){
    [ -d "$pzBkPath" ] || mkdir "$pzBkPath" 
    pzAzPath="$pzBkPath"/archive 
    [ -d "$pzAzPath" ] || mkdir "$pzAzPath" 
}
function pzBk(){
    pzBkConf
	pzGetNow "pzBackup: Saving the past..." 
	local bkName="$pzNow"_bk.tar
	pzCmd save
    ionice -c3 tar -C "$pzAzPath" -cf "$bkName" "$pzMpPath" "$pzZPath"/Server "$pzZPath"/db 
}
function pzAz(){
    pzBkConf
    local day=$(date +%y.%m.%d )
    local archive="$pzAzPath"/"$day"_pzAz.tar
    local latest="$(find $pzAzPath -type f -name "$day*_bk.tar" | tail -1 )" || exit
    mv "$latest" "$archive" &&  rm -rf "$day"T*
    gzip "$archive" 
    #sftp "$bk_srv" -C put "$archive"  
}
