#!/usr/bin/env bash
set -e

cd ~/catkin_ws

echo "Cleaning previous build..."
rm -rf build devel

echo "Building VINS-Mono in Release mode..."
catkin_make -DCMAKE_BUILD_TYPE=Release -j2

echo
echo "Sourcing catkin workspace..."
source ~/catkin_ws/devel/setup.bash

echo
echo "Checking ROS packages..."

rospack find vins_estimator
rospack find feature_tracker

echo
echo "VINS-Mono build completed successfully."
