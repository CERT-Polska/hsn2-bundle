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
	if [[ "$FILE" == "hsn2-razorback" ]]; then
		cd ${BASE}/${FILE};
		make nugget-commons
		make packages64
		mv *.deb $BASE/
	fi
	if [[ "$FILE" == "hsn2-thug" ]]; then
		cd ${BASE}/${FILE}/docker;
		debuild -us -uc
		debuild clean
		mv ../*.deb $BASE/
	fi
done

cd $BASE
$BASE/debian-repo.sh $1
