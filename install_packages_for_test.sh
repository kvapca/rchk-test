#!/usr/bin/env bash
# Install CRAN packages listed in packages_for_test.md (same order as the table).

# prerequisites:
# cd trunk
# . ../scripts/config.inc

PACKAGES=(
	magrittr tibble jsonlite glue curl purrr xfun utf8 htmltools
	data.table yaml processx mime openssl fansi lubridate colorspace
	ps zoo base64enc backports sys askpass rappdirs cachem bit bit64
	uuid commonmark xts
)

if [ ! -r $RCHK/scripts/config.inc ] ; then
  echo "Please set RCHK variables (scripts/config.inc)" >&2
  exit 2
fi

. $RCHK/scripts/cmpconfig.inc

for PACKAGE_NAME in "${PACKAGES[@]}"; do
	echo "install.packages(\"${PACKAGE_NAME}\", repos='http://cloud.r-project.org')" | ./bin/R --no-echo
done
