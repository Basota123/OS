#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Использование: $0 <расширение_файла>"
    exit 1
fi

extension=$1

for file in *.$extension; do
    rm "$file"
done
