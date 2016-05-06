#!/bin/bash
#
# @brief   Apache Tomcat Server Manager
# @version ver.1.0
# @date    Mon Jun 02 13:36:32 2015
# @company Frobas IT Department, www.frobas.com 2015
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#  
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/checkcfg.sh
. $UTIL/bin/checkop.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

TOOL_NAME=atmanager
TOOL_VERSION=ver.1.0
TOOL_HOME=$UTIL_ROOT/$TOOL_NAME/$TOOL_VERSION
TOOL_CFG=$TOOL_HOME/conf/$TOOL_NAME.cfg
TOOL_LOG=$TOOL_HOME/log

declare -A ATMANAGER_USAGE=(
	[TOOL_NAME]="__$TOOL_NAME"
	[ARG1]="[OPTION] start | stop | restart | start-security | version"
	[EX-PRE]="# Restart Apache Tomcat Server"
	[EX]="__$TOOL_NAME restart"	
)

declare -A LOG=(
	[TOOL]="$TOOL_NAME"
	[FLAG]="info"
	[PATH]="$TOOL_LOG"
	[MSG]=""
)

TOOL_DEBUG="false"

TOMCAT_HOME=/usr/share/tomcat
TOMCAT_OP_LIST=( start stop restart start-security version )

#
# @brief Main function 
# @param Value required operation to be done
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __atmanager $OPERATION
#
function __atmanager() {
	OPERATION=$1
	if [ "$TOOL_DEBUG" == "true" ]; then
		printf "%s\n" "Apache Tomcat Server Manager"
		printf "%s" "Check Apache Tomcat "
	fi
	__checktool "$TOMCAT_HOME/bin/catalina.sh"
	STATUS=$?
	if [ "$STATUS" -eq "$SUCCESS" ]; then
		if [ "$TOOL_DEBUG" == "true" ]; then
			printf "%s\n" "[ok]"
		fi
		if [ -n "$OPERATION" ]; then
			__checkop "$OPERATION" "${TOMCAT_OP_LIST[*]}"
			STATUS=$?
			if [ "$STATUS" -eq "$SUCCESS" ]; then
				if [ ! -e "$TOMCAT_HOME/bin/catalina.sh" ]; then
					printf "%s\n\n" "[Error] Check file [$TOMCAT_HOME/bin/catalina.sh]"
					exit 130
				fi
				case "$OPERATION" in
					"start") 			eval "$TOMCAT_HOME/bin/./catalina.sh start"
										LOG[MSG]="Started Apache Tomcat Server"
										if [ "$TOOL_DEBUG" == "true" ]; then
											printf "%s\n" "[Info] ${LOG[MSG]}"
										fi
										__logging $LOG
										;;
					"stop")	    		eval "$TOMCAT_HOME/bin/./catalina.sh stop"
										LOG[MSG]="Stoped Apache Tomcat Server"
										if [ "$TOOL_DEBUG" == "true" ]; then
											printf "%s\n" "[Info] ${LOG[MSG]}"
										fi
										__logging $TOOL_LOG
										;;
					"restart")			eval "$TOMCAT_HOME/bin/./catalina.sh stop"
										sleep 2
										eval "$TOMCAT_HOME/bin/./catalina.sh start"
										LOG[LOG_MSG]="Restarted Apache Tomcat Server"
										if [ "$TOOL_DEBUG" == "true" ]; then
											printf "%s\n" "[Info] ${LOG[MSG]}"
										fi
										__logging $LOG
										;;
					"start-security")	eval "$TOMCAT_HOME/bin/./catalina.sh start-security"
										LOG[MSG]="Start security Apache Tomcat Server"
										if [ "$TOOL_DEBUG" == "true" ]; then
											printf "%s\n" "[Info] ${LOG[MSG]}"
										fi
										__logging $TOOL_LOG
										;;
					"version")		  	eval "$TOMCAT_HOME/bin/./catalina.sh version"
										;;
				esac
				if [ "$TOOL_DEBUG" == "true" ]; then
					printf "%s\n\n" "[Done]"
				fi
				exit 0
			fi
			__usage $ATMANAGER_USAGE
			exit 129
		fi 
		__usage $ATMANAGER_USAGE
		exit 128
	fi
	printf "%s\n" "[not ok]"
	printf "%s\n\n" "[Error] Check Apache Tomcat structure [$TOMCAT_HOME/]"
	exit 127
}

#
# @brief Main entry point
# @param required value operation to be done
#
printf "\n%s\n%s\n\n" "$TOOL_NAME $TOOL_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	__atmanager "$1"
fi

exit 0

