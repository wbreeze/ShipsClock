BEGIN {
  RS = "\r\n"
  OFS = ", "
}
# function abs(a) { return a < 0 ? -a : a }
# NF == 11 && 4.0 < (abs($5) + 0) { }
NF == 11 {
  print "MainTerms(" $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11 "),"
}
