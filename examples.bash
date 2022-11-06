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

######################################################################
# Remove the IPs in my blocklist file, from my logfile

declare -A bad  # associative array
while IFS=: read -r ip _; do
  bad["$ip"]=1
done < blocklist

unset tmp
trap '[[ $tmp ]] && rm -f "$tmp"' EXIT # captures the EXIT signal and removes the temporal file.
tmp=$(mktemp) || exit # creates a temporal file.

while read -r ip rest; do
  [[ ${bad["$ip"]} ]] && continue
  printf '%s %s\n' "$ip" "$rest"
done < logfile > "$tmp"

mv "$tmp" logfile

######################################################################
# Find duplicate files in a directory hierarchy

# Usage: finddups [directory]
declare -A seen # associative array
while read -r -d '' md5 file; do
  if [[ ${seen["$md5"]} ]]; then
    printf 'Matching MD5: "%s" and "%s"\n' "${seen["$md5"]}" "$file"
  fi
  seen["$md5"]=$file
done < <(find "${1:-.}" -type f -exec md5sum -z {} +)
