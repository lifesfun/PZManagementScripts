#!/bin/bash
##### Backup Functions #####
function pzBk(){

	pzGetNow "pzBackup: $1" 
	local bkName="$pzNow"_bk_"$1".tar
	local bkPath="$pzBakPath"/"$1" 
	pzCmd save
	ionice -c3 tar -C "$2" -cf "$bkPath"/"$bkName"  $3 
}
function pzBkMapBins(){
	
	pzMsg "Backup Up Time...You May Experience some lag :D"
	pzBk "mapBins" "$pzMpPath" "servertest"	
	pzCompress

}
function pzBkFreshBins(){

	pzBk "freshBins" "$pzPath" "mapBins" 
}
function pzBkConf(){
	
	pzBk "db" "$pzZPath" "db" 
	pzBk "server" "$pzZPath" "Server" 
}

##### Archive and Compression Functions #####
function pzCompress(){
	pzGetNow "pzCompress"
	ionice -c3 find $pzBakPath -type f -name "*bk*.tar" -exec gzip {} \;
}
function pzArchive(){

	pzMsg "Archiving todays saves...You May Experience some lag :D"
	pzGetNow "pzArchive"
	pzCompress
	local aName="$pzNow"_archive.tar 
	local aPaths='mapBins db server'
	cd "$pzBakPath"
	mkdir $aPaths
	ionice -c3 tar -cf "$pzBakPath"/"$aName" $aPaths  
	[ "$?" -eq '0' ] && rm -rf $aPaths
	mkdir $aPaths
	cd - 
	pzMsg "Todays archive has completed!"
}
