#!/bin/sh
set -eu
root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
exec "$root/.lake/build/applications/fold_chess/fold_chess_lean" "$root/reference/applications/chess-winning-d0b1996/data"
