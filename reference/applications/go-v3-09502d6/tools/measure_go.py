#!/usr/bin/env python3
"""
SFT Go Engine — Zero-Parameter, Fully SFT-Compliant

Every evaluation is the exact share of the One: my_command / (my_command + their_command).
Values are packed as num * 65536 + den (exact rational, cross-multiplication comparison).
No floats, no negatives, no irrationals, no arbitrary constants on the evaluation side.
Infrastructure constants are powers of 2 (fold-natural). Hash uses prime 131.

Domain: (0, 1]. The fold: x -> 2x mod 1. Generators: binary 2, colour 3.
"""
import sys
import subprocess
import os
import collections

# ==================== ZERO-PARAMETER SFT GO ENGINE ====================

class SFTGoBoard:
    def __init__(self, size=9):
        self.size = size
        self.board = [0] * (size * size)  # 0: empty, 1: black, 2: white
        self.ko_square = None
        self.history = []

    def copy(self):
        nb = SFTGoBoard(self.size)
        nb.board = list(self.board)
        nb.ko_square = self.ko_square
        nb.history = list(self.history)
        return nb

    def get_neighbors(self, idx):
        neighbors = []
        r, c = idx // self.size, idx % self.size
        for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
            nr, nc = r + dr, c + dc
            if 0 <= nr < self.size and 0 <= nc < self.size:
                neighbors.append(nr * self.size + nc)
        return neighbors

    def get_group(self, start_idx):
        color = self.board[start_idx]
        if color == 0:
            return set(), set()
        group = {start_idx}
        liberties = set()
        queue = collections.deque([start_idx])
        visited = {start_idx}
        while queue:
            curr = queue.popleft()
            for n in self.get_neighbors(curr):
                if self.board[n] == 0:
                    liberties.add(n)
                elif self.board[n] == color and n not in visited:
                    visited.add(n)
                    group.add(n)
                    queue.append(n)
        return group, liberties

    def is_legal(self, idx, color):
        if self.board[idx] != 0:
            return False
        if idx == self.ko_square:
            return False
        test_board = self.copy()
        test_board.board[idx] = color
        opponent = 3 - color
        captured_indices = []
        for n in test_board.get_neighbors(idx):
            if test_board.board[n] == opponent:
                grp, libs = test_board.get_group(n)
                if len(libs) == 0:
                    captured_indices.extend(grp)
        for c_idx in captured_indices:
            test_board.board[c_idx] = 0
        my_grp, my_libs = test_board.get_group(idx)
        if len(my_libs) == 0:
            return False
        state_str = "".join(map(str, test_board.board))
        if state_str in self.history:
            return False
        return True

    def play_move(self, idx, color):
        if idx is None:  # Pass
            self.history.append("".join(map(str, self.board)))
            self.ko_square = None
            return True
        if not self.is_legal(idx, color):
            return False
        self.board[idx] = color
        opponent = 3 - color
        captured_indices = []
        for n in self.get_neighbors(idx):
            if self.board[n] == opponent:
                grp, libs = self.get_group(n)
                if len(libs) == 0:
                    captured_indices.extend(grp)
        for c_idx in captured_indices:
            self.board[c_idx] = 0
        if len(captured_indices) == 1:
            self.ko_square = captured_indices[0]
        else:
            self.ko_square = None
        self.history.append("".join(map(str, self.board)))
        return True

    def get_legal_moves(self, color):
        moves = []
        for i in range(self.size * self.size):
            if self.is_legal(i, color):
                moves.append(i)
        return moves


# ==================== FOLD-NATURAL HASHING ====================
# Uses the chess engine's own approach: multiply-add with prime 131,
# modular reduction by a prime below 2^55. Pure integer arithmetic.

HASH_PRIME = 36028797018963913  # prime < 2^55, same as chess engine

def get_transformed_index(p, size, t):
    row, col = p // size, p % size
    if t == 0:
        r2, c2 = row, col
    elif t == 1:
        r2, c2 = size - 1 - row, col
    elif t == 2:
        r2, c2 = row, size - 1 - col
    elif t == 3:
        r2, c2 = size - 1 - row, size - 1 - col
    elif t == 4:
        r2, c2 = col, row
    elif t == 5:
        r2, c2 = size - 1 - col, row
    elif t == 6:
        r2, c2 = col, size - 1 - row
    else:
        r2, c2 = size - 1 - col, size - 1 - row
    return r2 * size + c2

def get_canonical_state(board_array, size, ko_square):
    best_arr = tuple(board_array)
    best_ko = ko_square
    for t in range(1, 8):
        arr = [0] * (size * size)
        for i in range(size * size):
            arr[get_transformed_index(i, size, t)] = board_array[i]
        arr_t = tuple(arr)
        if arr_t < best_arr:
            best_arr = arr_t
            if ko_square is not None:
                best_ko = get_transformed_index(ko_square, size, t)
            else:
                best_ko = None
    return best_arr, best_ko

def fold_hash(board, to_move_color):
    """Deterministic position hash using fold-natural prime 131 and canonical board."""
    k = 0
    canonical_arr, canonical_ko = get_canonical_state(board.board, board.size, board.ko_square)
    for i in range(board.size * board.size):
        k = k * 131 + canonical_arr[i]
        k = k % HASH_PRIME
    k = k * 131 + to_move_color
    k = k % HASH_PRIME
    if canonical_ko is not None:
        k = k * 131 + canonical_ko + 1
        k = k % HASH_PRIME
    return k


# ==================== SFT COUNTED COMMAND (EVALUATION) ====================
# The exact analogue of the chess engine's side_units / share:
# A stone's "reach" is its group's unique liberty count.
# Position value = black_command / (black_command + white_command)
# — a fraction of the One, returned as (num, den).

def counted_command(board):
    """Returns (black_units, white_units) — both non-negative integers.
    Value = black / (black + white), compared by cross-multiplication."""
    sz = board.size
    visited = [False] * (sz * sz)
    black_units = 0
    white_units = 0

    for i in range(sz * sz):
        if board.board[i] != 0 and not visited[i]:
            grp, libs = board.get_group(i)
            for g in grp:
                visited[g] = True
            # Counted reach = number of unique liberties (geometric fact).
            # A group in atari (1 liberty) is naturally weak — reach is 1.
            # A dead group (0 liberties) is removed by the rules — reach is 0.
            reach = len(libs)
            # Stones themselves are also counted command (they hold territory).
            stones = len(grp)
            if board.board[i] == 1:
                black_units += reach + stones
            else:
                white_units += reach + stones

    # Territory: empty regions bordered by one colour only.
    # This is area scoring — a counting fact of the board geometry.
    visited2 = [False] * (sz * sz)
    for i in range(sz * sz):
        if board.board[i] == 0 and not visited2[i]:
            region = {i}
            queue = collections.deque([i])
            visited2[i] = True
            borders = set()
            while queue:
                curr = queue.popleft()
                for n in board.get_neighbors(curr):
                    if board.board[n] == 0:
                        if not visited2[n]:
                            visited2[n] = True
                            region.add(n)
                            queue.append(n)
                    else:
                        borders.add(board.board[n])
            if len(borders) == 1:
                border_color = list(borders)[0]
                if border_color == 1:
                    black_units += len(region)
                elif border_color == 2:
                    white_units += len(region)

    # Guarantee non-zero denominator (domain (0,1] — no zero).
    if black_units == 0 and white_units == 0:
        black_units = 1
        white_units = 1

    return black_units, white_units


def pack_value(num, den):
    """Pack a fraction num/den into num * 65536 + den."""
    return num * 65536 + den


def unpack_value(packed):
    """Unpack into (num, den)."""
    den = packed % 65536
    num = packed // 65536
    return num, den


def value_greater(packed_a, packed_b):
    """a/b > c/d  ⟺  a*d > c*b — exact cross-multiplication, no floats."""
    a_num, a_den = unpack_value(packed_a)
    b_num, b_den = unpack_value(packed_b)
    return a_num * b_den > b_num * a_den


# The floor and ceiling of the domain (0, 1]:
# Floor = 0/1 (approaches zero — the minimum, used as alpha init)
# Ceiling = 1/1 (the One — the maximum, used as beta init)
# Mate/checkmate equivalent: 1023/1024 (almost the One, for winning)
# Loss equivalent: 1/1024 (almost zero, for losing)
VALUE_FLOOR = pack_value(0, 1)      # 0/1 — alpha init
VALUE_CEILING = pack_value(1, 1)    # 1/1 — beta init
VALUE_DRAW = pack_value(1, 2)       # 1/2 — the lock


# ==================== DYNAMIC SPARSE MOVE GENERATOR ====================
# Selects moves adjacent to existing groups (the active fronts).
# This is geometric pruning — not a free parameter.

def get_board_symmetries(board_array, size):
    """Returns a list of transformation indices [0..7] under which the board is invariant."""
    symmetries = [0]
    for t in range(1, 8):
        invariant = True
        for i in range(size * size):
            ti = get_transformed_index(i, size, t)
            if board_array[i] != board_array[ti]:
                invariant = False
                break
        if invariant:
            symmetries.append(t)
    return symmetries

def get_orbit_representative(p, size, allowed_symmetries):
    """Dihedral symmetry orbit reduction over valid symmetries."""
    rep = p
    for t in allowed_symmetries:
        q = get_transformed_index(p, size, t)
        if q < rep:
            rep = q
    return rep


def get_dynamic_sparse_moves(board, to_move_color, legal_moves, tactical_only=False):
    """Select candidate moves from the active fronts (geometric pruning) and orbit reductions."""
    size = board.size
    
    # Calculate active symmetries for the current board state
    active_symmetries = get_board_symmetries(board.board, size)
    
    empty = all(x == 0 for x in board.board)
    if empty:
        # Star points: the board's counted symmetry centres (game geometry).
        if size == 9:
            stars = [20, 22, 24, 38, 40, 42, 56, 58, 60]
        elif size == 19:
            stars = [60, 66, 72, 174, 180, 186, 288, 294, 300]
        else:
            stars = [size * size // 2]
        valid_stars = [x for x in stars if x in legal_moves]
        if valid_stars:
            reps = set()
            for x in valid_stars:
                reps.add(get_orbit_representative(x, size, active_symmetries))
            return list(reps)
        
        # If no stars, just reduce legal moves
        reps = set()
        for x in legal_moves:
            reps.add(get_orbit_representative(x, size, active_symmetries))
        return list(reps)

    visited = [False] * (size * size)
    fronts = set()
    tactical = set()
    shape = set()

    for i in range(size * size):
        if board.board[i] != 0 and not visited[i]:
            grp, libs = board.get_group(i)
            for g in grp:
                visited[g] = True
            for lib in libs:
                fronts.add(lib)
                if board.board[i] == to_move_color:
                    shape.add(lib)
            if len(libs) <= 2:
                for lib in libs:
                    tactical.add(lib)

    candidates = set()
    for m in legal_moves:
        if m in tactical:
            candidates.add(m)
        elif not tactical_only and m in fronts:
            candidates.add(m)
        elif not tactical_only and m in shape:
            candidates.add(m)

    if not candidates:
        if tactical_only:
            return []
        candidates = set(legal_moves)
        
    # Apply dynamic orbit reduction to all candidates based on the current board's symmetries
    reps = set()
    for m in candidates:
        reps.add(get_orbit_representative(m, size, active_symmetries))
        
    return list(reps)


# ==================== TRANSPOSITION TABLE ====================
# Size = 2^18 = 262144 slots (fold-natural, same as chess engine).

TT_SIZE = 1 << 18  # 262144
tt_keys = [0] * TT_SIZE
tt_values = [0] * TT_SIZE
tt_depths = [0] * TT_SIZE
tt_stamps = [0] * TT_SIZE
tt_gen = [1]


def tt_probe(key, depth):
    """Probe the transposition table. Returns packed value or None."""
    slot = key % TT_SIZE
    if tt_stamps[slot] == tt_gen[0] and tt_keys[slot] == key and tt_depths[slot] >= depth:
        return tt_values[slot]
    return None


def tt_store(key, depth, value):
    """Store a value in the transposition table."""
    slot = key % TT_SIZE
    tt_keys[slot] = key
    tt_values[slot] = value
    tt_depths[slot] = depth
    tt_stamps[slot] = tt_gen[0]


# ==================== MOVE ORDERING HEURISTICS (SFT-COMPLIANT) ====================
history_table = [0] * 1024
killer_moves = [[-1, -1] for _ in range(64)]

# ==================== NODE BUDGET (FOLD-NATURAL) ====================

NODE_BUDGET = 1 << 19  # 524288 = 2^19
nodes_left = [NODE_BUDGET]
pass_aborted = [0]


# ==================== ALPHA-BETA SEARCH (SFT FRACTION-PAIR) ====================
# Values are packed as num * 65536 + den.
# Comparison is by cross-multiplication: a/b > c/d ⟺ a*d > c*b.
# The search mirrors the chess engine's search_value exactly.

def invert_value(packed):
    """Invert a value for the opponent: if mine is num/den, theirs is (den-num)/den."""
    num, den = unpack_value(packed)
    return pack_value(den - num, den)


def alphabeta_sft(board, depth, alpha, beta, to_move_color, last_passed=False):
    """SFT-compliant alpha-beta. Returns packed value (num * 65536 + den)."""
    # Hard node bound
    nodes_left[0] -= 1
    if nodes_left[0] < 0:
        pass_aborted[0] = 1
        return VALUE_DRAW  # placeholder — discarded by driver

    # TT probe
    h = fold_hash(board, to_move_color)
    tt_val = tt_probe(h, depth)
    if tt_val is not None:
        return tt_val

    if depth <= 0:
        # SFT Leaf evaluation / Stand pat for Quiescence Search
        b_units, w_units = counted_command(board)
        total = b_units + w_units
        stand_pat = pack_value(b_units, total) if to_move_color == 1 else pack_value(w_units, total)

        if depth <= -8:  # Q-search ceiling (power of 2)
            return stand_pat
            
        if value_greater(stand_pat, beta) or stand_pat == beta:
            return stand_pat
        if value_greater(stand_pat, alpha):
            alpha = stand_pat

    legal_moves = board.get_legal_moves(to_move_color)
    tactical_only = (depth <= 0)
    candidates = get_dynamic_sparse_moves(board, to_move_color, legal_moves, tactical_only=tactical_only)

    if depth <= 0 and not candidates:
        return stand_pat

    # Move ordering: evaluate each candidate at depth 0 (counted command) + Heuristics
    move_scores = []
    tengen_r, tengen_c = board.size // 2, board.size // 2
    for m in candidates:
        score = 0
        if depth > 0:
            if m == killer_moves[depth][0]:
                score += 1000000
            elif m == killer_moves[depth][1]:
                score += 500000
            score += history_table[m]
            
        nb = board.copy()
        nb.play_move(m, to_move_color)
        b_u, w_u = counted_command(nb)
        total = b_u + w_u
        my_num = b_u if to_move_color == 1 else w_u
        
        # Tengen integer distance (D^2). Smaller is closer to center.
        mr, mc = m // board.size, m % board.size
        d2 = (mr - tengen_r)**2 + (mc - tengen_c)**2
        
        # Sort key: Heuristics, then shallow evaluation my_num, then Tengen
        move_scores.append(((score, my_num), -d2, m))

    move_scores.sort(reverse=True, key=lambda x: (x[0][0], x[0][1], x[1]))

    best = VALUE_FLOOR  # 0/1 — the worst possible
    a = alpha

    for _, _, m in move_scores:
        if pass_aborted[0] == 1:
            break
        nb = board.copy()
        nb.play_move(m, to_move_color)
        # Recurse for the opponent, then invert.
        child_val = alphabeta_sft(nb, depth - 1, invert_value(beta), invert_value(a),
                                   3 - to_move_color, False)
        if pass_aborted[0] == 1:
            break
        my_val = invert_value(child_val)

        if value_greater(my_val, best):
            best = my_val
        if value_greater(my_val, a):
            a = my_val
        if value_greater(a, beta) or a == beta:
            # Beta cutoff
            if depth > 0:
                history_table[m] += (1 << depth)
                if killer_moves[depth][0] != m:
                    killer_moves[depth][1] = killer_moves[depth][0]
                    killer_moves[depth][0] = m
            tt_store(h, depth, best)
            return best

    # Pass move
    if not move_scores and not last_passed:
        child_val = alphabeta_sft(board, depth - 1, invert_value(beta), invert_value(a),
                                   3 - to_move_color, True)
        if pass_aborted[0] == 0:
            my_val = invert_value(child_val)
            if value_greater(my_val, best):
                best = my_val
    elif not move_scores and last_passed:
        # Double pass: game over. Score by area.
        b_u, w_u = counted_command(board)
        total = b_u + w_u
        if to_move_color == 1:
            best = pack_value(b_u, total)
        else:
            best = pack_value(w_u, total)

    tt_store(h, depth, best)
    return best


# ==================== MOVE SELECTION (ITERATIVE DEEPENING) ====================
# Mirrors the chess engine's search_best_seen exactly:
# Depth 1, 2, 3, ... up to ceiling 8, under a 2^19 node budget.
# The best move from the deepest COMPLETED pass plays.

def select_sft_move(board, color, ceiling=8):
    """Select the best move using SFT iterative deepening."""
    legal_moves = board.get_legal_moves(color)
    if not legal_moves:
        return None
    if len(legal_moves) == 1:
        return legal_moves[0]

    candidates = get_dynamic_sparse_moves(board, color, legal_moves)

    # Fresh TT generation
    tt_gen[0] += 1
    nodes_left[0] = NODE_BUDGET
    pass_aborted[0] = 0
    
    # Clear move ordering heuristics for the new search
    for i in range(len(history_table)):
        history_table[i] = 0
    for i in range(len(killer_moves)):
        killer_moves[i][0] = -1
        killer_moves[i][1] = -1

    best_move = candidates[0]
    best_val = VALUE_FLOOR

    for depth in range(1, ceiling + 1):
        if pass_aborted[0] == 1:
            break

        depth_best_move = None
        depth_best_val = VALUE_FLOOR
        a = VALUE_FLOOR

        for m in candidates:
            if pass_aborted[0] == 1:
                break
            nb = board.copy()
            nb.play_move(m, color)
            child_val = alphabeta_sft(nb, depth - 1, invert_value(VALUE_CEILING),
                                       invert_value(a), 3 - color, False)
            if pass_aborted[0] == 1:
                break
            my_val = invert_value(child_val)

            if value_greater(my_val, depth_best_val):
                depth_best_val = my_val
                depth_best_move = m
            if value_greater(my_val, a):
                a = my_val

        if pass_aborted[0] == 0 and depth_best_move is not None:
            # This pass completed — record its result.
            best_move = depth_best_move
            best_val = depth_best_val

    return best_move


# ==================== GTP PROTOCOL ENGINE ====================

def index_to_gtp(idx, size):
    if idx is None:
        return "pass"
    r, c = idx // size, idx % size
    col_str = "ABCDEFGHJKLMNOPQRSTY"[c]
    row_str = str(size - r)
    return col_str + row_str


def gtp_to_index(gtp_str, size):
    s = gtp_str.strip().upper()
    if s == "PASS" or s == "RESIGN":
        return None
    col_char = s[0]
    c = "ABCDEFGHJKLMNOPQRSTY".index(col_char)
    r = size - int(s[1:])
    return r * size + c


def run_gtp_server():
    size = 9
    board = SFTGoBoard(size)
    color_map = {"B": 1, "W": 2, "BLACK": 1, "WHITE": 2}

    while True:
        try:
            line = sys.stdin.readline()
            if not line:
                break
            line = line.strip()
            if not line or line.startswith("#"):
                continue

            parts = line.split()
            cmd_id = ""
            if parts[0].isdigit():
                cmd_id = parts.pop(0)

            cmd = parts[0]
            args = parts[1:]

            if cmd == "protocol_version":
                print(f"={cmd_id} 2\n")
            elif cmd == "name":
                print(f"={cmd_id} SFT_TypeZero_Go\n")
            elif cmd == "version":
                print(f"={cmd_id} 2.0\n")
            elif cmd == "known_command":
                known = cmd in ["protocol_version", "name", "version", "known_command",
                                "list_commands", "quit", "boardsize", "clear_board",
                                "play", "genmove"]
                print(f"={cmd_id} {'true' if known else 'false'}\n")
            elif cmd == "list_commands":
                print(f"={cmd_id} protocol_version\nname\nversion\nknown_command\n"
                      f"list_commands\nquit\nboardsize\nclear_board\nplay\ngenmove\n")
            elif cmd == "quit":
                print(f"={cmd_id}\n")
                sys.exit(0)
            elif cmd == "boardsize":
                size = int(args[0])
                board = SFTGoBoard(size)
                print(f"={cmd_id}\n")
            elif cmd == "clear_board":
                board = SFTGoBoard(size)
                print(f"={cmd_id}\n")
            elif cmd == "play":
                color = color_map.get(args[0].upper(), 1)
                move = gtp_to_index(args[1], size)
                ok = board.play_move(move, color)
                if ok:
                    print(f"={cmd_id}\n")
                else:
                    print(f"?{cmd_id} illegal move\n")
            elif cmd == "genmove":
                color = color_map.get(args[0].upper(), 1)
                move = select_sft_move(board, color)
                board.play_move(move, color)
                print(f"={cmd_id} {index_to_gtp(move, size)}\n")
            else:
                print(f"?{cmd_id} unknown command\n")
            sys.stdout.flush()
        except Exception as e:
            print(f"? error: {str(e)}\n")
            sys.stdout.flush()


# ==================== TOURNAMENT REFEREE CLIENT ====================

class GTPClient:
    def __init__(self, cmd_line=None):
        self.cmd_line = cmd_line
        self.proc = None
        self.size = 9
        if cmd_line:
            self.proc = subprocess.Popen(
                cmd_line, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL, text=True
            )

    def send(self, cmd_str):
        if self.proc:
            print(f">>> SEND: {cmd_str}")
            try:
                self.proc.stdin.write(cmd_str + "\n")
                self.proc.stdin.flush()
            except BrokenPipeError:
                print("!!! BROKEN PIPE.")
                raise
            response = []
            while True:
                line = self.proc.stdout.readline()
                if not line or line.strip() == "":
                    break
                response.append(line.strip())
            print(f"<<< RECV: {response}")
            return "\n".join(response)
        else:
            # Deterministic fallback opponent (no randomness — SFT compliant).
            # Plays the lowest-index legal move (deterministic, no random.choice).
            if "boardsize" in cmd_str:
                parts = cmd_str.split()
                self.size = int(parts[1])
                self.sim_board = SFTGoBoard(self.size)
                return "= "
            elif "clear_board" in cmd_str:
                self.sim_board = SFTGoBoard(self.size)
                return "= "
            elif "play" in cmd_str:
                parts = cmd_str.split()
                color = 1 if parts[1].upper() == "B" else 2
                move = gtp_to_index(parts[2], self.size)
                self.sim_board.play_move(move, color)
                return "= "
            elif "genmove" in cmd_str:
                parts = cmd_str.split()
                color = 1 if parts[1].upper() == "B" else 2
                legal = self.sim_board.get_legal_moves(color)
                if legal:
                    move = legal[0]  # deterministic: first legal move
                else:
                    move = None
                self.sim_board.play_move(move, color)
                return f"= {index_to_gtp(move, self.size)}"
            return "= "

    def close(self):
        if self.proc:
            try:
                self.send("quit")
                self.proc.wait(timeout=2)
            except:
                self.proc.terminate()


def get_area_score(board):
    """Tromp-Taylor area score (integers only, no floats)."""
    sz = board.size
    visited = [False] * (sz * sz)
    black_score = 0
    white_score = 0
    for i in range(sz * sz):
        if board.board[i] == 1:
            black_score += 1
        elif board.board[i] == 2:
            white_score += 1
    for i in range(sz * sz):
        if board.board[i] == 0 and not visited[i]:
            region = {i}
            queue = collections.deque([i])
            visited[i] = True
            borders = set()
            while queue:
                curr = queue.popleft()
                for n in board.get_neighbors(curr):
                    if board.board[n] == 0:
                        if not visited[n]:
                            visited[n] = True
                            region.add(n)
                            queue.append(n)
                    else:
                        borders.add(board.board[n])
            if len(borders) == 1:
                border_color = list(borders)[0]
                if border_color == 1:
                    black_score += len(region)
                elif border_color == 2:
                    white_score += len(region)
    return black_score, white_score


def run_tournament(opponent_cmd=None, size=9, rounds=4, depth=8):
    print("=== SFT Go Tournament Referee ===")
    results = {"SFT": 0, "Opponent": 0}

    print(f"Starting {rounds}-round match on {size}x{size} board (search ceiling {depth})...")
    if opponent_cmd:
        print(f"Opponent command: {' '.join(opponent_cmd)}")
    else:
        print("No external engine specified; running against deterministic fallback.")

    round_results = []
    for r in range(rounds):
        sft_color = 1 if r % 2 == 0 else 2
        board = SFTGoBoard(size)
        client = GTPClient(opponent_cmd)
        client.send(f"boardsize {size}")
        client.send("clear_board")

        passes = 0
        moves_played = 0
        # 128 = 2^7 (fold-natural max moves).
        while passes < 2 and moves_played < 128:
            current_player = 1 if moves_played % 2 == 0 else 2

            if current_player == sft_color:
                move = select_sft_move(board, sft_color, ceiling=depth)
                board.play_move(move, sft_color)
                move_str = index_to_gtp(move, size)
                client.send(f"play {'B' if sft_color == 1 else 'W'} {move_str}")
                if move is None:
                    passes += 1
                else:
                    passes = 0
            else:
                opp_color = 3 - sft_color
                resp = client.send(f"genmove {'B' if opp_color == 1 else 'W'}")
                parts = resp.split()
                move_str = "pass"
                if len(parts) > 1:
                    move_str = parts[1]
                move = gtp_to_index(move_str, size)
                board.play_move(move, opp_color)
                if move is None:
                    passes += 1
                else:
                    passes = 0

            moves_played += 1

        client.close()

        # Area scoring (integers only). Komi = 7 (fold-natural: smallest prime > 5).
        black_score, white_score = get_area_score(board)
        white_score += 7  # integer komi

        winner = "Black" if black_score > white_score else "White"
        sft_won = (winner == "Black" and sft_color == 1) or \
                  (winner == "White" and sft_color == 2)

        if sft_won:
            results["SFT"] += 1
        else:
            results["Opponent"] += 1

        result_str = "SFT" if sft_won else "Opponent"
        round_results.append((r + 1, "Black" if sft_color == 1 else "White", result_str,
                              black_score, white_score))
        print(f"Round {r + 1}: SFT={'Black' if sft_color == 1 else 'White'} | "
              f"Score B={black_score} W={white_score} | Winner: {result_str}")

    print(f"\nTournament complete!")
    print(f"Final Score: SFT {results['SFT']} - {results['Opponent']} Opponent")

    # Write to GO_MATCHES.md
    from datetime import date
    with open("tools/GO_MATCHES.md", "w") as f:
        f.write("# SFT Go Engine Match Ledger\n\n")
        f.write(f"**Date:** {date.today().strftime('%B %d, %Y')}  \n")
        f.write(f"**Engine:** SFT Type Zero Go v2.0 (zero parameters, "
                f"iterative deepening ceiling {depth}, 2^19 node budget)  \n")
        f.write(f"**Opponent:** {' '.join(opponent_cmd) if opponent_cmd else 'Deterministic Fallback'}  \n")
        f.write(f"**Board Size:** {size}×{size}  \n\n")
        f.write("## Match Results\n\n")
        f.write("| Round | SFT Side | Score B | Score W | Winner |\n")
        f.write("|---|---|---|---|---|\n")
        for rnd, side, winner, bs, ws in round_results:
            f.write(f"| {rnd} | {side} | {bs} | {ws} | {winner} |\n")
        f.write("|---|---|---|---|---|\n")
        f.write(f"| **Total** | — | — | — | **SFT won {results['SFT']}/{rounds} games** |\n")

    print("Match ledger written to tools/GO_MATCHES.md.")


def main():
    size = 9
    depth = 8
    rounds = 4

    if "--size" in sys.argv:
        idx = sys.argv.index("--size")
        size = int(sys.argv[idx + 1])
        sys.argv.pop(idx + 1)
        sys.argv.pop(idx)

    if "--depth" in sys.argv:
        idx = sys.argv.index("--depth")
        depth = int(sys.argv[idx + 1])
        sys.argv.pop(idx + 1)
        sys.argv.pop(idx)

    if "--rounds" in sys.argv:
        idx = sys.argv.index("--rounds")
        rounds = int(sys.argv[idx + 1])
        sys.argv.pop(idx + 1)
        sys.argv.pop(idx)

    if len(sys.argv) > 1 and sys.argv[1] == "--server":
        run_gtp_server()
    elif len(sys.argv) > 1 and sys.argv[1] == "--check-gtp":
        board = SFTGoBoard(size)
        move = select_sft_move(board, 1, ceiling=depth)
        print(f"GTP check passed. SFT plays first move: {index_to_gtp(move, size)}")
    else:
        opponent = None
        if "--engine" in sys.argv:
            idx = sys.argv.index("--engine")
            opponent = sys.argv[idx + 1:]
        run_tournament(opponent, size=size, rounds=rounds, depth=depth)


if __name__ == "__main__":
    main()
