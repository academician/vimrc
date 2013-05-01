#!/bin/bash

read -p "Install .vimrc and .vim folder symlinks in $HOME? [yN]" answer
if [[ $answer = y ]]; then
	SCRIPTPATH=$(dirname $(readlink -f $0))
	ln -s $SCRIPTPATH/.vimrc $HOME/.vimrc
	ln -s $SCRIPTPATH/.vim $HOME/.vim
	echo Done.
else
	echo Cancelled.
fi

