#!/bin/bash
DIR="${BASH_SOURCE%/*}"

if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/pzmain.sh"
. "$DIR/pzcore.sh"
. "$DIR/pzbot.sh"
. "$DIR/pzetc.sh"
. "$DIR/pzbk.sh"
. "$DIR/pzchunk.sh"

#User Directory
pzPath=/home/"$USER"

################## Script Paths Variables ################
pzBkPath=$pzPath/pzBins
pzCmdPath=$pzPath/bin
pzFreshPath=$pzPath/mapBins
pzZPath=$pzPath/Zomboid

pzMpPath=$pzZPath/Multiplayer

pzMapPath=$pzMpPath/servertest
