#!/usr/bin/env bash
set -euo pipefail
# Input: PDF verified from official source; output preserves physical page boundaries.
# Run locally in the cloud ingestion environment, never inside the browser.
if [ "$#" -ne 1 ]; then echo 'Usage: extract-pdf.sh verified-edition.pdf' >&2; exit 2; fi
pdfinfo "$1" | grep '^Pages:'
pdftotext -raw "$1" /tmp/diario-extracted.txt
python - <<'PY'
import json
from pathlib import Path
p=Path('/tmp/diario-extracted.txt').read_text().split('\f')
if not p[-1].strip(): p.pop()
Path('worker/pages.json').write_text(json.dumps(p,ensure_ascii=False))
print(f'Extracted {len(p)} pages. Verify edition date before publication.')
PY
