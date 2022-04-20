#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/leyboldim540

< envPaths
epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOC_PV",    "$$IOC_PV"   )
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOC_PV)")
epicsEnvSet( "IOCTOP",    "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
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
$$LOOP(LEYBOLD)
drvAsynIPPortConfigure("LEYBOLD$$INDEX","$$PORT TCP",0,0,0)
$$ENDLOOP(LEYBOLD)

$$LOOP(LEYBOLD)
$$IF(ASYNTRACE)
asynSetTraceIOMask("LEYBOLD$$INDEX", 0, 0x6)
asynSetTraceMask  ("LEYBOLD$$INDEX", 0, 0x9)
asynSetTraceFile("LEYBOLD$$INDEX", 0, "/reg/d/iocData/$(IOC)/logs/LEYBOLD$$INDEX.log")
$$ELSE(ASYNTRACE)
$$ENDIF(ASYNTRACE)
$$ENDLOOP(LEYBOLD)

# Load record instances
dbLoadRecords("db/iocSoft.db",             "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db",  "P=$(IOC_PV):")
$$LOOP(LEYBOLD)
dbLoadRecords("db/leyboldim540.db","DEV=$$BASE,PORT=LEYBOLD$$INDEX,DSCAN=$$IF(DATASCAN,$$DATASCAN,1),CSCAN=$$IF(CONFSCAN,$$CONFSCAN,5)")
$$ENDLOOP(LEYBOLD)

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV)" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
