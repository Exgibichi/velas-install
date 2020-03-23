#!/bin/bash

ARCH=$(uname -m)
VANITY_SERVICE_URL="http://localhost/bins/$ARCH"
BIN_NAME="velasblockchain"
INSTALL_DIR="."

check_os() {
	if [ "$(uname)" = "Linux" ] ; then
	PKG="linux"   # linux is my default 

	elif [ "$(uname)" = "Darwin" ] ; then
		PKG="darwin"
		echo "Running on Apple"
	else
		echo "Unknown operating system"
		echo "Please select your operating system"
		echo "Choices:"
		echo "	     linux - any linux distro"
		echo "	     darwin - MacOS"
		read PKG
	fi
}

install() {
	curl "$VANITY_SERVICE_URL-$PKG/$BIN_NAME" -o "$INSTALL_DIR/$BIN_NAME"
    chmod +x $BIN_NAME
}

## MAIN ##

## curl installed? 
which curl &> /dev/null 
if [[ $? -ne 0 ]] ; then
    echo '"curl" binary not found, please install and retry'
    exit 1
fi
##

check_os
install