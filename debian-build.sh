#!/bin/bash

mkdir -p build

BASE=`pwd`
for FILE in `ls`; do
	if [[ -d ${BASE}/${FILE}/debian ]]; then
		if [[ -f ${BASE}/${FILE}/debian/changelog ]]; then
			cd ${BASE}/${FILE};
			debuild -us -uc
			debuild clean
			rm ${BASE}/*.{dsc,tar.xz,build,changes}
			mv ${BASE}/*.deb ${BASE}/build/
		else
			echo "Not debian ready: $FILE"
		fi
	fi
done

cd $BASE
$BASE/debian-repo.sh $1
