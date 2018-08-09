export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on swing.aatext=true'
export JAVA_FONTS=/usr/share/fonts/TTF

# java classes
if [ -d $HOME/.javapackages ]; then
    for f in `find $HOME/.javapackages -name '*.jar'`
        do export CLASSPATH=$CLASSPATH:$f
    done
fi
