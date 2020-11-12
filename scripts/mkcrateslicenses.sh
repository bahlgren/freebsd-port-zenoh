#!/bin/sh
#
# script to create Makefile.crates_licenses

LICENSES="Apache-2.0:APACHE20 \
	BSD-2-Clause:BSD2CLAUSE \
	BSD-3-Clause:BSD3CLAUSE \
	BSL-1.0:BSL \
	CC0-1.0:CC0-1.0 \
	EPL-2.0:EPL \
	ISC:ISCL \
	MIT:MIT \
	MPL-2.0:MPL20 \
	Unlicense:UNLICENSE \
	Zlib:ZLIB"

TMP_CRATES_LIC=`mktemp -t crateslic` || exit 1
TMP_DISTFILES=`mktemp -t distfiles` || exit 1

trap "rm -f ${TMP_CRATES_LIC} ${TMP_DISTFILES}" EXIT

make configure > /dev/null
make cargo-crates-licenses > ${TMP_CRATES_LIC}

make -V DISTFILES | sed -e 's/ /\
/g' | sed -e 's/:.*//' > ${TMP_DISTFILES}


for l in ${LICENSES}; do
    crate_l=${l%:*}
    port_l=${l#*:}

    crates=`grep "${crate_l}" ${TMP_CRATES_LIC} | awk '{print $1}'`

    if [ -n "${crates}" ]; then
	echo "LICENSE+=	${port_l}"
	echo -n "LICENSE_DISTFILES_${port_l}+="

	for c in ${crates}; do
	    grep "${c}" ${TMP_DISTFILES} | awk '{printf " \\\n\t\t%s", $1}'
	done
	echo
	echo
    fi
done
