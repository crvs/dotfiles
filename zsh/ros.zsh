
if [ -f /opt/ros/indigo/setup.zsh ]; then
    source /opt/ros/indigo/setup.zsh
    export ROS_HOSTNAME=localhost
    export ROS_MASTER_URI=http://localhost:11311
fi

if [ -d /opt/ros/kinetic ]; then
    source /opt/ros/kinetic/setup.zsh
    export ROS_HOSTNAME=localhost
    export ROS_MASTER_URI=http://localhost:11311
fi

if [ -d $HOME/catkin_ws/install ]; then
    export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/catkin_ws/install/
fi

if [ -f $HOME/catkin_ws/devel/setup.zsh ]; then
    source $HOME/catkin_ws/devel/setup.zsh
fi

