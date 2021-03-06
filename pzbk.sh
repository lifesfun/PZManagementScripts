#!/bin/bash
##### Backup Functions #####

function pzBkConf(){
	pzBkPath="/home/archive" 
	[ -d "$pzBkPath" ] || mkdir "$pzBkPath" 
	pzAzPath="$pzBkPath"/pzArchive 
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
	local archive="$pzAzPath"/"$day"_pz.tar.gz
	local newArchive="$pzAzPath"/"$day"_pz.tar
	local latest="$(find $pzAzPath -type f -name "$day*_bk.tar" | tail -1 )" || exit
	[ -f "$archive" ] && rm "$archive" && echo "deleting old archive"  
	echo "$latest to $archive"
	mv "$latest" "$newArchive"  
	gzip "$newArchive" 
	rm -rf "$day"T*
}
