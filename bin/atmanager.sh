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

. $UTIL/bin/devel.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/checkroot.sh
. $UTIL/bin/checktool.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/checkop.sh
. $UTIL/bin/sendmail.sh
. $UTIL/bin/loadconf.sh
. $UTIL/bin/loadutilconf.sh

ATMANAGER_TOOL=atmanager
ATMANAGER_VERSION=ver.1.0
ATMANAGER_HOME=$UTIL_ROOT/$ATMANAGER_TOOL/$ATMANAGER_VERSION
ATMANAGER_CFG=$ATMANAGER_HOME/conf/$ATMANAGER_TOOL.cfg
ATMANAGER_UTIL_CFG=$ATMANAGER_HOME/conf/${ATMANAGER_TOOL}_util.cfg
ATMANAGER_LOG=$ATMANAGER_HOME/log

declare -A ATMANAGER_USAGE=(
	[USAGE_TOOL]="__$ATMANAGER_TOOL"
	[USAGE_ARG1]="[OPERATION] start | stop | restart | start-security | version"
	[USAGE_EX_PRE]="# Restart Apache Tomcat Server"
	[USAGE_EX]="__$ATMANAGER_TOOL restart"
)

declare -A ATMANAGER_LOG=(
	[LOG_TOOL]="$ATMANAGER_TOOL"
	[LOG_FLAG]="info"
	[LOG_PATH]="$ATMANAGER_LOG"
	[LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
	[BAR_WIDTH]=50
	[MAX_PERCENT]=100
	[SLEEP]=0.01
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
	local MSG="Loading basic and util configuration"
	printf "$SEND" "$ATMANAGER_TOOL" "$MSG"
	__progressbar PB_STRUCTURE
	printf "%s\n\n" ""
	declare -A configatmanager=()
	__loadconf $ATMANAGER_CFG configatmanager
	local STATUS=$?
	if [ $STATUS -eq $NOT_SUCCESS ]; then
		MSG="Failed to load tool script configuration"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "$ATMANAGER_TOOL" "$MSG"
		fi
		exit 128
	fi
	declare -A configatmanagerutil=()
	__loadutilconf $ATMANAGER_UTIL_CFG configatmanagerutil
	STATUS=$?
	if [ $STATUS -eq $NOT_SUCCESS ]; then
		MSG="Failed to load tool script utilities configuration"
		if [ "$TOOL_DBG" == "true" ]; then
			printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
		else
			printf "$SEND" "$ATMANAGER_TOOL" "$MSG"
		fi
		exit 129
	fi
	local TOM_HOME="$configatmanagerutil[TOMCAT_HOME]"
	local TOM_CAT="$configatmanagerutil[TOMCAT_CATALINA]"
	local TOMCAT_SCRIPT="$TOM_HOME/$TOM_CAT"
	__checktool $TOMCAT_SCRIPT
	STATUS=$?
	if [ $STATUS -eq $NOT_SUCCESS ]; then
		MSG="Missing external tool $TOMCAT_SCRIPT"
		if [ "${configatmanager[LOGGING]}" == "true" ]; then
			ATMANAGER_LOG[LOG_MSGE]=$MSG
			ATMANAGER_LOG[LOG_FLAG]="error"
			__logging ATMANAGER_LOG
		fi
		if [ "${configatmanager[EMAILING]}" == "true" ]; then
			__sendmail "$MSG" "${configatmanager[ADMIN_EMAIL]}"
		fi
		exit 130
	fi
	if [ -n "$OPERATION" ] && [ -z "$OPERATION" ]; then
		__checkop "$OPERATION" "${TOMCAT_OP_LIST[*]}"
		STATUS=$?
		if [ $STATUS -eq $SUCCESS ]; then
			case "$OPERATION" in
				"start")
					eval "$TOM_HOME/bin/$configatmanagerutil[RUN_CATALINA] start"
					ATMANAGER_LOG[LOG_MSGE]="Started Apache Tomcat Server"
					ATMANAGER_LOG[LOG_FLAG]="info"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"stop")
					eval "$TOM_HOME/bin/$configatmanagerutil[RUN_CATALINA] stop"
					ATMANAGER_LOG[LOG_MSGE]="Stopped Apache Tomcat Server"
					ATMANAGER_LOG[LOG_FLAG]="info"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"restart")
					eval "$TOM_HOME/bin/$configatmanagerutil[RUN_CATALINA] stop"
					sleep 2
					eval "$TOM_HOME/bin/$configatmanagerutil[RUN_CATALINA] start"
					ATMANAGER_LOG[LOG_MSGE]="Restarted Apache Tomcat Server"
					ATMANAGER_LOG[LOG_FLAG]="info"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"start-security")
					eval "$TOM_HOME/bin/$configatmanagerutil[RUN_CATALINA] start-security"
					ATMANAGER_LOG[LOG_MSGE]="Start security Apache Tomcat Server"
					ATMANAGER_LOG[LOG_FLAG]="info"
					if [ "$TOOL_DBG" == "true" ]; then
						MSG="${LOG[MSG]}"
						printf "$DSTA" "$ATMANAGER_TOOL" "$FUNC" "$MSG"
					fi
					;;
				"version")
					ATMANAGER_LOG[LOG_MSGE]="Get version of Apache Tomcat Server"
					ATMANAGER_LOG[LOG_FLAG]="info"
					eval "$TOM_HOME/bin/$configatmanagerutil[RUN_CATALINA] version"
					;;
			esac
			if [ "$TOOL_DBG" == "true" ]; then
				printf "$DEND" "$ATMANAGER_TOOL" "$FUNC" "Done"
			fi
			if [ "${configatmanager[LOGGING]}" == "true" ]; then
				__logging ATMANAGER_LOG
			fi
			exit 0
		fi
	fi		
	__usage ATMANAGER_USAGE
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
if [ $STATUS -eq $SUCCESS ]; then
	__atmanager $1
fi

exit 127

