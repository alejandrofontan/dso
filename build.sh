#!/bin/bash

delete_if_exists() {
  local folder=$1
  build_folder="${folder}/build"
  bin_folder="${folder}/bin"
  lib_folder="${folder}/lib"
  if [ -d "$build_folder" ]; then
    rm -rf "$build_folder"
  fi
  if [ -d "$bin_folder" ]; then
    rm -rf "$bin_folder"
  fi
  if [ -d "$lib_folder" ]; then
    rm -rf "$lib_folder"
  fi
}

# Check inputs
force_build=false
verbose=false
for input in "$@"
do
    echo "Processing input: $input"
    if [ "$input" = "-f" ]; then
  	force_build=true   
    fi
    if [ "$input" = "-v" ]; then
  	verbose=true   
    fi
done

# Baseline Dir
DSO_PATH=$(realpath "$0")
DSO_DIR=$(dirname "$DSO_PATH")

## Compile DSO 
source_folder="${DSO_DIR}"     
build_folder="$source_folder/build"
bin_folder="$source_folder/bin"
lib_folder="$source_folder/lib"

if [ "$force_build" = true ]; then
	delete_if_exists ${source_folder}
fi

if [ "$verbose" = true ]; then
	echo "[dso][build.sh] Compile DSO ... "   
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder 
	cmake --build $build_folder --config Release 
else
        echo "[dso][build.sh] Compile DSO (output disabled) ... "   
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder > /dev/null 2>&1
	cmake --build $build_folder --config Release > /dev/null 2>&1
fi
