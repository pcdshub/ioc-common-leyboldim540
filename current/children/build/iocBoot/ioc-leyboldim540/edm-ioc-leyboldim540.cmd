#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
        source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup pydm environment
source /reg/g/pcds/pyps/conda/py36env.sh

pushd /reg/g/pcds/epics-dev/janezg/git_iocs/ioc-leyboldim540/current/leyboldim540Screens

export IOC_PV=IOC:TST:TMO
export BASE=TMO:TESTSTAND:01
pydm -m "DEV=${BASE},IOC=${IOC_PV}" leyboldim540.ui &

