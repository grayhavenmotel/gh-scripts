#!/bin/bash
#
# $ brew install lame
#
# To use the script, just save it somewhere like ~/bin/flac2mp3 and make it executable with chmod +x ~/bin/flac2mp3.
# This would convert all flac files in your Music folder:
# $ find ~/Music/ -name '*.flac' -exec ~/bin/flac2mp3 {} \;
# Or slightly faster, since it only calls flac2mp3 once:
# $ find ~/Music/ -name '*.flac' -print0 | xargs -0 ~/bin/flac2mp3

for f in "$@"; do
    [[ "$f" != *.flac ]] && continue
    album="$(metaflac --show-tag=album "$f" | sed 's/[^=]*=//')"
    artist="$(metaflac --show-tag=artist "$f" | sed 's/[^=]*=//')"
    date="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    title="$(metaflac --show-tag=title "$f" | sed 's/[^=]*=//')"
    year="$(metaflac --show-tag=date "$f" | sed 's/[^=]*=//')"
    genre="$(metaflac --show-tag=genre "$f" | sed 's/[^=]*=//')"
    tracknumber="$(metaflac --show-tag=tracknumber "$f" | sed 's/[^=]*=//')"

    flac --decode --stdout "$f" | lame --preset extreme --add-id3v2 --tt "$title" --ta "$artist" --tl "$album" --ty "$year" --tn "$tracknumber" --tg "$genre" - "${f%.flac}.mp3"
done