# Set of scripts used to obtain and compare rchk results during my bachelors thesis

## Usage

### Extracting Results
Create llvm14 results (doesn't have cache yet):
```sh
RCHK_NO_CACHE=1 ../test/check_r_extract.sh llvm14 errcheck symcheck sfpcheck csfpcheck maacheck bcheck ueacheck alloccheck glcheck veccheck cgcheck fficheck
```

Create llvm22 results (doesn't have cache yet):
```sh
RCHK_NO_CACHE=1 ../test/check_r_extract.sh llvm22 errcheck symcheck sfpcheck csfpcheck maacheck bcheck ueacheck alloccheck glcheck veccheck cgcheck fficheck
```

Create llvm22-cache results (with cache):
```sh
../test/check_r_extract.sh llvm22 errcheck symcheck sfpcheck csfpcheck maacheck bcheck ueacheck alloccheck glcheck veccheck cgcheck fficheck
```

### Timing
Create llvm22 results (doesn't have cache yet):
```sh
RCHK_NO_CACHE=1 ../test/check_r_timed.sh errcheck symcheck sfpcheck csfpcheck maacheck bcheck ueacheck alloccheck glcheck veccheck cgcheck fficheck
```

Create llvm22-cache results (with cache):
```sh
../test/check_r_timed.sh errcheck symcheck sfpcheck csfpcheck maacheck bcheck ueacheck alloccheck glcheck veccheck cgcheck fficheck
```
