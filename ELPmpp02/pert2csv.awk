BEGIN {
  RS = "\r\n"
  OFS = ", "
}
/PERT/ {
  exponent = $4
}
NF == 18 {
  print exponent, $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11,
    $12, $13, $14, $15, $16, $17, $18
}
