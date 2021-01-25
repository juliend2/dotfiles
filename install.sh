#!/bin/sh

LINE='--------------------------------------------------------------'
CURR_DIR=`basename $PWD`

if [ $CURR_DIR != 'dotfiles' ]; then
	echo $LINE
	echo " ERROR!"
	echo " You MUST execute this script from within the dotfiles directory, like this:"
	echo " $ ./install.sh"
	echo $LINE
	exit 1
fi

#echo "DOING THINGS"

_install() {
	local from=$1
	local to=$2
	echo "Installing $from..."

	if [ ! -f "$from" ]; then
		echo "ERROR: $from does not exist."
		exit 1
	fi

	if [ -f "$to" ]; then
		echo "ERROR: $to already exists."
		exit 1
	fi

	echo "Installing '$from' to '$to'..."
	
	# Do the actual command:
	ln -s $from $to
}

_install $PWD/gitconfig $HOME/.gitconfig
