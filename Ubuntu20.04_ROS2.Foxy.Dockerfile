FROM ubuntu:20.04
LABEL maintainer="Raphael Lehmann <raphael+docker@rleh.de>"
LABEL Description="Docker image to with ROS on Ubuntu"
WORKDIR /work

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q \
    && apt-get -y dist-upgrade \
    && apt-get -y -q install curl gnupg2 lsb-release software-properties-common \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
    && sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' \
    && apt-get update -q \
    && apt-get -y -q install ros-foxy-ros-base ros-foxy-ros2bag ros-foxy-rosbag2-storage-default-plugins-dbgsym build-essential git wget python3-colcon-common-extensions python3-pip python3-vcstool ros-foxy-launch* libboost-regex-dev libboost-system-dev libboost-thread-dev libboost-program-options-dev g++ gcc libsdl2-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV AMENT_CURRENT_PREFIX=/opt/ros/foxy
ENV AMENT_PREFIX_PATH=/opt/ros/foxy
ENV PYTHONPATH=/opt/ros/foxy/lib/python3.8/site-packages
