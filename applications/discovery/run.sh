#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
BIN="$ROOT/.lake/build/applications/discovery/discovery_lean"
if [ ! -x "$BIN" ]; then
 python3 "$ROOT/tools/build_discovery.py"
fi
exec "$BIN" "$@"
