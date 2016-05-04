#!/bin/bash

BASE=`pwd`

if [[ -z "$1" ]]; then
	echo "No repo specified so ending now"
	exit
else
	REPO="$1"
fi

if [[ -z `which reprepro` ]]; then
	echo "reprepro is not installed so ending now"
	exit
fi

CONF_DISTR="Origin: Honeyspider Network 2\n\
Label: Honeyspider Network 2\n\
Codename: experimental\n\
Architectures: i386 amd64\n\
Components: main\n\
Description: Apt repository for Honeyspider Network project"

if [ ! -f "${REPO}/conf/distributions" ]; then
	echo "Using default configuration..."
	if [ ! -d "${REPO}/conf" ]; then
		mkdir -p "${REPO}/conf"
	fi

	echo -e $CONF_DISTR > "${REPO}/conf/distributions"
fi

rm -f ${REPO}/db/*

cd ${REPO}

for DEB in `ls ${BASE}/build/*.deb`; do
	reprepro includedeb experimental $DEB
done
