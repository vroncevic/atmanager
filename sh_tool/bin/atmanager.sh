#!/bin/bash
#
# @brief   Apache Tomcat Server Manager
# @version ver.4.0
# @date    Sat Nov 20 11:40:40 CET 2021
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.    ${UTIL}/bin/devel.sh
.    ${UTIL}/bin/usage.sh
.    ${UTIL}/bin/check_root.sh
.    ${UTIL}/bin/check_tool.sh
.    ${UTIL}/bin/check_op.sh
.    ${UTIL}/bin/logging.sh
.    ${UTIL}/bin/load_conf.sh
.    ${UTIL}/bin/load_util_conf.sh
.    ${UTIL}/bin/progress_bar.sh

ATMANAGER_TOOL=atmanager
ATMANAGER_VERSION=ver.4.0
ATMANAGER_HOME=${UTIL_ROOT}/${ATMANAGER_TOOL}/${ATMANAGER_VERSION}
ATMANAGER_CFG=${ATMANAGER_HOME}/conf/${ATMANAGER_TOOL}.cfg
ATMANAGER_UTIL_CFG=${ATMANAGER_HOME}/conf/${ATMANAGER_TOOL}_util.cfg
ATMANAGER_LOGO=${ATMANAGER_HOME}/conf/${ATMANAGER_TOOL}.logo
ATMANAGER_LOG=${ATMANAGER_HOME}/log

tabs 4
CONSOLE_WIDTH=$(stty size | awk '{print $2}')

.    ${ATMANAGER_HOME}/bin/center.sh
.    ${ATMANAGER_HOME}/bin/display_logo.sh

declare -A ATMANAGER_USAGE=(
    [USAGE_TOOL]="__${ATMANAGER_TOOL}"
    [USAGE_ARG1]="[OP] start | stop | restart | start-security | version"
    [USAGE_EX_PRE]="# Restart Apache Tomcat Server"
    [USAGE_EX]="__${ATMANAGER_TOOL} restart"
)

declare -A ATMANAGER_LOGGING=(
    [LOG_TOOL]="${ATMANAGER_TOOL}"
    [LOG_FLAG]="info"
    [LOG_PATH]="${ATMANAGER_LOG}"
    [LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
    [BW]=50
    [MP]=100
    [SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief   Main function
# @param   Value required operation to be done
# @exitval Function __atmanger exit with integer value
#            0   - tool finished with success operation
#            128 - missing argument
#            129 - failed to load tool script configuration from files
#            130 - missing external tool tomcat
#            131 - wrong argument (operation)
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# local OP="start"
# __atmanager "$OP"
#
function __atmanager {
    local OP=$1
    display_logo
    if [ -n "${OP}" ]; then
        local FUNC=${FUNCNAME[0]} MSG="None"
        local STATUS_CONF STATUS_CONF_UTIL STATUS
        MSG="Loading basic and util configuration!"
        info_debug_message "$MSG" "$FUNC" "$ATMANAGER_TOOL"
        progress_bar PB_STRUCTURE
        declare -A config_atmanager=()
        load_conf "$ATMANAGER_CFG" config_atmanager
        STATUS_CONF=$?
        declare -A config_atmanager_util=()
        load_util_conf "$ATMANAGER_UTIL_CFG" config_atmanager_util
        STATUS_CONF_UTIL=$?
        declare -A STATUS_STRUCTURE=(
            [1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
        )
        check_status STATUS_STRUCTURE
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$ATMANAGER_TOOL"
            exit 129
        fi
        TOOL_DBG=${config_atmanager[DEBUGGING]}
        TOOL_LOG=${config_atmanager[LOGGING]}
        TOOL_NOTIFY=${config_atmanager[EMAILING]}
        local THOME=${config_atmanager_util[TOMCAT_HOME]} EL
        local CAT=${config_atmanager_util[TOMCAT_CATALINA]}
        local OPERATIONS=${config_atmanager_util[TOMCAT_OPERATIONS]}
        IFS=' ' read -ra OPS <<< "${OPERATIONS}"
        check_tool "${THOME}/bin/${CAT}"
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$ATMANAGER_TOOL"
            exit 130
        fi
        check_op "${OP}" "${OPS[*]}"
        STATUS=$?
        if [ $STATUS -eq $NOT_SUCCESS ]; then
            MSG="Force exit!"
            info_debug_message_end "$MSG" "$FUNC" "$ATMANAGER_TOOL"
            exit 131
        fi
        for EL in "${!OPS[@]}"
        do
            if [[ "${OPS[$EL]}" == "${OP}" ]]; then
                MSG="Operation: ${OP} Apache Tomcat Server"
                info_debug_message "$MSG" "$FUNC" "$ATMANAGER_TOOL"
                eval "$THOME/bin/./${CAT} ${OP}"
                ATMANAGER_LOGGING[LOG_MSGE]=$MSG
                ATMANAGER_LOGGING[LOG_FLAG]="info"
                logging ATMANAGER_LOGGING
            fi
            continue
        done
        info_debug_message "Done" "$FUNC" "$ATMANAGER_TOOL"
        exit 0
    fi
    usage ATMANAGER_USAGE
    exit 128
}

#
# @brief   Main entry point
# @param   Value required operation to be done
# @exitval Script tool atmanger exit with integer value
#            0   - tool finished with success operation
#            127 - run tool script as root user from cli
#            128 - missing argument
#            129 - failed to load tool script configuration from files
#            130 - missing external tool tomcat
#            131 - wrong argument (operation)
#
printf "\n%s\n%s\n\n" "${ATMANAGER_TOOL} ${ATMANAGER_VERSION}" "`date`"
check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
    __atmanager $1
fi

exit 127
