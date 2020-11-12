cat $1 \
| sed -E -e 's/^[ [:digit:]]{5}//' \
  -e 's/([[:digit:]])-/\1 -/g' \
  -e 's/D(.[0-9]+)/e\1 /g' \
  -e 's/0+e/0e/g' \
  -e 's/e\+00//g' \
| awk -f pert2csv.awk
