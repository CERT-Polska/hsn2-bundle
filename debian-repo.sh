#!/bin/bash

BASE=`pwd`

if [[ -z "$1" ]]; then
        echo "No repo specified so ending now"
        exit
else
        REPO="$1"
fi

rm ${REPO}/db/*

cd ${REPO}

for DEB in `ls ${BASE}/build/*.deb`; do
        reprepro includedeb experimental $DEB
done

