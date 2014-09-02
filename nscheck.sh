#!/bin/bash
#
# This script is intended to be a useful mode to check the health of your domain testing public dns servers.
#
# @version $Id$
# @author Javier Carranza <javier.carranza@crononauta.com>
# Copyright © 2014 Crononauta http://crononauta.com
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU Library General Public License as published
# by the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Library General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
# USA.
#
#
# Settings
#
# Declare your public dns servers for testing purposes
#
# Here you have a free and public dns server list provided by
# http://pcsupport.about.com/od/tipstricks/a/free-public-dns-servers.htm
# (Updated August 2014)
#
# Provider              Primary DNS Server      Secondary DNS Server
# Level3                209.244.0.3             209.244.0.4
# Google                8.8.8.8                 8.8.4.4
# Comodo Secure DNS     8.26.56.26              8.20.247.20
# OpenDNS Home          208.67.222.222          208.67.220.220
# DNS Advantage         156.154.70.1            156.154.71.1
# Norton ConnectSafe    199.85.126.10           199.85.127.10
# GreenTeamDNS          81.218.119.11           209.88.198.133
# SafeDNS               195.46.39.39            195.46.39.40
# OpenNIC               216.87.84.211           23.90.4.6
# Public-Root           199.5.157.131           208.71.35.137
# SmartViper            208.76.50.50            208.76.51.51
# Dyn                   216.146.35.35           216.146.36.36
# FreeDNS               37.235.1.174            37.235.1.177
# censurfridns.dk       89.233.43.71            89.104.194.142
# Hurricane Electric    74.82.42.42
# puntCAT               109.69.8.51

SERVERS="209.244.0.3 8.8.8.8 208.67.222.222 81.218.119.11 195.46.39.39 208.76.50.50 37.235.1.174 89.233.43.71 74.82.42.42"

# Function declarations
#

NSLOOKUP=$(which nslookup)
ECHO=$(which echo)
GREP=$(which grep)
WC=$(which wc)


function main() {

  $ECHO -n "Checking domain"
  read WARNINGS < <(nsChecks $1)
  TOTALNS=$(echo $SERVERS | $WC -w)
  $ECHO -e "Amount of failures: $WARNINGS / $TOTALNS"
}

function nsChecks() {

  for NSSERVER in $SERVERS
  do
    $NSLOOKUP $1 $NSSERVER | $GREP -v "$NSSERVER" | $GREP "^Address" &> /dev/null && $ECHO "OK" || $ECHO "WARNING"
    $ECHO -n "." 1>&2
  done | $GREP "WARNING" | $WC -l
  $ECHO 1>&2
}

function Usage() {

  $ECHO "Usage: $0 [domain-name]"
  exit $?
}

# End of function declarations
#

if [ $# -lt 1 ]
then
  Usage
fi

if [ -z "$NSLOOKUP" ]
then
  $ECHO -e "Broken dependencies: dig. Try with 'sudo apt-get install dig' before using this script if you are using a debian based linux distribution."
  exit 2
fi

main $1
exit $?
