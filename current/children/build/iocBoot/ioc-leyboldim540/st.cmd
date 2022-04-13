#!/reg/g/pcds/epics-dev/janezg/git_iocs/ioc-leyboldim540/current/bin/rhel7-x86_64/leyboldim540

< envPaths
epicsEnvSet("IOCNAME", "ioc-leyboldim540" )
epicsEnvSet("ENGINEER", "enginner_name (shortname)" )
epicsEnvSet("LOCATION", "Somewhere Over the Rainbow" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:TST:TMO")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics-dev/janezg/git_iocs/ioc-leyboldim540/current")
epicsEnvSet("TOP", "/reg/g/pcds/epics-dev/janezg/git_iocs/ioc-leyboldim540/current/children/build")
epicsEnvSet(streamDebug, 0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
epicsEnvSet("PROTO", "IM540.proto")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/leyboldim540.dbd")
leyboldim540_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Initialize IP Asyn support
drvAsynIPPortConfigure("LEYBOLD0","ser-tmo-04:4010 TCP",0,0,0)


# Load record instances
dbLoadRecords("db/iocSoft.db",             "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db",  "IOC=$(IOC_PV)")
dbLoadRecords("db/leyboldim540.db","DEV=TMO:TESTSTAND:01,PORT=LEYBOLD0,DSCAN=2,CSCAN=6")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOCNAME)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
