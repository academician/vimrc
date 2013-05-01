#!/bin/bash

read -p "Uninstall .vimrc and .vim folder symlinks in $HOME? [yN]" answer
if [[ $answer = y ]]; then
	if [ -h $HOME/.vim ] && [ -h $HOME/.vimrc ]; then
		rm $HOME/.vim
		rm $HOME/.vimrc
		echo Done.
	else
		echo Error: Not installed correctly.
	fi
else
	echo Cancelled.
fi

