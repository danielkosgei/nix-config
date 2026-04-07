#!/usr/bin/env sh

file="$1"
w="${2:-80}"
h="${3:-24}"
x="${4:-0}"
y="${5:-0}"

mime="$(file -Lb --mime-type -- "$file" 2>/dev/null)"

preview_image() {
kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$1" >/dev/tty 2>/dev/null
}

case "$mime" in
image/*)
    preview_image "$file"
    exit 1
    ;;
  application/pdf)
    tmp="/tmp/lf-preview-$$.png"
    pdftoppm -f 1 -singlefile -png "$file" "/tmp/lf-preview-$$" >/dev/null 2>&1
    if [ -f "$tmp" ]; then
      preview_image "$tmp"
      rm -f "$tmp"
      exit 1
    fi
    ;;
  video/*)
    tmp="/tmp/lf-video-$$.jpg"
    ffmpegthumbnailer -i "$file" -o "$tmp" -s 0 >/dev/null 2>&1
    if [ -f "$tmp" ]; then
      preview_image "$tmp"
      rm -f "$tmp"
      exit 1
    fi
    mediainfo "$file" 2>/dev/null | sed -n '1,120p'
    exit 1
    ;;
  audio/*)
    mediainfo "$file" 2>/dev/null | sed -n '1,120p'
    exit 1
    ;;
  application/zip|application/x-7z-compressed|application/x-rar|application/x-tar|application/gzip|application/x-bzip2|application/zstd)
    atool -l "$file" 2>/dev/null | sed -n '1,200p'
    exit 1
    ;;
  text/*|application/json|application/javascript|application/xml|application/x-sh)
    bat --style=plain --color=always --line-range=:300 "$file" 2>/dev/null || pistol "$file"
    exit 1
    ;;
  inode/directory)
    tree -a -L 2 "$file" 2>/dev/null | sed -n '1,200p'
    exit 1
    ;;
esac

pistol "$file" 2>/dev/null | sed -n '1,200p'
exit 1



