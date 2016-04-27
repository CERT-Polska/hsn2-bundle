#!/bin/bash

mkdir -p build

BASE=`pwd`
cd ${BASE}/hsn2-commons-java;
mvn clean install -U -Pbundle -Dmaven.test.skip

cd $BASE
for FILE in `ls`; do
	if [[ -d ${BASE}/${FILE}/debian ]]; then
		if [[ -f ${BASE}/${FILE}/debian/changelog ]]; then
			cd ${BASE}/${FILE};
			debuild -us -uc
			debuild clean
			rm ${BASE}/*.{dsc,tar.*,build,changes}
			mv ${BASE}/*.deb ${BASE}/build/
		else
			echo "Not debian ready: $FILE"
		fi
	fi
	if [[ "$FILE" == "hsn2-razorback" ]]; then
		cd ${BASE}/${FILE};
		make nugget-commons
		make packages64
		rm *.{dsc,tar.*,build,changes}
		mv *.deb $BASE/build/
	fi
	if [[ "$FILE" == "hsn2-thug" ]]; then
		cd ${BASE}/${FILE}/docker;
		debuild -us -uc
		debuild clean
		rm ../*.{dsc,tar.*,build,changes}
		mv ../*.deb $BASE/build/
	fi
done

cd $BASE
$BASE/debian-repo.sh $1
