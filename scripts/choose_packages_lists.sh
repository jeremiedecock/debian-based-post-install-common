#!/bin/bash

# WARNING: this file only runs with Bash!

# The MIT License
# 
# Copyright (c) 2014,2015 Jérémie DECOCK <jd.jdhp@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

######

# This script display curses like interface to select a set of packages list to
# install or remove (among those available in the $BASEDIR).

######

# If you are presenting a very long menu and want to make best use of the
# available screen, you can calculate the best box size by.
#   eval `resize`
#   whiptail ... $LINES $COLUMNS $(( $LINES - 8 )) ...

######

if [ $# -ne 3 ]; then
    echo "Error: wrong number of options" >&2
    exit 1
fi

TITLE="$1"
SUB_TITLE="$2"
DIRBASE="$3"

######

# The array of files name to display in the GUI.
LABELS_ARRAY=()

# Define the status (enabled or not) of the corresponding files in
# LABELS_ARRAY.
STATUS_ARRAY=()

# Fill the LABELS_ARRAY and STATUS_ARRAY for the given DIRBASE.
for FILENAME in ${DIRBASE}/*.txt
do
    BASE_FILENAME=$(basename $FILENAME)

    LABELS_ARRAY+=("${BASE_FILENAME}")

    if [ ${BASE_FILENAME} = "default.txt" ]
    then
        STATUS_ARRAY+=(ON)
    else
        STATUS_ARRAY+=(OFF)
    fi
done

######

# Check the length of LABELS_ARRAY and STATUS_ARRAY.
if [ ${#LABELS_ARRAY[@]} -ne ${#STATUS_ARRAY[@]} ]
then
    echo "Internal error, LABELS_ARRAY and STATUS_ARRAY don't have the same length." >&2
    exit 1
fi

######

WHIPTAIL_CMD="whiptail --title \"${TITLE}\" --checklist "
WHIPTAIL_CMD+="\"${SUB_TITLE}\" 20 78 11 "

FIRST_INDEX=0
LAST_INDEX=$(( ${#LABELS_ARRAY[@]} - 1 ))

for INDEX in $(seq ${FIRST_INDEX} ${LAST_INDEX})
do
    PRINT_INDEX=$(( $INDEX + 1 ))
    WHIPTAIL_CMD+="\"$PRINT_INDEX\" \"${LABELS_ARRAY[$INDEX]}\" ${STATUS_ARRAY[$INDEX]} "
done

WHIPTAIL_CMD+="3>&1 1>&2 2>&3 "

### DEBUG ###
#echo "${WHIPTAIL_CMD}" >&2
#eval ${WHIPTAIL_CMD}

CHOICE=$(eval ${WHIPTAIL_CMD})

#CHOICE=$(whiptail --title "Check list example" --checklist \
#                          "Choose user's permissions" 20 78 4 \
#                          "NET_OUTBOUND" "Allow connections to other hosts" ON \
#                          "NET_INBOUND" "Allow connections from other hosts" OFF \
#                          "LOCAL_MOUNT" "Allow mounting of local devices" OFF \
#                          "REMOTE_MOUNT" "Allow mounting of remote devices" OFF 3>&1 1>&2 2>&3)

#echo "CHOICE: $CHOICE" >&2

for INDEX_STR in ${CHOICE[@]}
do
    INDEX=$(echo ${INDEX_STR} | sed 's/[^0-9]*//g')
    INDEX=$(( ${INDEX} - 1 ))
    echo -n "${LABELS_ARRAY[$INDEX]} "
done

