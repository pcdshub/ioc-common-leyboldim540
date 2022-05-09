TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build an ioc application
# Use PROD_IOC_RTEMS for RTEMS only
# Use PROD_IOC_Linux for Linux only
PROD_IOC = leyboldim540

PROD_SYS_LIBS_DEFAULT += pcre

# leyboldim540.dbd will be created and installed
DBD += leyboldim540.dbd

# leyboldim540.dbd will be made up from these files:
leyboldim540_DBD += base.dbd
leyboldim540_DBD += iocAdmin.dbd
leyboldim540_DBD += asSupport.dbd
leyboldim540_DBD += asyn.dbd
leyboldim540_DBD += stream.dbd
leyboldim540_DBD += drvAsynIPPort.dbd
leyboldim540_DBD += drvAsynSerialPort.dbd
leyboldim540_DBD += caPutLog.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
leyboldim540_SRCS += leyboldim540_registerRecordDeviceDriver.cpp
leyboldim540_SRCS_DEFAULT += leyboldim540Main.cpp

# Add locally compiled object code
#leyboldim540_SRCS += dbSubExample.c

leyboldim540_LIBS += devIocStats
leyboldim540_LIBS += autosave
leyboldim540_LIBS += asyn
leyboldim540_LIBS += stream
leyboldim540_LIBS += caPutLog
leyboldim540_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
