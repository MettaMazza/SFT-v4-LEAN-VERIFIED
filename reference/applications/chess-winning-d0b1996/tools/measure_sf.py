"""12 games vs SF at a given Elo (argv[1], default 1700), ALL IN PARALLEL."""
import subprocess, sys, chess, chess.engine
ELO = int(sys.argv[1]) if len(sys.argv) > 1 else 1700
from concurrent.futures import ProcessPoolExecutor

import shutil, tempfile, atexit
_pin = tempfile.NamedTemporaryFile(delete=False, suffix="_fold_bot")
_pin.close()
shutil.copy2("/Users/mettamazza/Desktop/Smithian Fold Theory/tests/fold_bot_cli", _pin.name)
import os as _os; _os.chmod(_pin.name, 0o755)
atexit.register(lambda: _os.unlink(_pin.name))
BOT = _pin.name  # PINNED copy: rebuilding the live binary cannot contaminate a running match
SF = "/opt/homebrew/bin/stockfish"
PROMO = {chess.QUEEN:5, chess.ROOK:4, chess.BISHOP:3, chess.KNIGHT:2}
CP = {v:k for k,v in PROMO.items()}
def enc(m): return (PROMO[m.promotion] if m.promotion else 0)*4096 + m.from_square*64 + m.to_square
def dec(v):
    p,r = v//4096, v%4096
    return chess.Move(r//64, r%64, promotion=CP[p] if p else None)
def bot_move(depth, hist):
    feed = "\n".join([str(depth)]+[str(m) for m in hist]+["8888"])+"\n"
    return int(subprocess.run([BOT], input=feed, capture_output=True, text=True, timeout=900).stdout.strip().splitlines()[-1])

def play_one(g):
    bot_white = g % 2 == 0
    eng = chess.engine.SimpleEngine.popen_uci(SF)
    eng.configure({"UCI_LimitStrength": True, "UCI_Elo": ELO})
    board = chess.Board(); hist = []
    while not board.is_game_over(claim_draw=True) and len(hist) < 240:
        if (board.turn == chess.WHITE) == bot_white:
            mv = dec(bot_move(12, hist))
            if mv not in board.legal_moves:
                eng.quit(); return (g, "ILLEGAL")
            board.push(mv); hist.append(enc(mv))
        else:
            r = eng.play(board, chess.engine.Limit(time=0.05))
            board.push(r.move); hist.append(enc(r.move))
    eng.quit()
    o = board.outcome(claim_draw=True)
    if o is None: return (g, "draw(cap)")
    if o.winner is None: return (g, "draw")
    return (g, "win" if (o.winner == chess.WHITE) == bot_white else "loss")

if __name__ == "__main__":
    tally = {}
    with ProcessPoolExecutor(max_workers=12) as pool:
        for g, r in pool.map(play_one, range(12)):
            tally[r] = tally.get(r, 0) + 1
            print(f"game {g+1} ({'White' if g%2==0 else 'Black'}): {r}", flush=True)
    print(f"MEASUREMENT {ELO} (12 games):", tally)
