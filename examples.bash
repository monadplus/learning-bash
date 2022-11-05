#!/bin/env bash

set -eu

######################################################################
# Read numbers from stdin

IFS=' ' read -r -p "Number of inputs: " n

numbers=()
for ((i = 0; i < n; i++)); do
  read -p 'Input a digit: ' m
  case "$m" in
    [[:digit:]]*) 
      numbers+=("$m")
    ;;
  *) 
    echo 'Not a digit! Try again' 
    ((i--))
    ;;
  esac
done
echo "${numbers[@]}"

######################################################################
# TODO: it somehow matches multiple lines

found=0
while IFS= read -r aline; do
  r=$(rg --line-number 'FAQ' || " " <<<"$aline")
  if [[ -n "$r" ]]; then 
    found=1
    line=$(rg '([0-9]*).*' --replace '$1'<<<"$r")
    break
  fi
done < README.md

if ((found)); then
  echo "Found at line: $line"
else
  echo 'Not found!'
fi
