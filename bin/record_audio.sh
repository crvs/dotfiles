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
    filename=`newfile recording .ogg`
else
    if [ -f $filename ]; then
        exit 1
    fi
fi

ffmpeg -f pulse -ac 1 -i default $filename
echo recorded $filename
stat $filename

