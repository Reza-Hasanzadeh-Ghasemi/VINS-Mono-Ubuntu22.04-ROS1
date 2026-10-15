#!/usr/bin/env bash
set -e

cd ~

git clone --branch 1.14.0 --depth 1 \
https://github.com/ceres-solver/ceres-solver.git \
ceres-solver-1.14.0

cd ~/ceres-solver-1.14.0

mkdir -p build
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

echo
echo "Installed Ceres version:"
grep -E "CERES_VERSION_(MAJOR|MINOR|REVISION)" \
/usr/local/include/ceres/version.h

echo
echo "CeresConfig.cmake location:"
find /usr/local -name "CeresConfig.cmake"
