#!/bin/bash
SPOTIFY_DIR=$HOME/.config/spotify

if [[ -d $SPOTIFY_DIR ]]; then
    SPOTIFY_DIRS=`ls $SPOTIFY_DIR/Users/`
    for DIR in $SPOTIFY_DIRS; do
        SPOTIFY_CONFIG=$SPOTIFY_DIR/Users/$DIR/prefs
        cat $SPOTIFY_CONFIG | grep 'ui\.track_notifications_enabled' > /dev/null
        if [[ ! $? = 0 ]]; then
            echo 'ui.track_notifications_enabled=false' >> $SPOTIFY_CONFIG
        fi
    done
fi
