#!/bin/sh -f

# script to run Ocean Data View 64 bit on a Linux 64 bit system

# edit the lines immediately following #TODO, set execute attribute and
# move to a directory in your path. USAGE: run_odv [collection]

# © 2023 Reiner Schlitzer,
#        Alfred Wegener Institute,
#        Bremerhaven, Germany
#        Reiner.Schlitzer@awi.de


#TODO: set ODVHOME to the full path-name of the odv install-directory
ODVHOME=/app/odv


#-----------------------------------------------------------------------
# nothing to be changed below this line

# test if ODV_ARGS exists

echo checking ODV_ARGS

# Check if the environment variable ODV_ARG1 is set and not empty
if [ -n "${ODV_ARG1}" ]; then
    set -- "$ODV_ARG1"
    echo ODV_ARG1 is set to $ODV_ARG1
fi

# Check if the environment variable ODV_ARG2 is set and not empty
if [ -n "${ODV_ARG2}" ]; then
    set -- "$1" "$ODV_ARG2"
    echo ODV_ARG2 is set to $ODV_ARG2
fi

# Check if the environment variable ODV_ARG3 is set and not empty
if [ -n "${ODV_ARG3}" ]; then
    set -- "$1" "$2" "$ODV_ARG3"
    echo ODV_ARG3 is set to $ODV_ARG3
fi

# Check if the environment variable ODV_ARG4 is set and not empty
if [ -n "${ODV_ARG4}" ]; then
    set -- "$1" "$2" "$3" "$ODV_ARG4"
    echo ODV_ARG4 is set to $ODV_ARG4
fi

# Check if the environment variable ODV_ARG5 is set and not empty
if [ -n "${ODV_ARG5}" ]; then
    set -- "$1" "$2" "$3" "$4" "$ODV_ARG5"
    echo ODV_ARG5 is set to $ODV_ARG5
fi


# set LD_LIBRARY_PATH
if [ -z LD_LIBRARY_PATH ]
then
LD_LIBRARY_PATH=${ODVHOME}/bin_linux-amd64
else
LD_LIBRARY_PATH=${ODVHOME}/bin_linux-amd64:${LD_LIBRARY_PATH}
fi

# set PATH
PATH=${PATH}:${ODVHOME}/bin_linux-amd64

export LD_LIBRARY_PATH
export PATH

echo ODV home is       : ${ODVHOME}
echo ODV executable is : ${ODVHOME}/bin_linux-amd64/odv
echo ODV args are      : $1 $2 $3 $4 $5
echo ODV command is    : ${ODVHOME}/bin_linux-amd64/odv $1 $2 $3 $4 $5

exec ${ODVHOME}/bin_linux-amd64/odv $1 $2 $3 $4 $5
