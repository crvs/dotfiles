#!/bin/bash

if tmux has -t cmus;
then
    # cmus is already running, so reattach it
    tmux detach -s cmus
    sleep .1
    # refresh library
    cmus-remote -l ~/Music
    tmux attach -t cmus
else
    # cmus isn't running so run it inside a tmux session
    tmux new -s cmus cmus
    sleep .1
    # refresh library
    cmus-remote -l ~/Music
fi

