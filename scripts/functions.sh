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

# CHECK IF ROOT ###############################################################

# Check if the current user is root

pi_check_root() {
    if [ $(id -u) -ne 0 ]
    then
        echo "Script must be run as root.'\n"
        exit 1
    fi
}

# INSTALL *ONE* PACKAGE (GIVEN IN ARGS) #######################################

# TODO: install several packages...

PI_PKG_CMD_UPDATE="apt-get update"
PI_PKG_CMD_INSTALL="apt-get -y install"

pi_install() {
    PI_PKG_NAME=$1

    if [ "$(dpkg -l | grep ${PI_PKG_NAME} | head -c2)" = "ii" ]
    then
        echo "INFO: ${PI_PKG_NAME} is already installed"
    else
        echo "Installing ${PI_PKG_NAME}"
        ${PI_PKG_CMD_UPDATE}
        ${PI_PKG_CMD_INSTALL} console-data
    fi
}
