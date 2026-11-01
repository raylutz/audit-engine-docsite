#!/usr/bin/env bash
# Print selected pages of the built site to PDF.
#
# Readers often need a guide as a file they can attach to an email.
# Each page listed below is printed from site/ into site/pdf/.
# The theme's print styles hide the menus, so the PDF reads like a document.
#
# Run it after mkdocs build. Set CHROME to the browser binary if it is not google-chrome.

set -euo pipefail

pages=(
    user-guide/sending_data
    user-guide/dom_exporting_guide
    user-guide/ess_exporting_guide
    user-guide/hart_exporting_guide
)
chrome="${CHROME:-google-chrome}"
port=8765

# ---- serve the built site locally
mkdir -p site/pdf
python3 -m http.server "$port" --directory site >/dev/null 2>&1 &
server_pid=$!
trap 'kill "$server_pid"' EXIT
sleep 1

# ---- print each page, and stop on a missing page
for page in "${pages[@]}"; do
    url="http://localhost:$port/$page/"
    out="site/pdf/$(basename "$page").pdf"
    curl -sf -o /dev/null "$url" || { echo "missing page: $page" >&2; exit 1; }
    "$chrome" --headless --no-sandbox --disable-gpu --no-pdf-header-footer \
              --virtual-time-budget=10000 --print-to-pdf="$out" "$url" 2>/dev/null
    echo "$out $(stat -c %s "$out") bytes"
done
