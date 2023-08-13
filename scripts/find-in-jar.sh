#!/usr/bin/env bash

find "$1" -name "*.jar" -print0 | while IFS= read -r -d '' file; do
    matches=$(jar tvf "$file" | grep "$2")
    if [ ! -z "$matches" ]; then
        echo "$file"
        echo "$matches"
    fi
done

