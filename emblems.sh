#!/bin/bash
#
# Copyright (C) 2003, 2005-2007 Free Software Foundation, Inc.
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
# Este script nos servirá tanto para añadir emblemas a un fichero o directorio
#  como para eliminarlos. El modelo de uso del script es el siguiente:
#
#  ./emblems.sh ruta_del_fichero emblema1 emblema2 emblema3
#
# Podremos asignar tantos emblemas como deseemos a un fichero. En caso de querer
#  eliminarlos todos, simplemente tendremos que proporcionar la ruta del fichero
#  o directorio al script, sin argumentos.
#
# Algunos de los emblemas posibles que podemos utilizar son: default, OK,
#  important, favorite, downloads, ohno, readonly, ...
#

if [ $# -lt 1 ] || [ ! -e "$1" ]
then echo -e "Usage: $0 filepath [emblem1] [emblem2] [...]"
exit
fi

FILE=$1
shift

if [ $# -eq 0 ]
then gvfs-set-attribute $FILE -t stringv metadata::emblems ""
else gvfs-set-attribute $FILE -t stringv metadata::emblems $@
fi
