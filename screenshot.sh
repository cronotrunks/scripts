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
}

function do_screenshot() {

    ${SCROT} -s -e 'mv $f /tmp/'${SCREENSHOT_FILE}
    mv /tmp/${SCREENSHOT_FILE} ${DROPBOX_HOME}/Public/

    while ([ "$(${DROPBOX} filestatus ${DROPBOX_HOME}/Public/${SCREENSHOT_FILE} | awk '{ print $2; }')" == "syncing" ])
        do sleep 1
    done

    PUBLIC_URL=$(${DROPBOX} puburl ${DROPBOX_HOME}/Public/${SCREENSHOT_FILE})

    ${ZENITY} --info --text="Dropbox screenshot url: ${PUBLIC_URL}"
}

check
do_screenshot
