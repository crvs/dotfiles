function slink () {
    if [ -f $1 ]; then
        if [ ! -f $2 ]; then
            ln -s $1 $2;
        else;
            echo "both files exist: not creating a link";
            return 1
        fi;
    else;
        if [ -f $2 ]; then
            ln -s $2 $1;
        else;
            echo "none of those files exist: not creating a link";
            return 2
        fi;
    fi;
    return 0;
}
