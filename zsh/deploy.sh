#!/bin/bash

MARKER=$CWD

cd /opt
if [ ! -d oh-my-zsh ]; then
    read -r -n "going to download oh-my-zsh to /opt, proceed? [Y/n] " RESP
    case $RESP in
        [yY][eE][sS] | [yY] )
            sudo git clone https://github.com/robbyrussell/oh-my-zsh
            sudo chown $USER:$USER oh-my-zsh
            ;;
        * )
            echo 'aborting, oh-my-zsh not deployed'
            ;;
    esac
fi
cd $MARKER
