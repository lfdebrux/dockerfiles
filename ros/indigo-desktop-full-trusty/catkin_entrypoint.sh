#!/bin/bash
set -e

# setup ros environment via catkin workspace
if [ -f "$HOME/ws/devel/setup.bash" ]; then
	source "$HOME/ws/devel/setup.bash"
else
	source "/opt/ros/$ROS_DISTRO/setup.bash"
fi

exec "$@"
