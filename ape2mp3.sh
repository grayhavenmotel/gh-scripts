#!/bin/bash

find "$1" -type f -name "*.ape" -print0 | while read -d $'\0' song

do
    output=${song%.ape}.mp3
    cue=${song%.ape}.cue
    avconv -i "$song" -b 192k "$output"
    if ls "$cue" &> /dev/null; then
        mp3splt -a -c "$cue" "$output"
        rm "$output"
    else
        echo "no need to split"
    fi
done