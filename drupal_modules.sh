#!/bin/bash
#
# This script is intended to be a useful mode to locate which projects have an specific enabled module
#
# Function declarations
#

function main() {

  cd /var/lib/mysql

  for i in *
    do STATUS=$(echo "SELECT status FROM system WHERE name='$1';" | mysql -u root --password=PASSWORD $i | tail -n 1)
    if [ "$STATUS" -eq 1 ]
      then echo $i
    fi
  done 2> /dev/null

  cd - > /dev/null
}

function Usage() {

  echo "Usage: $0 modulename"
  exit $?
}

# End of function declarations
#

if [ $# -lt 1 ]
  then Usage
fi

main $1
exit $?
