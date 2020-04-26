#!/bin/bash

CMUSSTATUS="/tmp/cmus-status"
(cmus-remote -Q > /tmp/cmus-status) 2>/dev/null

# check if cmus is running.
# could do this more intelegently by using pgrep or something
if [[ `cat $CMUSSTATUS` = "" ]]; then
    echo ''
else
    # check the status of cmus
    STATUS=`cat $CMUSSTATUS | grep "status" | sed 's/status //'`
    if [[ $STATUS = "stopped" ]]; then
        # if its stopped, do nothing
        echo ""
    else
        # get the artist name, the tile, the duration and the current position
        # of the current song
        ARTIST=`cat $CMUSSTATUS | grep "tag artist" | sed 's/tag artist //'`
        TITLE=`cat $CMUSSTATUS | grep "tag title" | sed 's/tag title //'`
        POS=`cat $CMUSSTATUS | grep position | awk '{print $NF;}'`
        # figure out how many minutes and seconds are in the position
        POSMIN=`echo $POS | awk '{print $1 / 60}' | sed 's/\..*//'`
        POSSEC=`echo $POS" "$POSMIN | awk '{print $1 - ($2 * 60)}'`
        # figure out how many minutes and seconds are in the duration
        DUR=`cat $CMUSSTATUS | grep duration | awk '{print $NF;}'`
        DURMIN=`echo $DUR | awk '{print $1 / 60}' | sed 's/\..*//'`
        DURSEC=`echo $DUR" "$DURMIN | awk '{print $1 - ($2 * 60)}'`
        # pad the duration with 0 if necessary
        DURSEC=`echo $DURSEC | awk '{if (length $1 < 2)
                                print 0$1
                             else
                                print $1
                            }'`
        # pad the position with 0 if necessary
        POSSEC=`echo $POSSEC | awk '{if (length $1 < 2)
                                print 0$1
                             else
                                print $1
                            }'`
        # print out the formated string as we want it
        echo "("$STATUS") "$ARTIST" - "$TITLE" ("$POSMIN":"$POSSEC"/"$DURMIN":"$DURSEC")"
    fi
fi
