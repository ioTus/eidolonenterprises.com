#!/bin/sh
# Build the static site: assemble dist/ from src/.
#
# Each file under src/pages/ starts with a small header
#   title: ...
#   description: ...
#   ---
# followed by the page body. The build wraps the body in
# src/partials/head.html and src/partials/foot.html, substituting
# {{TITLE}} and {{DESCRIPTION}}, and copies css/ and fonts/ as-is.
set -eu

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/src"
DIST="$ROOT/dist"

rm -rf "$DIST"
mkdir -p "$DIST"
cp -R "$SRC/css" "$DIST/css"
cp -R "$SRC/fonts" "$DIST/fonts"

find "$SRC/pages" -type f -name '*.html' | while read -r page; do
  rel="${page#"$SRC/pages/"}"
  out="$DIST/$rel"
  mkdir -p "$(dirname "$out")"

  title="$(sed -n 's/^title: //p' "$page" | head -n 1)"
  desc="$(sed -n 's/^description: //p' "$page" | head -n 1)"

  {
    sed -e "s|{{TITLE}}|$title|" -e "s|{{DESCRIPTION}}|$desc|" "$SRC/partials/head.html"
    sed '1,/^---$/d' "$page"
    cat "$SRC/partials/foot.html"
  } > "$out"
  echo "built $rel"
done
