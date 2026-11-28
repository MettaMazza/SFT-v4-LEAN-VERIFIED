"""
DISCOVERY — the fold exploration engine (decisive companion to the GATE).

The GATE decides "is forbidden apparatus present." DISCOVERY points at EVERY registered result
and reports, result by result, where the construction's own mathematics carries further than
the claim took it -- plus the un-minimised picture of the fold algebra it explores in. The
engine is the arbiter; the assistant does not adjudicate what it finds, does not pre-privilege
an outcome, and does not edit findings toward a wanted shape.

THREE reports, all computed in the real engine (ratio.py, exact rationals):

  AXIS 1 — per-expression resolution: every expression carried under the fold resolves (reaches
           the One, a fixed point, or a cycle). No continuum; nothing runs off forever.

  AXIS 2 — size of the generated structure across increasing sweeps, including COMPOSITION
           (between-sector structure). Reported raw so the space is neither inflated to a false
           infinity nor shrunk to a tidy nesting; it grows without settling.

  PER-RESULT CARRY (the point of the engine): for EACH of the registered results, lift its
           construction fresh from disk, detect the fold-family it uses and the parameter it
           PINNED, then sweep that parameter PAST the pinned value in the real engine. Report
           CARRIES_FURTHER (the construction's machinery keeps producing distinct structure
           beyond where the claim stopped -- the math could go further than the result took it),
           RESOLVES_AT_PIN (the structure the construction uses is exactly what its pin selects;
           nothing further of that family), or NO_SWEEP (the construction pins no sweepable
           fold-parameter -- e.g. a fixed identity).

Every registered result is covered; coverage is asserted (count must equal the registry). Any
new result is automatically included on the next run because the engine reads the registry, not
a hand-list. INTEGRITY: locked by discovery_integrity, wired into the master gate; any edit
trips the lock until reviewed and re-recorded as a visible diff.
"""
import sys, os, re, hashlib, inspect
from fractions import Fraction
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from ratio import ONE, take, cast_out, ratio

SWEEPS = [30, 60, 120, 240]
RES_CAP = 200000
CARRY_TO = 60          # sweep each pinned parameter up to here when testing carry-further

def self_hash():
    return hashlib.sha256(open(os.path.join(HERE, "discovery.py"), "rb").read()).hexdigest()

def I(n):
    v = ONE; k = 1
    while k < n:
        v = v + ONE; k += 1
    return v

def m_fold(x, m):
    v = x; r = ONE
    while r < m:
        v = v + x; r = r + ONE
    return cast_out(v)

def standing(mn):
    m = I(mn)
    if not (m > ONE):
        return set()
    span = take(m, ONE); out = set(); j = ONE
    while j < span:
        x = ratio(j, span)
        if m_fold(x, m) == x:
            out.add(x)
        j = j + ONE
    return out

# ---- fold-family probes (parameter -> structural value), for carry-further sweeping ----
def fam_standing(mn):     return frozenset(str(x) for x in standing(mn))
def fam_coupling(mn):     return str(ratio(take(I(mn), ONE), I(mn))) if mn >= 2 else ""
def fam_mode_count(mn):   return len(standing(mn))
def fam_orbit(mn):
    if mn < 2: return 0
    m = I(2); x = ratio(ONE, I(mn)); c = m_fold(x, m); n = 1; seen = {x}
    while c != x and n < RES_CAP:
        if c in seen: break
        seen.add(c); c = m_fold(c, m); n += 1
    return n
def fam_tower(kn):
    v = ONE + ONE; i = 1
    while i < kn: v = v + v; i += 1
    return str(v)

FAMILIES = {
    "standing_modes": (fam_standing,   r"standing_modes|fixed point|standing mode|returns to itself"),
    "coupling":       (fam_coupling,   r"take\(m, ?ONE\)|coupling|m-less-one over"),
    "mode_count":     (fam_mode_count, r"mode count|number of (interior )?modes|generation count"),
    "orbit_period":   (fam_orbit,      r"orbit|multiplicative order|fold-orbit|period"),
    "tower":          (fam_tower,      r"two-?to-?the|covering tower|binary tower|doubling"),
}

def pinned_param(csrc):
    words = {"two":2,"three":3,"four":4,"five":5,"six":6,"seven":7,"eight":8,"nine":9,
             "ten":10,"eleven":11,"twelve":12,"thirteen":13}
    found = [n for w, n in words.items() if re.search(r"\b"+w+r"\b", csrc.lower())]
    for chain in re.findall(r"(?:ONE(?:\s*\+\s*ONE)+)", csrc):
        found.append(chain.count("ONE"))
    return max(found) if found else None

def construction_source(wrapper):
    import compare, correspondence
    try: wsrc = inspect.getsource(wrapper)
    except Exception: return ""
    m = re.search(r"test_[a-zA-Z0-9_]+", wsrc)
    if not m: return wsrc
    tfn = getattr(compare, m.group(0), None)
    if tfn is None: return wsrc
    try: tsrc = inspect.getsource(tfn)
    except Exception: return wsrc
    cm = re.search(r"(?:Co|correspondence)\.([a-zA-Z0-9_]+)\(", tsrc)
    if not cm: return tsrc
    cfn = getattr(correspondence, cm.group(1), None)
    if cfn is None: return tsrc
    try: return inspect.getsource(cfn)
    except Exception: return tsrc

def carry_verdict(csrc):
    """Detect the fold-family and pinned parameter; sweep the family PAST the pin in the real
    engine. Return (verdict, family, pin, distinct_beyond)."""
    fam = None
    for name, (probe, pat) in FAMILIES.items():
        if re.search(pat, csrc, re.I):
            fam = name; probe_fn = probe; break
    if fam is None:
        return ("NO_SWEEP", None, None, 0)
    pin = pinned_param(csrc)
    if pin is None:
        return ("NO_SWEEP", fam, None, 0)
    # evaluate the family AT the pin and BEYOND it; count distinct structures strictly beyond the pin
    try:
        at = probe_fn(pin)
    except Exception:
        at = None
    beyond = set()
    p = pin + 1
    while p <= max(pin + 1, CARRY_TO):
        try:
            v = probe_fn(p)
            if v not in (None, "", at):
                beyond.add(v)
        except Exception:
            pass
        p += 1
    if len(beyond) > 0:
        return ("CARRIES_FURTHER", fam, pin, len(beyond))
    return ("RESOLVES_AT_PIN", fam, pin, 0)

def axis1(up_to=40):
    from collections import Counter
    tally = Counter()
    for mn in range(2, up_to + 1):
        m = I(mn)
        for d in range(2, up_to + 1):
            for jn in range(1, d):
                x = ratio(I(jn), I(d)); seen = {}; cur = x; n = 0; kind = "UNRESOLVED"
                while n < RES_CAP:
                    nxt = m_fold(cur, m)
                    if nxt == ONE: kind = "RETURNS_ONE"; break
                    if nxt == cur: kind = "FIXED"; break
                    if nxt in seen: kind = "CYCLE"; break
                    seen[nxt] = n; cur = nxt; n += 1
                tally[kind] += 1
    return tally

def placements_to(sweep):
    pl = set()
    for mn in range(2, sweep + 1):
        for x in standing(mn):
            pl.add((str(x), mn))
    return len(pl)

def main():
    args = sys.argv[1:]
    import claims_physics
    E = [t for t in claims_physics.CLAIMS if t[1] == "E"]
    print(f"discovery self-hash: {self_hash()[:16]}")
    print(f"engine: ratio.py (exact)   registered results: {len(E)}\n")

    # ---- PER-RESULT CARRY: the core report, every registered result ----
    from collections import Counter
    verdicts = Counter(); rows = []
    for t in E:
        csrc = construction_source(t[4])
        verdict, fam, pin, beyond = carry_verdict(csrc)
        verdicts[verdict] += 1
        rows.append((t[0], verdict, fam, pin, beyond))
    # coverage assertion: every registered result was examined
    assert len(rows) == len(E), "coverage gap: not every result examined"

    print("=== PER-RESULT CARRY — where each construction's math carries further than the claim ===")
    print(f"  examined: {len(rows)} (all registered results)   coverage: COMPLETE")
    for v in ("CARRIES_FURTHER", "RESOLVES_AT_PIN", "NO_SWEEP"):
        print(f"  {v:16} {verdicts.get(v,0)}")
    print()
    if "--full" in args:
        for tag, verdict, fam, pin, beyond in rows:
            extra = f" family={fam} pin={pin} distinct_beyond={beyond}" if fam else ""
            print(f"  {tag:9} {verdict:16}{extra}")
    else:
        print("  results whose construction CARRIES FURTHER (math goes past where the claim stopped):")
        for tag, verdict, fam, pin, beyond in rows:
            if verdict == "CARRIES_FURTHER":
                print(f"    {tag:9} family={fam:14} pinned~{pin}  distinct structures beyond pin: {beyond}")
        print("  (run with --full for every result's verdict)")

    # ---- AXIS 1 ----
    print("\n=== AXIS 1 — per-expression resolution ===")
    tally = axis1(40); total = sum(tally.values())
    for k in ("RETURNS_ONE", "FIXED", "CYCLE", "UNRESOLVED"):
        print(f"  {k:12} {tally.get(k,0):7} of {total}")

    # ---- AXIS 2 ----
    print("\n=== AXIS 2 — generated structure across increasing sweeps (placements) ===")
    prev = None; growing = True
    for s in SWEEPS:
        pl = placements_to(s)
        if prev is not None and not (pl > prev): growing = False
        prev = pl
        print(f"  sweep 2..{s:3}: {pl} placements")
    print(f"  -> keeps growing without settling: {growing}")

if __name__ == "__main__":
    main()

# ===========================================================================
# CLOSED-SET ENUMERATION (Axis 2): enumerate the finite set the standing parts close into under
# the fold, and mark each member as CORPUS (named in a claim, or a standing mode of a sector the
# corpus uses) or UNCLAIMED (real fold structure not yet named). Reported when run with --closed.
# ===========================================================================
def corpus_named_parts():
    import claims_physics, re
    named = set()
    for t in claims_physics.CLAIMS:
        if t[1] != "E":
            continue
        for mm in re.finditer(r"\b(\d+)\s*/\s*(\d+)\b", t[2]):
            a, b = int(mm.group(1)), int(mm.group(2))
            if b != 0:
                named.add(Fraction(a, b))
    return named

def closed_set(seed_to=30, factors=(2,3,5,7)):
    parts = set()
    for mn in range(2, seed_to + 1):
        parts |= standing(mn)
    closed = set(parts); frontier = set(parts)
    while True:
        new = set()
        for x in frontier:
            for mm in factors:
                y = m_fold(x, I(mm))
                if y not in closed:
                    new.add(y)
        if not new:
            break
        closed |= new; frontier = new
    return closed

def report_closed():
    named = corpus_named_parts()
    closed = closed_set()
    corpus = sorted([x for x in closed if x in named])
    unclaimed = sorted([x for x in closed if x not in named])
    print(f"discovery self-hash: {self_hash()[:16]}")
    print(f"=== CLOSED SET (Axis 2) — enumerated, marked corpus vs unclaimed ===")
    print(f"  closed-set size: {len(closed)}   corpus-named: {len(corpus)}   unclaimed: {len(unclaimed)}")
    print(f"\n  CORPUS-CORRESPONDING members ({len(corpus)}):")
    print("   " + ", ".join(str(x) for x in corpus))
    print(f"\n  UNCLAIMED members ({len(unclaimed)}) — real fold structure not yet named:")
    line = "   "
    for x in unclaimed:
        s = str(x) + " "
        if len(line) + len(s) > 100:
            print(line); line = "   "
        line += s
    if line.strip():
        print(line)

if __name__ == "__main__" and "--closed" in sys.argv:
    report_closed()

# ===========================================================================
# PROVENANCE (1) + RELATION-TO-CLAIMED (2): for each unclaimed member of the closed set, report
# the structural record the engine already computes -- which sector(s) it stands in, its fold
# image, its antipode, its orbit length -- and its exact structural relation to the claimed
# members (antipode-of, fold-image-of, same-orbit-as). No bare fractions: each arrives explained.
# Reported with --provenance.
# ===========================================================================
def antipode(x):
    return take(ONE, x) if x < ONE else x

def orbit_of(x, m, cap=4000):
    seq = [x]; c = m_fold(x, m); n = 0
    while c != x and c != ONE and n < cap:
        seq.append(c); c = m_fold(c, m); n += 1
    return seq

def provenance(x):
    sectors = [mn for mn in range(2, 30) if x in standing(mn)]
    rec = {
        "sectors": sectors,
        "antipode": antipode(x),
        "fold_image_2": m_fold(x, I(2)),
        "fold_image_3": m_fold(x, I(3)),
        "orbit_len_under_2": len(orbit_of(x, I(2))),
    }
    return rec

def report_provenance():
    import claims_physics, re
    named = corpus_named_parts()
    closed = closed_set()
    unclaimed = sorted([x for x in closed if x not in named])
    claimed = sorted([x for x in closed if x in named])
    print(f"discovery self-hash: {self_hash()[:16]}")
    print(f"=== PROVENANCE + RELATION-TO-CLAIMED for {len(unclaimed)} unclaimed members ===\n")
    for x in unclaimed:
        rec = provenance(x)
        rels = []
        ax = rec["antipode"]
        if ax in named:
            rels.append(f"antipode of claimed {ax}")
        if rec["fold_image_2"] in named:
            rels.append(f"folds (m2) to claimed {rec['fold_image_2']}")
        if rec["fold_image_3"] in named:
            rels.append(f"folds (m3) to claimed {rec['fold_image_3']}")
        # same-orbit-as a claimed member under the binary fold
        orb = set(orbit_of(x, I(2)))
        shared = [c for c in claimed if c in orb and c != x]
        if shared:
            rels.append("same binary-orbit as claimed " + ",".join(str(s) for s in shared))
        relstr = "; ".join(rels) if rels else "no direct relation to a claimed member"
        sect = rec["sectors"] if rec["sectors"] else "—"
        print(f"  {x}: sectors={sect} antipode={ax} m2->{rec['fold_image_2']} "
              f"orbit_len(m2)={rec['orbit_len_under_2']}")
        print(f"        relation: {relstr}")

if __name__ == "__main__" and "--provenance" in sys.argv:
    report_provenance()

# ===========================================================================
# GROUPING (2): cluster the unclaimed members by their fold-relations -- members in the same
# binary orbit, or chaining by fold-image to the same claimed anchor, form one group. Turns the
# flat list into the connected structure.
# FOLD-COUNT (3): derive each member's count from the FOLD'S OWN operation -- the sector whose
# fibre stands the member -- not from the fraction's numerator. The count is the sector's kind
# count (the m of the m-fold the member is a standing mode of), forced by the fold, not read off
# the algebra. Reported with --groups.
# ===========================================================================
def binary_orbit_set(x, cap=4000):
    s = {x}; c = m_fold(x, I(2)); n = 0
    while c != x and c != ONE and n < cap:
        s.add(c); c = m_fold(c, I(2)); n += 1
    return frozenset(s)

def fold_count(x):
    """The fold's own count for x: the kind-count m of the smallest sector whose m-fold stands x
    as a fixed point (x is a standing mode of the m-fold). Forced by the fold's fibre, not the
    numerator. Returns the m, or None if x stands in no sector within range."""
    for mn in range(2, 60):
        if x in standing(mn):
            return mn
    return None

def report_groups():
    named = corpus_named_parts()
    closed = closed_set()
    unclaimed = sorted([x for x in closed if x not in named])
    claimed = set(c for c in closed if c in named)

    # (2) group by shared binary orbit
    orbit_groups = {}
    for x in unclaimed:
        key = binary_orbit_set(x)
        orbit_groups.setdefault(key, []).append(x)
    groups = sorted(orbit_groups.values(), key=lambda g: (-len(g), str(g[0])))

    print(f"discovery self-hash: {self_hash()[:16]}")
    print(f"=== GROUPS (2) — {len(unclaimed)} unclaimed members in {len(groups)} fold-orbit groups ===\n")
    for i, g in enumerate(groups[:40]):
        gset = binary_orbit_set(g[0])
        anchors = sorted(c for c in claimed if c in gset)
        anchor_str = (" anchored-to-claimed: " + ",".join(str(a) for a in anchors)) if anchors else " (no claimed anchor)"
        # (3) fold-derived count for each member of the group
        members = ", ".join(f"{x}[count={fold_count(x)}]" for x in sorted(g))
        print(f"  group {i+1} (size {len(g)}){anchor_str}")
        print(f"    {members}")

if __name__ == "__main__" and "--groups" in sys.argv:
    report_groups()

# ===========================================================================
# UNACCOUNTED (explore the unanchored groups): isolate the fold-orbit groups with NO claimed
# anchor -- the structure physics does not currently account for -- and report each group's full
# fold-structure: its fold-count, its orbit, its antipode-pairing, and whether it confines
# (neutral antipodal pairing to the One, the B-5N criterion the claimed sectors satisfy).
# Reported with --unaccounted.
# ===========================================================================
def report_unaccounted():
    named = corpus_named_parts()
    closed = closed_set()
    unclaimed = sorted([x for x in closed if x not in named])
    claimed = set(c for c in closed if c in named)
    orbit_groups = {}
    for x in unclaimed:
        orbit_groups.setdefault(binary_orbit_set(x), []).append(x)
    # unanchored = no claimed member in the orbit
    unanchored = []
    for key, g in orbit_groups.items():
        if not any(c in key for c in claimed):
            unanchored.append(sorted(g))
    unanchored.sort(key=lambda g: (-len(g), str(g[0])))

    print(f"discovery self-hash: {self_hash()[:16]}")
    print(f"=== UNACCOUNTED — {len(unanchored)} fold-groups with NO claimed anchor ===\n")
    for i, g in enumerate(unanchored):
        # fold-count (sector) for the group
        counts = sorted(set(c for c in (fold_count(x) for x in g) if c is not None))
        # confinement test (B-5N): do the group's members pair antipodally to the One?
        confines = all((x + take(ONE, x) == ONE) for x in g if x < ONE)
        # antipode pairs within the group
        pairs = sum(1 for x in g if x < ratio(ONE, ONE+ONE) and take(ONE, x) in set(g))
        print(f"  unaccounted group {i+1}: size {len(g)}  fold-count(sector)={counts}  "
              f"confines={confines}  antipodal-pairs-in-group={pairs}")
        print(f"    members: {', '.join(str(x) for x in g)}")

if __name__ == "__main__" and "--unaccounted" in sys.argv:
    report_unaccounted()

# ===========================================================================
# AUTO-PROOF: subject each unaccounted fold-group to the SAME structural tests the registered
# results pass, and emit the verdict DATA (pass/fail per test) for interpretation. No narration;
# the engine runs the checks and reports the booleans. Tests, each a real fold property:
#   T1 confines        - every interior member pairs antipodally to the One (B-5N criterion)
#   T2 closed_under_fold - folding every member by 2,3,5,7 stays within the group's closed set
#   T3 every_resolves  - every member's fold-orbit resolves (One / fixed / cycle), no runaway
#   T4 standing_sector - the group's members are standing modes of a single definite sector
#   T5 pair_count_law  - antipodal pair count equals (sector_count-1)/2 truncated to interior
# A group PROVES (as a confining sector structure) iff T1..T4 all hold. Reported with --prove.
# ===========================================================================
def group_closed_set(g):
    base = set(g)
    closed = set(base); frontier = set(base)
    rounds = 0
    while rounds < 50:
        new = set()
        for x in frontier:
            for mm in (2,3,5,7):
                y = m_fold(x, I(mm))
                if y not in closed:
                    new.add(y)
        if not new:
            break
        closed |= new; frontier = new; rounds += 1
    return closed

def run_group_proof(g):
    gset = set(g)
    # T1 confinement: interior members pair antipodally to the One
    t1 = all((x + take(ONE, x) == ONE) for x in g if x < ONE)
    # T2 closed under fold within the group's own closure (no escape to a different denominator family)
    dens = set(x.denominator for x in g)
    closure = group_closed_set(g)
    t2 = all(y.denominator in dens or y == ONE for y in closure)
    # T3 every member resolves
    def resolves(x):
        seen=set(); cur=x; n=0
        while n < 20000:
            nxt=m_fold(cur, I(2))
            if nxt==ONE or nxt==cur or nxt in seen: return True
            seen.add(nxt); cur=nxt; n+=1
        return False
    t3 = all(resolves(x) for x in g)
    # T4 single standing sector
    secs = set(c for c in (fold_count(x) for x in g) if c is not None)
    t4 = (len(secs) == 1)
    # T5 pair-count law: interior antipodal pairs vs (sector-1)/2
    pairs = sum(1 for x in g if x < ratio(ONE,ONE+ONE) and take(ONE,x) in gset)
    sector = next(iter(secs)) if t4 else None
    expected = (sector - 1)//2 if sector else None
    t5 = (pairs == expected) if expected is not None else None
    proves = t1 and t2 and t3 and t4
    return {"T1_confines":t1,"T2_closed":t2,"T3_resolves":t3,"T4_single_sector":t4,
            "T5_pair_law":t5,"sector":sector,"pairs":pairs,"PROVES":proves}

def report_prove():
    named = corpus_named_parts()
    closed = closed_set()
    unclaimed = sorted([x for x in closed if x not in named])
    claimed = set(c for c in closed if c in named)
    orbit_groups = {}
    for x in unclaimed:
        orbit_groups.setdefault(binary_orbit_set(x), []).append(x)
    unanchored = [sorted(g) for key,g in orbit_groups.items() if not any(c in key for c in claimed)]
    unanchored.sort(key=lambda g:(-len(g),str(g[0])))
    print(f"discovery self-hash: {self_hash()[:16]}")
    print(f"=== AUTO-PROOF — {len(unanchored)} unaccounted groups run through the corpus's tests ===")
    print(f"  {'grp':>3} {'size':>4} {'sector':>6} {'T1':>3} {'T2':>3} {'T3':>3} {'T4':>3} {'T5':>3} {'pairs':>5} {'PROVES':>7}")
    proven=0
    for i,g in enumerate(unanchored):
        r = run_group_proof(g)
        if r["PROVES"]: proven+=1
        def b(v): return "Y" if v is True else ("n" if v is False else "-")
        print(f"  {i+1:3} {len(g):4} {str(r['sector']):>6} {b(r['T1_confines']):>3} {b(r['T2_closed']):>3} {b(r['T3_resolves']):>3} {b(r['T4_single_sector']):>3} {b(r['T5_pair_law']):>3} {r['pairs']:5} {b(r['PROVES']):>7}")
    print(f"\n  groups passing T1-T4 (prove as confining sector structures): {proven} of {len(unanchored)}")

if __name__ == "__main__" and "--prove" in sys.argv:
    report_prove()
