#! /bin/bash

# deletes check files of rchk tools on R and package included in the R distribution
# to be run from R source directory
#

# tools to run can be specified as arguments

if [ X"$*" == X ] ; then
  TOOLS="bcheck maacheck"
else
  TOOLS="$*"
fi

if [ ! -r ./src/main/R.bin.bc ] ; then
  echo "This script has to be run from the root of R source directory with bitcode files (e.g. src/main/R.bin.bc)." >&2
  exit 2
fi

for T in $TOOLS ; do
  rm -f ./src/main/R.bin.$T
  find . -name "*.bc" | grep -v R.bin.bc | grep -v '\.o\.bc' | grep -v '\.svn' | grep -v '^./packages' | while read F ; do
    FOUT=`echo $F | sed -e 's/\.bc$/.'$T'/g'`
    rm -f $FOUT
  done
done
