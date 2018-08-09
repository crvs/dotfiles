# this script file sets up aliases for common uses of docker containers it should be sourced by zshrc

xhost +local: 1>& /dev/null

dock() {
    docker run -it \
      --user=$(id -u) \
      -e DISPLAY=unix:0.0 \
      -e CONTAINER_NAME=ros-kinetic-dev \
      -e USER=$USER \
      --workdir=/home/$USER \
      -v "/tmp/.X11-unix:/tmp/.X11-unix" \
      -v "/etc/hostname:/etc/hostname:ro" \
      -v "/home/$USER/:/home/$USER/" \
      --device=/dev/dri:/dev/dri \
      --privileged \
      $@
}

#      -e QT_GRAPHICSSYSTEM=native \
#      --net=host \
#      -v "/etc/group:/etc/group:ro" \
#      -v "/etc/passwd:/etc/passwd:ro" \
#      -v "/etc/shadow:/etc/shadow:ro" \
#      -v "/etc/sudoers.d:/etc/sudoers.d:ro" \
