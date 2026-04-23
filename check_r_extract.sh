#! /bin/bash

# runs rchk tools on R and package included in the R distribution
# to be run from R source directory, after the bitcode files have been created (e.g. using build_r.sh)
#
# usage: bash $RCHK/test/check_r_extract.sh <test-name> [tool1 tool2 ...]
# if no tools are provided, defaults to: bcheck maacheck
# results are stored under: $RCHK/test/results/<test-name>/<tool>/

if [ X"$1" == X ] ; then
  echo "usage: $0 -t <test-name> [tool1 tool2 ...]" >&2
  exit 2
fi
TEST_NAME="$1"
shift 1

if [ X"$*" == X ] ; then
  TOOLS="bcheck maacheck"
else
  TOOLS="$*"
fi

if [ ! -r $RCHK/scripts/config.inc ] ; then
  echo "Please set RCHK variables (scripts/config.inc)" >&2
  exit 2
fi

for T in $TOOLS ; do
  if [ ! -x $RCHK/src/$T ] ; then
    echo "Please set RCHK variables (scripts/config.inc) and RCHK installation - cannot find tool $T." >&2
    exit 2
  fi
done

. $RCHK/scripts/common.inc

if ! check_config ; then
  exit 2
fi

if [ ! -r ./src/main/R.bin.bc ] ; then
  echo "This script has to be run from the root of R source directory with bitcode files (e.g. src/main/R.bin.bc)." >&2
  exit 2
fi

RBC=./src/main/R.bin.bc

# setup result folder

RESULT_FOLDER="$RCHK/test/results/$TEST_NAME"
mkdir -p "$RESULT_FOLDER"

# clean previously generated results

bash $RCHK/test/clean_tool_files.sh $TOOLS

# ensure cache

if [ -n "$RCHK_NO_CACHE" ] ; then
  CACHE_ARGS=""
else
  CACHE_FILE="$RBC".cache
  . $RCHK/scripts/ensure_cache.sh "$RBC" "$CACHE_FILE"
  if [ $? -ne 0 ] ; then
    echo "Cache generation failed. Aborting." >&2
    exit 2
  fi
  CACHE_ARGS="--cache $CACHE_FILE"
fi

# run the tools

for T in $TOOLS ; do
  mkdir -p "$RESULT_FOLDER/$T"

  echo -e "Running $T on R.bin.bc"
  $RCHK/src/$T $CACHE_ARGS $RBC >./src/main/R.bin.$T 2>&1
  cp ./src/main/R.bin.$T "$RESULT_FOLDER/$T/R.bin.$T"
  
  find . -name "*.bc" | grep -v R.bin.bc | grep -v '\.o\.bc' | grep -v '\.svn' | grep -v '^./packages' | while read F ; do
    FOUT=`echo $F | sed -e 's/\.bc$/.'$T'/g'`

    echo -e "Running $T on $F"
    $RCHK/src/$T $CACHE_ARGS $RBC $F >$FOUT 2>&1
    cp $FOUT "$RESULT_FOLDER/$T/$(basename "$FOUT")"
  done
done
