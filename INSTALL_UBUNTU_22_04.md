# VINS-Mono Installation on Ubuntu 22.04 LTS

This document describes the tested installation procedure for running the original HKUST VINS-Mono on Ubuntu 22.04 LTS using ROS1.

## Tested Environment

- Ubuntu 22.04.5 LTS
- Architecture: x86_64
- ROS1 packages from Ubuntu 22.04 repositories
- Ceres Solver 1.14.0
- OpenCV 4.5.4
- Eigen 3.4.0
- C++17
- EuRoC MAV dataset successfully tested

## 1. Enable Universe Repository

```bash
sudo add-apt-repository universe
sudo apt update
```

## 2. Install ROS1 and Required Dependencies

```bash
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
```

## 3. Verify ROS Installation

```bash
which roscore
which roslaunch
which rosbag
which catkin_make
rospack find roscpp
```

Optional runtime check:

```bash
roscore
```

## 4. Install Ceres Solver 1.14.0

```bash
cd ~

git clone --branch 1.14.0 --depth 1 \
https://github.com/ceres-solver/ceres-solver.git \
ceres-solver-1.14.0

cd ~/ceres-solver-1.14.0
mkdir build
cd build

cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_TESTING=OFF \
  -DBUILD_EXAMPLES=OFF \
  -DSUITESPARSE=OFF \
  -DCXSPARSE=OFF

make -j2
sudo make install
sudo ldconfig
```

Verify the installed Ceres version:

```bash
grep -E "CERES_VERSION_(MAJOR|MINOR|REVISION)" \
/usr/local/include/ceres/version.h
```

Expected output:

```text
CERES_VERSION_MAJOR 1
CERES_VERSION_MINOR 14
CERES_VERSION_REVISION 0
```

## 5. Create a Catkin Workspace

```bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
```

Clone this repository:

```bash
git clone <THIS_REPOSITORY_URL>
```

## 6. Ubuntu 22.04 Compatibility Change

The original VINS-Mono packages use C++11.

For Ubuntu 22.04 compatibility, the tested configuration uses C++17.

All occurrences of:

```text
-std=c++11
```

in the VINS-Mono `CMakeLists.txt` files were changed to:

```text
-std=c++17
```

## 7. Build VINS-Mono

```bash
cd ~/catkin_ws
catkin_make -DCMAKE_BUILD_TYPE=Release -j2
```

A successful build should end with:

```text
[100%] Built target vins_estimator
```

## 8. Source the Workspace

```bash
source ~/catkin_ws/devel/setup.bash
```

Optional:

```bash
echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc
source ~/.bashrc
```

## 9. EuRoC Test

### Terminal 1 — Run VINS-Mono

```bash
source ~/catkin_ws/devel/setup.bash
roslaunch vins_estimator euroc.launch
```

### Terminal 2 — Run RViz

```bash
source ~/catkin_ws/devel/setup.bash
roslaunch vins_estimator vins_rviz.launch
```

### Terminal 3 — Play the EuRoC Dataset

```bash
rosbag play /path/to/MH_01_easy.bag
```

## Validation Status

This configuration was successfully built and tested on Ubuntu 22.04.5 LTS with the EuRoC MAV dataset.

The build completed successfully with:

```text
[100%] Built target vins_estimator
```

A clean-install reproduction test on a second independent system has not yet been performed.

## Notes

This repository is an unofficial compatibility port of the original HKUST VINS-Mono project.

The core VINS-Mono algorithm has not been redesigned. The modifications are intended to provide compatibility with Ubuntu 22.04 LTS and newer system libraries while preserving the original implementation.
