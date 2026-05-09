#! /usr/bin/env bash
#
# Run rchk tools on every package listed below (same list as install_packages_for_test.sh):
#   A) Generate outputs once (same idea as check_package.sh + archived copies)
#   B) Repeat analysis NUM_RUNS times per package; measure wall time and max RSS with /usr/bin/time
#
# Usage:
#   cd trunk
#   . ../scripts/config.inc
#   . ../scripts/cmpconfig.inc
#   ../test/benchmark.sh <test-name>
#
# CSV columns (semicolon-separated): run;pkg_name;tool;time;max_rss_kb
#   time        elapsed wall seconds (GNU time %e)
#   max_rss_kb  Maximum resident set size (GNU time %M)
#

TOOLS="errcheck symcheck sfpcheck csfpcheck maacheck bcheck ueacheck alloccheck glcheck veccheck cgcheck fficheck"
NUM_RUNS=10
PACKAGES=(
	magrittr tibble jsonlite glue curl purrr xfun utf8 htmltools
	data.table yaml processx mime openssl fansi lubridate colorspace
	ps zoo base64enc backports sys askpass rappdirs cachem bit bit64
	uuid commonmark xts
)

# TOOLS="fficheck symcheck"
# NUM_RUNS=3
# PACKAGES=(magrittr xts)

if [ X"$1" == X ] ; then
  echo "usage: $0 <test-name>" >&2
  exit 2
fi
TEST_NAME="$1"
shift 1

if [ ! -r $RCHK/scripts/config.inc ] ; then
  echo "Please set RCHK variables (scripts/config.inc)" >&2
  exit 2
fi

CSV_FILE="$RCHK/test/results/${TEST_NAME}.csv"
echo "run;pkg_name;tool;time;max_rss_kb" >"$CSV_FILE"

for PKG in "${PACKAGES[@]}"; do
  echo "=== [${TEST_NAME}] ${PKG} ==="
  $RCHK/test/check_package_et.sh $TEST_NAME $CSV_FILE $NUM_RUNS $PKG $TOOLS
done
