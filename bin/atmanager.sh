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
. $UTIL/bin/loadutilconf.sh
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
#			0   - tool finished with success operation 
#			128 - failed to load tool script configuration from file 
#			129 - failed to load tool script utilities configuration from file
#			130 - missing external tool tomcat
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
	local TOMCAT_OP_LIST=( start stop restart start-security version )
	local FUNC=${FUNCNAME[0]}
	local MSG=""
	declare -A atmanagercfg=()
	__loadconf $ATMANAGER_CFG atmanagercfg
	local STATUS=$?
	if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
		MSG="Failed to load tool script configuration"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "[$ATMANAGER_TOOL]" "$MSG"
		fi
		exit 128
	fi
	declare -A atmanagerutilcfg=()
	__loadconf $ATMANAGER_CFG atmanagerutilcfg
	STATUS=$?
	if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
		MSG="Failed to load tool script utilities configuration"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "[$ATMANAGER_TOOL]" "$MSG"
		fi
		exit 129
	fi
	local TOM_HOME="$atmanagerutilcfg[TOMCAT_HOME]"
	local TOM_CAT="$atmanagerutilcfg[TOMCAT_CATALINA]"
	local TOMCAT_SCRIPT="$TOM_HOME/$TOM_CAT"
	__checktool $TOMCAT_SCRIPT
	STATUS=$?
	if [ "$STATUS" -eq "$NOT_SUCCESS" ]; then
		MSG="Missing external tool $TOMCAT_SCRIPT"
		if [ "${atmanagercfg[LOGGING]}" == "true" ]; then
			LOG[MSG]=$MSG
			LOG[FLAG]="error"
			__logging $LOG
		fi
		if [ "${atmanagercfg[EMAILING]}" == "true" ]; then
			__sendmail "$MSG" "${atmanagercfg[ADMIN_EMAIL]}"
		fi
		exit 130
	fi
	if [ -n "$OPERATION" ] && [ -z "$OPERATION" ]; then
		__checkop "$OPERATION" "${TOMCAT_OP_LIST[*]}"
		STATUS=$?
		if [ "$STATUS" -eq "$SUCCESS" ]; then
			case "$OPERATION" in
				"start")
					eval "$TOM_HOME/bin/$atmanagerutilcfg[RUN_CATALINA] start"
					LOG[MSG]="Started Apache Tomcat Server"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"stop")
					eval "$TOM_HOME/bin/$atmanagerutilcfg[RUN_CATALINA] stop"
					LOG[MSG]="Stopped Apache Tomcat Server"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"restart")
					eval "$TOM_HOME/bin/$atmanagerutilcfg[RUN_CATALINA] stop"
					sleep 2
					eval "$TOM_HOME/bin/$atmanagerutilcfg[RUN_CATALINA] start"
					LOG[MSG]="Restarted Apache Tomcat Server"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"start-security")
					eval "$TOM_HOME/bin/$atmanagerutilcfg[RUN_CATALINA] start-security"
					LOG[MSG]="Start security Apache Tomcat Server"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"version")
					LOG[MSG]="Get version of Apache Tomcat Server"
					eval "$TOM_HOME/bin/$atmanagerutilcfg[RUN_CATALINA] version"
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
	fi		
	__usage $ATMANAGER_USAGE
	exit 131
}

#
# @brief   Main entry point
# @param   required value operation to be done
# @exitval Script tool atmanger exit with integer value
#			0   - tool finished with success operation 
# 			127 - run tool script as root user from cli
#			128 - failed to load tool script configuration from file 
#			129 - failed to load tool script utilities configuration from file
#			130 - missing external tool tomcat
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

