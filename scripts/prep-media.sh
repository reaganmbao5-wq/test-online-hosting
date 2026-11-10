#!/usr/bin/env bash
# Prepare media for Raylight upload_media.
#   Video -> H.264/AAC MP4, max 1920px wide, faststart.
#   Image -> max 2560px on the long edge, EXIF orientation applied.
#   Audio -> 48 kHz AAC in .m4a.
# Usage: scripts/prep-media.sh <input> [output_dir]   (default output: renders/)
set -euo pipefail

in="${1:?usage: prep-media.sh <input> [output_dir]}"
out_dir="${2:-renders}"
mkdir -p "$out_dir"
base="$(basename "${in%.*}")"
ext="$(printf '%s' "${in##*.}" | tr '[:upper:]' '[:lower:]')"

case "$ext" in
  mp4|mov|m4v|mkv|webm|avi)
    out="$out_dir/$base.mp4"
    ffmpeg -hide_banner -y -i "$in" \
      -vf "scale='min(1920,iw)':-2" -c:v libx264 -preset medium -crf 20 \
      -pix_fmt yuv420p -c:a aac -b:a 192k -movflags +faststart "$out"
    ;;
  jpg|jpeg|png|webp|heic|tif|tiff)
    out="$out_dir/$base.${ext/jpeg/jpg}"
    [[ "$ext" == heic || "$ext" == tif || "$ext" == tiff ]] && out="$out_dir/$base.jpg"
    convert "$in" -auto-orient -resize '2560x2560>' -strip "$out"
    ;;
  wav|mp3|aac|m4a|flac|ogg)
    out="$out_dir/$base.m4a"
    ffmpeg -hide_banner -y -i "$in" -vn -ar 48000 -c:a aac -b:a 192k "$out"
    ;;
  *)
    echo "Unsupported file type: .$ext" >&2; exit 1 ;;
esac

echo "Wrote $out"
ffprobe -v error -show_entries format=duration,size -of default=nw=1 "$out" || true
