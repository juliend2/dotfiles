#!/bin/sh


# Set some variables:

LINE='--------------------------------------------------------------'
CURR_DIR=`basename $PWD`
VIM_VENDOR='~/vim/pack/vendor'

# Ensure we call this script from the proper place:

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

# Error out if {something}:

_err_if_file_doesnt_exist() {
	local f=$1
	if [ ! -f "$f" ]; then
		echo "❌ ERROR: $f does not exist."
		exit 1
	fi
}

_err_if_dir_doesnt_exist() {
	local d=$1
	if [ ! -d "$d" ]; then
		echo "❌ ERROR: $d does not exist."
		exit 1
	fi
}

_err_if_file_already_exists() {
	local f=$1
	if [ -f "$f" ]; then
		echo "❌ ERROR: $f already exists."
		exit 1
	fi
}

_err_if_dir_already_exists() {
  local d=$1
  if [ -d "$d" ]; then
    echo "❌ ERROR: $d already exists."
  fi
}

_err_if_source_already_exists() {
  local line=$1
  local file=$2
  local basenamed=$(basename $line)

  if grep -Fq "$basenamed" $file
  then
    echo "❌ ERROR: The line '$line' already exist in $file."
    exit 1
  fi
}


# Installation scripts:

_install() {
	local from=$1
	local to=$2
	echo "Installing $from..."

	if [ -L "$to" ]; then
		echo "❌ Symlink to $to already exists. Skipping..."
		return
	fi

  	_err_if_file_doesnt_exist $from
  	#_err_if_file_already_exists $to
	err=$(_err_if_file_already_exists $to)

	if [ -n "$err" ]; then
		echo "❌ Symlink to $to already exists. Skipping..."
	else
		echo "Installing '$from' to '$to'..."
		_symlink $from $to
	fi
}

_install_bash_source() {
  local src=$1
  local file=$2
  echo "Installing a sourcing of '$src' to '$file'..."

  _err_if_source_already_exists $src $file

  echo "source $src" >> $file
}

_install_dir() {
	local from=$1
	local to=$2
	echo "Installing $from directory..."

	if [ -L "$to" ]; then
		echo "❌ Symlink to $to already exists. Skipping..."
		return
	fi

	_err_if_dir_doesnt_exist $from
	err=$(_err_if_dir_already_exists $to)

	if [ -n "$err" ]; then
		echo "❌ Folder to $to already exists. Skipping..."
	else
		echo "Installing '$from' directory to '$to'..."
		_symlink $from $to
	fi
}

# Run the installation of dot(files|directories) ...
_install_dir $PWD/dot_config $HOME/.config
_install $PWD/tmux.conf $HOME/.tmux.conf
_install $PWD/gitconfig $HOME/.gitconfig
_install $PWD/vimrc $HOME/.vimrc
_install $PWD/ssh_rc.sh $HOME/.ssh/rc
#_install $PWD/xprofile $HOME/.xprofile
#_install $PWD/xinitrc $HOME/.xinitrc
_install $PWD/inputrc $HOME/.inputrc
_install_dir $PWD/vim $HOME/.vim
#_install_dir $PWD/screenlayout $HOME/.screenlayout

# Adding bash sub-config:
_install_bash_source $PWD/bash_aliases.sh $HOME/.bashrc

# Add plugins' documentation:
vim -u NONE -c "helptags $VIM_VENDOR/start/nerdtree/doc" -c q
