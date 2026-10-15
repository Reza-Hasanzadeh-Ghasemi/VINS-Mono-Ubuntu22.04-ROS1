#!/usr/bin/env bash
set -e

sudo add-apt-repository universe
sudo apt update

sudo apt install -y \
  ros-desktop-full-dev \
  catkin \
  python3-rosdep2 \
  python3-rosbag \
  git \
  cmake \
  build-essential \
  libeigen3-dev \
  libopencv-dev \
  libboost-all-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  libatlas-base-dev
