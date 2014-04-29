#!/bin/bash

CONF=/etc/sysAssembler/sysAssembler.conf

# first of all, read the main config file
if [ -f ${CONF} ]
then
	source ${CONF}
else
	printf "Konfiguration \"%s\" nicht gefunden" ${CONF}
	exit 1
fi

if [ -f ${LIBDIR}/messages ]
then
	source ${LIBDIR}/messages
else
	printf "Bibliothek \"%s\" nicht gefunden" ${LIBDIR}/messages
	exit 1
fi

test -d $LOGDIR || mkdir -p $LOGDIR

exec 10>&1 
exec >$infoLog 
exec 20>&2 
exec 2> $errLog

if [ -f ${LOCKFILE} ]
then
	infoMsg "${PROG} wurde bereits ausgeführt!"
	exit $(raiseError 255)
fi

infoMsg "${PROG} gestartet: beginne reassembling"

for mod in ${MODDIR}/*
do
	. ${mod}
done

touch ${LOCKFILE}

raiseError 0
