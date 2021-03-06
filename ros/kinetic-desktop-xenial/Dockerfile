FROM osrf/ros:kinetic-desktop-xenial
# Run ROS in a container
#
# docker run -it \
#       -v /etc/localtime:/etc/localtime:ro \
#	--device /dev/dri \
#       -v /tmp/.X11-unix:/tmp/.X11-unix \
#       -e DISPLAY=unix$DISPLAY \
#       --name ros \
#       lfdebrux/ros:trusty-desktop-indigo
#
LABEL maintainer "Laurence de Bruxelles <laurence.de-bruxelles@stfc.ac.uk>"

# add a few very useful apps
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	bash-completion \
	python-wstools \
	python-catkin-tools \
	tmux \
	less \
	vim \
	silversearcher-ag \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# create a ros user
ENV HOME /home/ros
RUN useradd --groups users \
	--create-home --home-dir $HOME ros \
	--shell /bin/bash \
	&& mkdir -p $HOME/ws/src \
	&& chown -R ros:ros $HOME

# copy the rosdep information
RUN cp -r /root/.ros $HOME \
	&& chown -R ros:ros $HOME/.ros

# setup sudo so the ros user can use apt
RUN apt-get update && apt-get install -y \
	sudo \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*
RUN echo "ros ALL=NOPASSWD: /usr/bin/apt-get,/usr/bin/apt-mark" >> /etc/sudoers.d/apt-get \
	&& chmod 0440 /etc/sudoers.d/apt-get

WORKDIR $HOME
USER ros

# init catkin
RUN catkin config --workspace $HOME/ws --init --extend /opt/ros/$ROS_DISTRO \
	&& catkin build --workspace $HOME/ws

# use a new entrypoint
COPY ./catkin_entrypoint.sh /

WORKDIR $HOME/ws

ENTRYPOINT ["/catkin_entrypoint.sh"]
CMD ["bash"]
