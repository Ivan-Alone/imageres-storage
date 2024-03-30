#!/bin/bash

GEEKBENCH_VERSIONS=(4.4.4 5.5.1 6.2.2)

clear

for version in ${GEEKBENCH_VERSIONS[@]}; do

  gb_path=Geekbench-$version-Linux
  tar_dl=$gb_path.tar.gz

  wget https://cdn.geekbench.com/$tar_dl

  tar -xvf $tar_dl
  rm $tar_dl

  files=$(ls -1d $gb_path/geekbench[0-9]*)
  IFS=$'\n' read -rd '' -a main_exe <<<"$files"

  ./$main_exe

  rm -rf $gb_path

done
