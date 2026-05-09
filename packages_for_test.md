# Packages for rchk testing
- Popular CRAN downloads
- Not built-in
- Native C only (no C++/Fortran in src/)
- Versions are current CRAN (09 May 2026)

| Rank | Package | Downloads (cumulative) | CRAN version |
|-----:|---------|----------------------:|--------------|
| 3 | magrittr | 154,712,132 | 2.0.5 |
| 7 | tibble | 125,230,087 | 3.3.1 |
| 9 | jsonlite | 119,691,516 | 2.0.0 |
| 11 | glue | 116,564,033 | 1.8.1 |
| 26 | curl | 88,572,308 | 7.1.0 |
| 27 | purrr | 86,010,950 | 1.2.2 |
| 28 | xfun | 84,393,942 | 0.57 |
| 30 | utf8 | 82,867,741 | 1.2.6 |
| 31 | htmltools | 82,677,904 | 0.5.9 |
| 36 | data.table | 76,993,989 | 1.18.4 |
| 37 | yaml | 76,834,582 | 2.3.12 |
| 42 | processx | 73,245,084 | 3.9.0 |
| 43 | mime | 72,827,141 | 0.13 |
| 44 | openssl | 72,472,832 | 2.4.0 |
| 45 | fansi | 72,080,534 | 1.0.7 |
| 49 | lubridate | 70,540,821 | 1.9.5 |
| 55 | colorspace | 68,144,182 | 2.1-2 |
| 57 | ps | 66,299,084 | 1.9.3 |
| 58 | zoo | 66,067,651 | 1.8-15 |
| 61 | base64enc | 63,455,141 | 0.1-6 |
| 67 | backports | 59,079,007 | 1.5.1 |
| 76 | sys | 52,360,007 | 3.4.3 |
| 86 | askpass | 49,624,803 | 1.2.1 |
| 89 | rappdirs | 48,112,642 | 0.3.4 |
| 102 | cachem | 45,393,401 | 1.1.0 |
| 110 | bit | 42,828,531 | 4.6.0 |
| 117 | bit64 | 40,721,832 | 4.8.0 |
| 130 | uuid | 35,520,512 | 1.2-2 |
| 136 | commonmark | 33,594,930 | 2.0.0 |
| 137 | xts | 33,418,290 | 0.14.2 |

Install packages:
```sh
cd trunk
../test/install_packages_for_test.sh
```

Run rchk tools on installed packages:
```sh
cd trunk
. ../scripts/config.inc
. ../scripts/cmpconfig.inc
../scripts/check_package.sh PACKAGE_NAME
```
