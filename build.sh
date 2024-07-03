echo "Configuring and building DSO ..."

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j12
