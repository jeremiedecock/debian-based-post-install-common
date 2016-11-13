#!/bin/bash

# The MIT License
#
# Copyright (c) 2014,2015,2016 Jérémie DECOCK <jd.jdhp@gmail.com>
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

# Setup keyboard, locale and timezone.
# See raspi-config source code on Raspbian.

# IMPORT COMMON FUNCTIONS

. scripts/functions.sh

# SETUP TIMEZONE ##############################################################

dpkg-reconfigure tzdata 

# SETUP LOCALES ###############################################################

# See https://www.debian.org/doc/manuals/fr/debian-fr-howto/ch3.html
#     http://www.raspbian.org/HexxehImages

#apt-get install locales
dpkg-reconfigure locales

# SETUP KEYBOARD ##############################################################

# See https://wiki.debian.org/fr/Keyboard
#     http://raspberrypi.stackexchange.com/questions/236/simple-keyboard-configuration
#     http://www.raspbian.org/HexxehImages

#pi_install console-setup
#pi_install keyboard-configuration

# INSTALL CONSOLE-DATA IF NEEDED

# console-data exists on Raspbian but doesn't exist on Debian 8
pi_install console-data

# SETUP KEYBOARD

dpkg-reconfigure console-data
dpkg-reconfigure keyboard-configuration

#service keyboard-setup restart     # https://wiki.debian.org/fr/Keyboard
invoke-rc.d keyboard-setup start   # http://raspberrypi.stackexchange.com/questions/236/simple-keyboard-configuration

# REBOOT THE SYSTEM (REQUIRED ON RASPBIAN) ####################################

reboot
