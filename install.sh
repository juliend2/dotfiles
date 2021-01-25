#!/bin/sh

LINE='--------------------------------------------------------------'
CURR_DIR=`basename $PWD`
VIM_VENDOR='~/vim/pack/vendor'

if [ $CURR_DIR != 'dotfiles' ]; then
	echo $LINE
	echo " ERROR!"
	echo " You MUST execute this script from within the dotfiles directory, like this:"
	echo " $ ./install.sh"
	echo $LINE
	exit 1
fi


_symlink() {
	local from=$1
	local to=$2
	# Do the actual command:
	ln -s $from $to
}

_err_if_file_doesnt_exist() {
	local f=$1
	if [ ! -f "$f" ]; then
		echo "ERROR: $f does not exist."
		exit 1
	fi
}

_err_if_dir_doesnt_exist() {
	local d=$1
	if [ ! -d "$d" ]; then
		echo "ERROR: $d does not exist."
		exit 1
	fi
}

_err_if_file_already_exists() {
	local f=$1
	if [ -f "$f" ]; then
		echo "ERROR: $f already exists."
		exit 1
	fi
}

_err_if_dir_already_exists() {
  local d=$1
  if [ -d "$d" ]; then
    echo "ERROR: $d already exists."
  fi
}

_install() {
	local from=$1
	local to=$2
	echo "Installing $from..."

	if [ -L "$to" ]; then
		echo "Symlink to $to already exists. Skipping..."
		return
	fi

  _err_if_file_doesnt_exist $from
  _err_if_file_already_exists $to

	echo "Installing '$from' to '$to'..."
	_symlink $from $to
}

_install_dir() {
	local from=$1
	local to=$2
	echo "Installing $from directory..."

	if [ -L "$to" ]; then
		echo "Symlink to $to already exists. Skipping..."
		return
	fi

  _err_if_dir_doesnt_exist $from
  _err_if_dir_already_exists $to

	echo "Installing '$from' directory to '$to'..."
	_symlink $from $to
}


_install $PWD/gitconfig $HOME/.gitconfig

_install $PWD/vimrc $HOME/.vimrc

_install_dir $PWD/vim $HOME/.vim

vim -u NONE -c "helptags $VIM_VENDOR/start/nerdtree/doc" -c q
