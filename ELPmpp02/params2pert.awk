# This takes the main params from the PARAMS.TXT file and
# converts them to Perterbation() constructor calls for use
# in MoonCalculator.swift
# Usage: awk -f params2pert.awk PARAMS.TXT
#
BEGIN {
  print("let mlonp = [")
  currentSection = 1
}
END {
  print("]")
}

/^M/  {
  if ($2 != currentSection) {
    print("]")
    if ($2 == 2) print("let mlatp = [")
    if ($2 == 3) print("let mdistp = [")
    currentSection = $2
  }
  printf("    Perturbation(x: %12.5f, y:[ %10.5f,  %12.5f,  %10.2e ]),\n",
    $4, $5, $6, $7)
}
