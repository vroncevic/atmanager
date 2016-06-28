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
. $UTIL/bin/loadconf.sh
. $UTIL/bin/sendmail.sh
. $UTIL/bin/checkop.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/devel.sh

ATMANAGER_TOOL=atmanager
ATMANAGER_VERSION=ver.1.0
ATMANAGER_HOME=$UTIL_ROOT/$ATMANAGER_TOOL/$ATMANAGER_VERSION
ATMANAGER_CFG=$ATMANAGER_HOME/conf/$ATMANAGER_TOOL.cfg
ATMANAGER_LOG=$ATMANAGER_HOME/log

declare -A ATMANAGER_USAGE=(
	[TOOL_NAME]="__$ATMANAGER_TOOL"
	[ARG1]="[OPERATION] start | stop | restart | start-security | version"
	[EX-PRE]="# Restart Apache Tomcat Server"
	[EX]="__$ATMANAGER_TOOL restart"
)

declare -A LOG=(
	[TOOL]="$ATMANAGER_TOOL"
	[FLAG]="info"
	[PATH]="$ATMANAGER_LOG"
	[MSG]=""
)

TOOL_DBG="false"

#
# @brief   Main function 
# @param   Value required operation to be done
# @exitval function __atmanger exit with integer value
#			0   - success operation 
#			128 - failed to load config file
#			129 - missing catalina script file
#			130 - missing argument
#			131 - wrong argument (operation)
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# local OPERATION="start"
# __atmanager "$OPERATION"
#
function __atmanager() {
	local OPERATION=$1
	local TOMCAT_HOME="/usr/share/tomcat"
	local TOMCAT_OP_LIST=( start stop restart start-security version )
	local FUNC=${FUNCNAME[0]}
	local MSG=""
	declare -A atmanagercfg=()
	__loadconf $ATMANAGER_CFG atmanagercfg
	local STATUS=$?
	if [ "$STATUS" -eq "$SUCCESS" ]; then
		__checktool "$TOMCAT_HOME/bin/catalina.sh"
		STATUS=$?
		if [ "$STATUS" -eq "$SUCCESS" ]; then
			if [ -n "$OPERATION" ] && [ -z "$OPERATION" ]; then
				__checkop "$OPERATION" "${TOMCAT_OP_LIST[*]}"
				STATUS=$?
				if [ "$STATUS" -eq "$SUCCESS" ]; then
					case "$OPERATION" in
						"start")
							eval "$TOMCAT_HOME/bin/./catalina.sh start"
							LOG[MSG]="Started Apache Tomcat Server"
							if [ "$TOOL_DBG" == "true" ]; then
								MSG="${LOG[MSG]}"
								printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
							fi
							;;
						"stop")
							eval "$TOMCAT_HOME/bin/./catalina.sh stop"
							LOG[MSG]="Stopped Apache Tomcat Server"
							if [ "$TOOL_DBG" == "true" ]; then
								MSG="${LOG[MSG]}"
								printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
							fi
							;;
						"restart")
							eval "$TOMCAT_HOME/bin/./catalina.sh stop"
							sleep 2
							eval "$TOMCAT_HOME/bin/./catalina.sh start"
							LOG[MSG]="Restarted Apache Tomcat Server"
							if [ "$TOOL_DBG" == "true" ]; then
								MSG="${LOG[MSG]}"
								printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
							fi
							;;
						"start-security")
							eval "$TOMCAT_HOME/bin/./catalina.sh start-security"
							LOG[MSG]="Start security Apache Tomcat Server"
							if [ "$TOOL_DBG" == "true" ]; then
								MSG="${LOG[MSG]}"
								printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
							fi
							;;
						"version")
							LOG[MSG]="Get version of Apache Tomcat Server"
							eval "$TOMCAT_HOME/bin/./catalina.sh version"
							;;
					esac
					if [ "$TOOL_DBG" == "true" ]; then
						printf "$DEND" "$ATMANAGER_TOOL" "$FUNC" "Done"
					fi
					if [ "${atmanagercfg[LOGGING]}" == "true" ]; then
						__logging $LOG
					fi
					exit 0
				fi
				__usage $ATMANAGER_USAGE
				exit 131
			fi 
			__usage $ATMANAGER_USAGE
			exit 130
		fi
		LOG[FLAG]="error"
		LOG[MSG]="Check file [$TOMCAT_HOME/bin/catalina.sh]"
		if [ "${atmanagercfg[LOGGING]}" == "true" ]; then
			__logging $LOG
		fi
		MSG="${LOG[MSG]}"
		printf "$SEND" "$ATMANAGER_TOOL" "$MSG"
		__sendmail "${LOG[MSG]}" "${atmanagercfg[ADMIN_EMAIL]}"
		STATUS=$?
		if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
			MSG="Check configuration of sendmail"
			printf "$SEND" "$ATMANAGER_TOOL" "$MSG"
		fi
		exit 129
	fi
	MSG="Check config file [$ATMANAGER_CFG]"
	printf "$SEND" "$ATMANAGER_TOOL" "$MSG"
	exit 128
}

#
# @brief   Main entry point
# @param   required value operation to be done
# @exitval Script tool atmanger exit with integer value
#			0   - success operation 
# 			127 - run as root user
#			128 - failed to load config file
#			129 - missing catalina script file
#			130 - missing argument
#			131 - wrong argument (operation)
#
printf "\n%s\n%s\n\n" "$ATMANAGER_TOOL $ATMANAGER_VERSION" "`date`"
__checkroot
STATUS=$?
if [ "$STATUS" -eq "$SUCCESS" ]; then
	set -u
	OPERATION=${1:-}
	__atmanager "$OPERATION"
fi

exit 127
