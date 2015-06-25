#!/bin/bash
#

# Settings
DROPBOX_HOME=/home/trunks/Dropbox/

# Private variables
TIMESTAMP=$(date +"%Y%m%d%H%M")
SCREENSHOT_FILE="screenshot-${TIMESTAMP}.png"

DROPBOX=$(which dropbox)
ZENITY=$(which zenity)
SCROT=$(which scrot)

function check() {

    if [ -z "${DROPBOX}" ]
    then
      echo -e "dropbox is not installed or in your path. Please, consider to install it in order to use this script"
      echo
    fi

    if [ -z "${ZENITY}" ]
    then
      echo -e "zenity is not installed or in your path. Please, consider to install it in order to use this script"
      echo
    fi

    if [ -z "${SCROT}" ]
    then
      echo -e "scrot is not installed or in your path. Please, consider to install it in order to use this script"
      echo
    fi

    DROPBOX_STATUS=$(${DROPBOX} status)
    if [ "${DROPBOX_STATUS}" == "Dropbox isn't running!" ]
    then
        ${ZENITY} --question --text="Dropbox must be running\n\nDo you want to launch it?"
        [ "$?" == "0" ] && ${DROPBOX} start
    fi
}

function do_screenshot() {

    ${ZENITY} --info --text="Select the area to capture.\n\nYou need to close this dialog before it."

    ${SCROT} -s -e 'mv $f /tmp/'${SCREENSHOT_FILE}
    mv /tmp/${SCREENSHOT_FILE} ${DROPBOX_HOME}/Public/

    ${ZENITY} --info --text="Wait for publishing the screenshot to dropbox" &
    ZENITYPID=$!

    while ([ "$(${DROPBOX} filestatus ${DROPBOX_HOME}/Public/${SCREENSHOT_FILE} | awk '{ print $2; }')" == "syncing" ])
        do sleep 1
    done

    PUBLIC_URL=$(${DROPBOX} puburl ${DROPBOX_HOME}/Public/${SCREENSHOT_FILE})

    kill -9 ${ZENITYPID}
    ${ZENITY} --info --text="Dropbox screenshot url: ${PUBLIC_URL}"
}

check
do_screenshot
