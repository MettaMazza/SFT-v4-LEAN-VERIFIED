Receipt-bound Fold chess recreation in Lean 4.35.0

Source: MettaMazza/SFT-v3 d0b1996c09fd0b27be5a6016324f83ed578c5c94.
All 45 original EP functions are mapped in SOURCE_CORRESPONDENCE.json.
Original match configuration and records are retained under verification/APPLICATION_CHESS1595 and reference/applications/chess-winning-d0b1996.

Build from repository root:
  python3 tools/build_fold_chess.py
Run:
  printf '2\n853\n3364\n926\n8888\n' | sh applications/fold_chess/run.sh
Expected Fool's Mate response: 3807 (Qd8-h4).
Protocol: first decimal integer is depth ceiling; subsequent integers are encoded moves; 8888 requests one move. The original harness closes standard input on each request. Tables are the exact files at the winning revision; their location is relocated from the original author's absolute Desktop path to the bundled reference directory.

Preserved winning measurement: Stockfish UCI_LimitStrength=True, UCI_Elo=1900, 0.05 seconds per opponent move, 12 games alternating colours, bot ceiling12, budget4194304, maximum240 plies, claim_draw=True, timeout900 seconds per bot call. Original receipt:6wins/3draws/3losses,62.5percent score. That is the historical original-engine result; it is not a claim of a newly played Lean match.
