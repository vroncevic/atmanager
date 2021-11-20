#!/bin/bash
#
# @brief   Apache Tomcat Server Manager
# @version ver.2.0
# @date    Sat Nov 20 11:40:40 CET 2021
# @company None, free software to use 2021
# @author  Vladimir Roncevic <elektron.ronca@gmail.com>
#

#
# @brief  Display logo
# @param  Additional shifter - new tab which should be added
# @retval None
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# center 0
#
function center {
    local additional_shifter=$1
    local start_position=$((${CONSOLE_WIDTH} / 2 - 21))
    local number_of_tabs=$((
        ${start_position} / 4 - 1 + ${additional_shifter}
    ))
    local tab="$(printf '\011')"
    for ((i = 0; i <= ${number_of_tabs}; i++))
    do
        printf "${tab}"
    done
}