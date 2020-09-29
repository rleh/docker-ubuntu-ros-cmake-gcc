FROM ubuntu:18.04
LABEL maintainer="Raphael Lehmann <raphael+docker@rleh.de>"
LABEL Description="Docker image to with ROS on Ubuntu"
WORKDIR /work

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q \
    && apt-get -y dist-upgrade \
    && apt-get -y -q install curl wget gnupg2 lsb-release software-properties-common snapd \
    && wget -qO- https://github.com/Kitware/CMake/releases/download/v3.18.3/cmake-3.18.3-Linux-x86_64.tar.gz | tar xz -C /opt \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' \
    && add-apt-repository ppa:ubuntu-toolchain-r/test \
    && apt-get update -q \
    && apt-get -y -q install ros-eloquent-ros-base ros-eloquent-ros2bag ros-eloquent-rosbag2-storage-default-plugins-dbgsym build-essential git wget python3-colcon-common-extensions python3-pip python-rosdep python3-vcstool ros-eloquent-launch* libboost-regex-dev libboost-system-dev libboost-thread-dev libboost-program-options-dev g++-9 gcc-9 libsdl2-dev \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH "/opt/cmake-3.18.3-Linux-x86_64/bin:$PATH"
ENV AMENT_CURRENT_PREFIX=/opt/ros/eloquent
ENV AMENT_PREFIX_PATH=/opt/ros/eloquent
ENV PYTHONPATH=/opt/ros/eloquent/lib/python3.6/site-packages
