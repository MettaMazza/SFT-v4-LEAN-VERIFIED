#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
BIN="$ROOT/.lake/build/applications/discovery/discovery_v2_lean"
if [ ! -x "$BIN" ]; then python3 "$ROOT/tools/build_discovery_v2.py"; fi
exec "$BIN" "$ROOT/reference/applications/discovery-SFT-v2" "$@"
