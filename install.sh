#!/bin/bash

#==================================#
#  This file is a local installer  #
#==================================#

rsync -avh --force --exclude '*.mx' ./xAct/* ~/.Wolfram/Applications/xAct/ --delete

exit 0
