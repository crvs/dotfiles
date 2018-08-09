if [ -d /opt/ros ]
    then source /opt/ros/kinetic/setup.zsh
    if [ -d $HOME/catkin_ws ]
        then source $HOME/catkin_ws/devel/setup.zsh
    fi
fi

