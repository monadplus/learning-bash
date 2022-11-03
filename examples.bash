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
