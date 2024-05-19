#!/bin/bash

read -p "Введите текст: " TEXT

WORDS=($TEXT)

shuffle() {
  local i j tmp
  for ((i = ${#WORDS[@]} - 1; i > 0; i--)); do
    j=$((RANDOM % (i + 1)))
    tmp="${WORDS[$i]}"
    WORDS[$i]="${WORDS[$j]}"
    WORDS[$j]="$tmp"
  done
}

shuffle

for word in "${WORDS[@]}"; do
  echo -n "$word "
done
echo
