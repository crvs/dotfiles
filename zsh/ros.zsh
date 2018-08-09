
if [ -f /opt/ros/indigo/setup.zsh ]; then

    source /opt/ros/indigo/setup.zsh
    export ROS_HOSTNAME=localhost
    export ROS_MASTER_URI=http://localhost:11311

fi

if [ -d /opt/ros ]; then

    source /opt/ros/kinetic/setup.zsh

    if [ -d $HOME/catkin_ws ]; then
        source $HOME/catkin_ws/devel/setup.zsh
    fi

    if [ -d $HOME/catkin_ws/install ]; then
        export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/catkin_ws/install/
    fi

fi

