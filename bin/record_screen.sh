#!/usr/bin/sh

filename=$1

newfile () {
    prefix=$1
    suffix=$2
    filename=`printf "${prefix}%03d${suffix}" $i`
    i=0
    while [ -f $filename ] ; do
        i=$(( i+1 ))
        filename=`printf "${prefix}%03d${suffix}" $i`
    done
    echo $filename
    return 0
}

export newfile

if [ "$filename" = "" ]; then
    filename=`newfile recording .mov`
else
    if [ -f $filename ]; then
        exit 1
    fi
fi

# for the right-screen
# ffmpeg -video_size 1920x1080 -framerate 10 -f x11grab -i :0.0+1920,0 -f pulse -ac 2 -i default $filename
ffmpeg -video_size 1920x1080 -framerate 10 -f x11grab -i :0.0 -f pulse -ac 2 -i default $filename
echo recorded $filename
stat $filename


