#!/bin/bash

dotfilesDIr=$(pwd)

function linkFile {

echo "starting with ${1}"
dest="${HOME}/${1}"
date=$(date +%Y-%m-%d-%H%M)

if [ -L ~/${1} ]; then
   #symlink exists
   echo "Symlink exists"
   #rm {dest}

elif [ -f "${dest}" ]; then
   #file exist
   echo "File exist, backup"
   #mv ${dest} "${dest}_backup_${date}"
fi

echo "Creating new symlink for ${1}"
#ln -s ${dotfilesDir}/${1} ${dest}
}


linkFile .bashrc
linkFile .bash_profile
linkFile .gitconfig
