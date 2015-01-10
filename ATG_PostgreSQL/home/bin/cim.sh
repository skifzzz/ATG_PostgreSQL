#!/bin/sh 

PROGRAM=`basename $0`
PROGRAM_DIR=`dirname $0`
ulimit -n 1000

# No coredumps
ulimit -c 0

#
# Usage
#
usage() {
  echo
  echo "Usage:"
  echo "cim.sh [-m MODULELIST] [-debug] [-record] [-noencryption] [-batch inputFilePath] [-migration] [-migrationpath migrationKitsBasePath]"
  echo
}


# check to make sure dynamo home is set
. $PROGRAM_DIR/checkDynamoHome.sh
DYNAMO_HOME=`pwd`
if [ -r ${DYNAMO_HOME}/localconfig/dasEnv.sh ] ; then
	. ${DYNAMO_HOME}/localconfig/dasEnv.sh
fi 

# check JAVA_HOME
  if [ "$ATGJRE" = "" ] ; then
	 echo You must set the ATGJRE variable to point to the java executable
	 exit 1
  fi
. $DYNAMO_HOME/bin/j2eeEnv.sh  
#
# check and prepare environment for CIM execution
#
DYNAMO_MODULES="CIM"

if [ "$DEVTOOLS_CLASSPATH" ] ; then
    
  # +++ devtools env setup

  DYNAMO_ROOT=$DEVTOOLS_PROJECTROOT/Dynamo
  DBSETUP_HOME=$DEVTOOLS_PROJECTROOT/ATGDBSetup/ATGDBSetupEar/_build; export DBSETUP_HOME

else

  # +++ NON devtools env setup

  # check DYNAMO_HOME
  if [ "${DYNAMO_HOME}" = "" ] ; then
      echo "You must set the DYNAMO_HOME environment variable to point to your"
      echo "Dynamo install directory."
      exit 1
  fi

  DYNAMO_ROOT=$DYNAMO_HOME/..

fi

  CIM_HOME=$DYNAMO_ROOT/CIM
  DBSETUP_HOME=$DYNAMO_ROOT/ATGDBSetup; export DBSETUP_HOME

  CIM_ARGS="-Dcim.home=$CIM_HOME -Ddynamo.root=$DYNAMO_ROOT -Djava.util.logging.config.file=$CIM_HOME/lib/logging.properties"

#
# Parse the input arguments
#

DEBUG_ARGS=""
RECORD_ARGS=""

# default mode is console
MODE_ARGS="-Dcim.console=true"

while [ $# -ne 0 ]
  do
  if [ "$1" = "-debug" ] ; then
      DEBUG_ARGS="-Djava.compiler=NONE -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=3000"
          echo "Debug mode enabled on port 3000.  Waiting for connection to Attach."
      
  elif [ "$1" = "-mock" ] ; then
      MODE_ARGS="-Dcim.mock=true"  
          
  elif [ "$1" = "-noencryption" ] ; then
      ENCRYPTION_ARGS="-Dcim.encryption=false"
      
  elif [ "$1" = "-record" ] ; then
      RECORD_ARGS="-Dcim.record=true"  
          echo "Batch Mode Recording Enabled"
  elif [ "$1" = "-m" ] ; then
        shift
        DYNAMO_MODULES=${DYNAMO_MODULES}:$1  
  elif [ "$1" = "-batch" ] ; then
      shift
      if [ -f "$1" ]; then
        MODE_ARGS="-Dcim.batch=true -Dcim.batch.inputFileName=$1"
      else
          echo "Not a valid file : $1"
          usage
          exit 1
      fi
  elif [ "$1" = "-migration" ] ; then
      MIGRATION_ARGS="-Dcim.migration=true"
  elif [ "$1" = "-migrationpath" ] ; then
      shift
      if [ -d "$1" ] ; then
        if [ "$MIGRATION_ARGS" != "" ]; then
          MIGRATION_ARGS="$MIGRATION_ARGS -Dcim.migration.kitPath=$1"
        else
          echo "Give the -migration key before using -migrationpath key"
          usage
          exit 1
        fi  
      else
          echo "Not a valid directory : $1"
          usage
          exit 1
      fi  
  elif [ "$1" = "-previous" ] ; then
      shift
      if [ -d "$1" ] ; then
        if [ "$MIGRATION_ARGS" != "" ]; then
          MIGRATION_ARGS="$MIGRATION_ARGS -Dprevious.platform.location=$1"
        else
          echo "Give the -migration key before using -previous key"
          usage
          exit 1
        fi  
      else
          echo "Not a valid directory : $1"
          usage
          exit 1
      fi  
  else 
    echo "Invalid option(s) supplied"
    usage
    exit 1
  fi

  shift

done

SERVERNAME=CIM

if [ ! -d $DYNAMO_HOME/$SERVERNAME ] ;
  then
  mkdir $DYNAMO_HOME/$SERVERNAME
fi

. bin/dynamoEnv.sh 

"$JAVA_VM" $JAVA_ARGS $DEBUG_ARGS $MODE_ARGS $RECORD_ARGS $CIM_ARGS $ENCRYPTION_ARGS $MIGRATION_ARGS atg.cim.Launcher  -configPath ../CIM/lib/AwsomeCIM.jar $CONFIGPATH




