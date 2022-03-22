#!/usr/bin/env bash

# declare -a variable (array)
# declare -A variable (associated array)
# declare -i variable (intger)
# declare -r variable (read only)
# declare -x variable (export)

# declare -i
a=5; a+=2; echo "$a"; unset a # 52
a=5; let a+=2; echo "$a"; unset a # 7
declare -i a=5; a+=2; echo "$a"; unset a # 7
a=5+2; echo "$a"; unset a # 5+2
declare -i a=5+2; echo "$a"; unset a # 7

# Not used in practise

# Parameter Expansion (PE)
file="$HOME/.secrets/007"; \
  echo "File location: $file"; \
  # Pattern beginning, longest match deleted
  echo "Filename: ${file##*/}"; \
  # Pattern end, longest match deleted
  echo "Directory of file: ${file%/*}"; \
  #  Replace secrets by not_secret during expansion
  echo "Non-secret file: ${file/secrets/not_secret}"; \
  echo; \
  echo "Other file location: ${other:-There is no other file}"; \
  echo "Using file if there is no other file: ${other:=$file}"; \
  echo "Other filename: ${other##*/}"; \
  echo "Other file location length: ${#other}"

echo
version=1.5.9; echo "MAJOR: ${version%%.*}, MINOR: ${version#*.}."
# MAJOR: 1, MINOR: 5.9.
version=1.5.9; echo "MAJOR: ${version%.*}, MINOR: ${version##*.}."
# MAJOR: 1.5, MINOR: 9.
echo "Dash: ${version/./-}, Dashes: ${version//./-}."
# Dash: 1-5.9, Dashes: 1-5-9.
