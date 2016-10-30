#!/usr/bin/env bash

TOPDIR=$PWD

# Prefix:
PREFIX=$PWD/torch

echo "Installing Xitari ... "
cd $PREFIX/src
rm -rf xitari
git clone https://github.com/zuoanqh/Xitari2Player.git xitari
cd xitari
$PREFIX/bin/luarocks make
RET=$?; if [ $RET -ne 0 ]; then echo "Error. Exiting."; exit $RET; fi
echo "Xitari installation completed"

echo "Installing Alewrap ... "
cd $PREFIX/src
rm -rf alewrap
git clone https://github.com/zuoanqh/Alewrap2Player.git alewrap
cd alewrap
$PREFIX/bin/luarocks make
RET=$?; if [ $RET -ne 0 ]; then echo "Error. Exiting."; exit $RET; fi
echo "Alewrap installation completed"

