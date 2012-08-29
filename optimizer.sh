#!/bin/bash
#
# This script is intended to be a useful mode to save disk and optimize mysql
# databases.
#
# Function declarations
#
function main() {

  SIZE=$(du -hs /var/lib/mysql/$1/ | awk '{ print $1; }')

  echo "Compactación de la base de datos $1"
  echo
  echo "Espacio previo en disco: ${SIZE}"

  echo "Introduzca la contraseña de root para generar el listado de tablas a optimizar desde la base de datos $1"
  sql_prepare $1

  echo "Vuelva a introducir la contraseña de root para comenzar la compactación de la base de datos $1"
  mysql -u root -p $1 < ./optimize_$1.sql

  NEW_SIZE=$(du -hs /var/lib/mysql/$1/ | awk '{ print $1; }')

  echo
  echo "Espacio en disco tras la compactación: ${NEW_SIZE}"

}

function sql_prepare() {
  for i in $(echo "SHOW TABLES" | mysql -u root -p $1)
  do
    echo "OPTIMIZE TABLE $i;"
  done | sed '1 d' > optimize_$1.sql
}

function Usage() {

  let COUNT=0
  for i in $(find /var/lib/mysql -maxdepth 1 -type d -exec basename {} \;)
  do
    BDD[$COUNT]=$i
    ((COUNT++))
  done
  echo "Usage: $0 $( IFS="|" ; echo "${BDD[*]}" )"
  exit $?
}

# End of function declarations
#

if [ $# -lt 1 ]
  then Usage
fi

[ -d /var/lib/mysql/$1 ] || Usage

main $1
exit $?
