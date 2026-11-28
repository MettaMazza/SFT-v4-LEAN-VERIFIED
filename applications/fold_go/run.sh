#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
BIN="$ROOT/.lake/build/applications/fold_go/fold_go_lean"
if [ ! -x "$BIN" ]; then
  python3 "$ROOT/tools/build_fold_go.py"
fi
cd "$ROOT"
exec "$BIN" "$@"
