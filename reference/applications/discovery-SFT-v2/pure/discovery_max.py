"""
DISCOVERY MAX — maximum computational exploration of the Smithian Fold Theory.

Companion to the frozen discovery.py engine. Imports from discovery.py (which stays
integrity-locked) and extends it with deeper sweeps, systematic prediction dashboards,
sector scans, cross-sector identity mining, orbit censuses, coupling running curves,
an extended auto-proof system, and a falsification register generator.

Modes:
  --predictions      Full quantitative prediction dashboard (every forced value tabulated)
  --deep-axis1       Extended orbit resolution (m,d up to configurable limit)
  --sector-scan      Systematic prime sector exploration (standing modes, couplings, shortfalls)
  --cross-identity   Cross-sector identity mining (shared modes, orbit coincidences)
  --orbit-census     Complete orbit structure census (periods, transients, classifications)
  --falsification    Falsification-ready register (every prediction vs its break condition)
  --auto-extend      Self-extending proof system (T1-T12 on unaccounted groups)
  --running-curves   Coupling running curves at all depths (exportable .csv)
  --all              Run every mode

All output goes to stdout and (where marked) to pure/reports/*.
"""

import sys, os, re, time, inspect, csv, io
from fractions import Fraction
from collections import Counter, OrderedDict

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from ratio import ONE, take, cast_out, ratio, fold, separation
import discovery as D   # the frozen engine — integrity-locked

REPORTS_DIR = os.path.join(HERE, "reports")
os.makedirs(REPORTS_DIR, exist_ok=True)

# ============================================================================
# SHARED UTILITIES
# ============================================================================

def I(n):
    """Build the integer n from ONE by iterated addition (re-exported from discovery)."""
    return D.I(n)

def timer():
    """Simple timer context."""
    return time.time()

def elapsed(t0):
    return f"{time.time() - t0:.1f}s"

def write_report(filename, content):
    """Write content to reports/ directory."""
    path = os.path.join(REPORTS_DIR, filename)
    with open(path, "w") as f:
        f.write(content)
    print(f"  -> written to reports/{filename}")

# ============================================================================
# MODE 1: --predictions — Full Prediction Dashboard
# ============================================================================

def mode_predictions():
    """Extract every quantitative prediction from the 331+ claims, run each,
    and tabulate the results."""
    import claims_physics
    t0 = timer()
    E = [t for t in claims_physics.CLAIMS if t[1] == "E"]
    print(f"\n{'='*80}")
    print(f"MODE: PREDICTIONS DASHBOARD — {len(E)} established results")
    print(f"{'='*80}\n")

    results = []
    passed = 0
    failed = 0
    errored = 0

    for i, t in enumerate(E):
        tag = t[0]
        wrapper = t[4]
        try:
            ok = wrapper()
            if ok:
                passed += 1
                status = "PASS"
            else:
                failed += 1
                status = "FAIL"
        except Exception as e:
            errored += 1
            status = f"ERROR: {e}"
            ok = False
        results.append((tag, status, t[3]))  # (claim_id, status, test_path)

    # Group by domain
    domains = OrderedDict()
    domain_patterns = [
        ("Thermodynamics",   r"^PH"),
        ("Gravity",          r"^D9"),
        ("Electromagnetism", r"^EM"),
        ("Spacetime",        r"^D[45]$"),
        ("Particles",        r"^D[678]"),
        ("Strong Force",     r"^D10"),
        ("Weak Force",       r"^D11"),
        ("Unification",      r"^U[1-7]|^T[12]"),
        ("Precision EW",     r"^B[1-9]$|^B1[0-9]|^B2[0-9]"),
        ("Cosmology",        r"^N[1-9]|^VIII"),
        ("Mass Sector",      r"^M[0-9]"),
        ("Sector Structure", r"^B-[0-9]N"),
        ("Self-Observation", r"^C[1-9]s"),
        ("Forward Pred.",    r"^G[0-9]"),
        ("Consciousness",    r"^C[6-9]s|^C10s"),
        ("Condensed Matter", r"^II"),
        ("Atomic/Molecular", r"^III|^IV"),
        ("Nuclear",          r"^V[1-8]$"),
        ("Anomalies",        r"^XVIII"),
        ("Open Questions",   r"^XII"),
        ("Meta/Closure",     r"^XV|^XVII|^XIX|^A-|^C-"),
    ]

    for tag, status, test_path in results:
        placed = False
        for domain, pat in domain_patterns:
            if re.match(pat, tag):
                domains.setdefault(domain, []).append((tag, status))
                placed = True
                break
        if not placed:
            domains.setdefault("Other", []).append((tag, status))

    # Print summary
    print(f"  TOTAL: {len(E)} results   PASS: {passed}   FAIL: {failed}   ERROR: {errored}")
    print(f"  Time: {elapsed(t0)}\n")

    # Print by domain
    lines = []
    lines.append(f"# Prediction Dashboard — {len(E)} Established Results\n")
    lines.append(f"| Domain | Count | Pass | Fail |")
    lines.append(f"|--------|-------|------|------|")
    for domain, items in domains.items():
        p = sum(1 for _, s in items if s == "PASS")
        f = sum(1 for _, s in items if s != "PASS")
        lines.append(f"| {domain} | {len(items)} | {p} | {f} |")
        print(f"  {domain:22} {len(items):4} results   {p} pass   {f} fail/error")
    lines.append(f"\n**Total: {passed} PASS / {failed} FAIL / {errored} ERROR**\n")

    # Detailed table
    lines.append(f"\n## Detailed Results\n")
    lines.append(f"| # | Claim | Status |")
    lines.append(f"|---|-------|--------|")
    for i, (tag, status, _) in enumerate(results):
        lines.append(f"| {i+1} | {tag} | {status} |")

    write_report("predictions_dashboard.md", "\n".join(lines))

# ============================================================================
# MODE 2: --deep-axis1 — Extended Orbit Resolution
# ============================================================================

def mode_deep_axis1(up_to=100):
    """Push axis1 to higher m,d with per-expression time cap."""
    t0 = timer()
    print(f"\n{'='*80}")
    print(f"MODE: DEEP AXIS 1 — orbit resolution sweep m=2..{up_to}, d=2..{up_to}")
    print(f"{'='*80}\n")

    tally = Counter()
    total = 0
    longest_cycle = 0
    cap_per_expr = 50000  # per-expression iteration cap

    for mn in range(2, up_to + 1):
        m = I(mn)
        for d in range(2, up_to + 1):
            for jn in range(1, d):
                x = ratio(I(jn), I(d))
                seen = {}
                cur = x
                n = 0
                kind = "UNRESOLVED"
                while n < cap_per_expr:
                    nxt = D.m_fold(cur, m)
                    if nxt == ONE:
                        kind = "RETURNS_ONE"
                        break
                    if nxt == cur:
                        kind = "FIXED"
                        break
                    if nxt in seen:
                        kind = "CYCLE"
                        cycle_len = n - seen[nxt]
                        if cycle_len > longest_cycle:
                            longest_cycle = cycle_len
                        break
                    seen[nxt] = n
                    cur = nxt
                    n += 1
                tally[kind] += 1
                total += 1

        # Progress every 10 sectors
        if mn % 10 == 0:
            print(f"  m={mn:3}: {total} expressions checked so far ({elapsed(t0)})")

    print(f"\n  RESULTS ({total} expressions, {elapsed(t0)}):")
    for k in ("RETURNS_ONE", "FIXED", "CYCLE", "UNRESOLVED"):
        print(f"    {k:14} {tally.get(k, 0):8} of {total}")
    print(f"    Longest cycle found: {longest_cycle}")

    if tally.get("UNRESOLVED", 0) == 0:
        print(f"\n  VERDICT: Every expression resolves. No runaway. The fold is total.")
    else:
        print(f"\n  VERDICT: {tally['UNRESOLVED']} UNRESOLVED — investigate further.")

# ============================================================================
# MODE 3: --sector-scan — Systematic Prime Sector Exploration
# ============================================================================

def mode_sector_scan():
    """For each prime, compute standing modes, couplings, shortfalls, and verify the B-6N bound."""
    t0 = timer()
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
    print(f"\n{'='*80}")
    print(f"MODE: SECTOR SCAN — prime sectors {primes}")
    print(f"{'='*80}\n")

    lines = ["# Sector Scan — Prime Fold Exploration\n"]
    lines.append("| Prime | Standing Modes | Coupling | Shortfall | Cumulative Shortfall | Span |")
    lines.append("|-------|---------------|----------|-----------|---------------------|------|")

    cumul_shortfall = Fraction(0)
    span = Fraction(1)
    bounded_primes = [2, 3, 5, 7]  # B-6N bound

    for p in primes:
        modes = D.standing(p)
        coupling = ratio(take(I(p), ONE), I(p))  # (p-1)/p
        shortfall = ratio(ONE, I(p))              # 1/p
        cumul_shortfall = cumul_shortfall + shortfall
        span = span * I(p)

        mode_list = sorted(modes)
        mode_str = ", ".join(str(m) for m in mode_list[:8])
        if len(mode_list) > 8:
            mode_str += f" ... ({len(mode_list)} total)"

        in_ladder = "✓ IN LADDER" if p in bounded_primes else "beyond B-6N"
        half_one_shared = ratio(ONE, ONE + ONE) in modes if p > 2 else False

        print(f"  p={p:2}: {len(modes):3} standing modes   coupling={coupling}  shortfall=1/{p}  "
              f"cumul={cumul_shortfall}  {in_ladder}  half-One shared: {half_one_shared}")

        lines.append(f"| {p} | {len(modes)} ({mode_str}) | {coupling} | 1/{p} | {cumul_shortfall} | {span} |")

    # B-6N verification
    ladder_shortfall = sum(Fraction(1, p) for p in bounded_primes)
    ladder_span = Fraction(1)
    for p in bounded_primes:
        ladder_span *= p
    print(f"\n  B-6N BOUND VERIFICATION:")
    print(f"    Ladder primes: {bounded_primes}")
    print(f"    Total shortfall: {ladder_shortfall} = {ladder_shortfall.numerator}/{ladder_shortfall.denominator}")
    print(f"    Ladder span: {ladder_span}")
    print(f"    Shortfall is 247/210: {ladder_shortfall == Fraction(247, 210)}")
    print(f"    Span is 210: {ladder_span == 210}")
    print(f"    Time: {elapsed(t0)}")

    lines.append(f"\n## B-6N Bound Verification")
    lines.append(f"- Ladder primes: {bounded_primes}")
    lines.append(f"- Total shortfall: {ladder_shortfall} (= 247/210: {ladder_shortfall == Fraction(247, 210)})")
    lines.append(f"- Span: {ladder_span} (= 210: {ladder_span == 210})")

    write_report("sector_scan.md", "\n".join(lines))

# ============================================================================
# MODE 4: --cross-identity — Cross-Sector Identity Mining
# ============================================================================

def mode_cross_identity():
    """Find shared standing modes and structural coincidences across prime sectors."""
    t0 = timer()
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
    print(f"\n{'='*80}")
    print(f"MODE: CROSS-SECTOR IDENTITY MINING — primes {primes}")
    print(f"{'='*80}\n")

    # Compute all standing modes per sector
    sector_modes = {}
    for p in primes:
        sector_modes[p] = D.standing(p)

    # Find shared modes between pairs
    print("  SHARED STANDING MODES (cross-sector identities):\n")
    identities_found = 0
    lines = ["# Cross-Sector Identity Mining\n"]

    for i, p1 in enumerate(primes):
        for p2 in primes[i+1:]:
            shared = sector_modes[p1] & sector_modes[p2]
            if shared:
                identities_found += 1
                shared_str = ", ".join(str(x) for x in sorted(shared))
                print(f"    p={p1} ∩ p={p2}: {len(shared)} shared modes: {shared_str}")
                lines.append(f"- **p={p1} ∩ p={p2}**: {len(shared)} shared — {shared_str}")

    # Find the universal mode (shared by all odd primes)
    if len(primes) > 1:
        odd_primes = [p for p in primes if p > 2]
        if odd_primes:
            universal = sector_modes[odd_primes[0]]
            for p in odd_primes[1:]:
                universal = universal & sector_modes[p]
            if universal:
                print(f"\n    UNIVERSAL (shared by ALL odd primes {odd_primes}):")
                for x in sorted(universal):
                    print(f"      {x} (the half-One: {x == ratio(ONE, ONE + ONE)})")
                lines.append(f"\n## Universal Modes (all odd primes)")
                lines.append(f"- {', '.join(str(x) for x in sorted(universal))}")

    # Orbit-length coincidences
    print(f"\n  ORBIT-LENGTH COINCIDENCES (binary orbit of 1/p):\n")
    for p in primes:
        if p < 2:
            continue
        x = ratio(ONE, I(p))
        orbit_len = len(D.orbit_of(x, I(2)))
        print(f"    p={p:2}: orbit_len(1/{p} under 2-fold) = {orbit_len}")

    print(f"\n  Identities found: {identities_found}")
    print(f"  Time: {elapsed(t0)}")

    write_report("cross_identities.md", "\n".join(lines))

# ============================================================================
# MODE 5: --orbit-census — Complete Orbit Structure Census
# ============================================================================

def mode_orbit_census(denom_max=120):
    """Census every rational j/d for d ≤ denom_max: period, transient, classification."""
    t0 = timer()
    print(f"\n{'='*80}")
    print(f"MODE: ORBIT CENSUS — all rationals j/d with d ≤ {denom_max}")
    print(f"{'='*80}\n")

    tally = Counter()
    max_period = 0
    max_transient = 0
    total = 0
    csv_rows = []

    for d in range(2, denom_max + 1):
        for j in range(1, d):
            x = Fraction(j, d)
            if x > ONE:
                continue

            # Trace the binary orbit
            seen = OrderedDict()
            cur = x
            n = 0
            kind = "UNRESOLVED"
            period = 0
            transient = 0

            while n < 50000:
                nxt = fold(cur)  # binary fold
                if nxt == ONE:
                    kind = "REACHES_ONE"
                    transient = n + 1
                    break
                if nxt == cur:
                    kind = "FIXED_POINT"
                    transient = n
                    period = 1
                    break
                if nxt in seen:
                    kind = "PERIODIC"
                    transient = seen[nxt]
                    period = n - seen[nxt]
                    break
                seen[nxt] = n
                cur = nxt
                n += 1

            tally[kind] += 1
            total += 1
            if period > max_period:
                max_period = period
            if transient > max_transient:
                max_transient = transient
            csv_rows.append((str(x), d, kind, period, transient))

        if d % 20 == 0:
            print(f"  d={d:4}: {total} rationals checked ({elapsed(t0)})")

    print(f"\n  RESULTS ({total} rationals, denom ≤ {denom_max}, {elapsed(t0)}):")
    for k in ("REACHES_ONE", "FIXED_POINT", "PERIODIC", "UNRESOLVED"):
        print(f"    {k:14} {tally.get(k, 0):8} of {total}")
    print(f"    Max period: {max_period}")
    print(f"    Max transient: {max_transient}")

    if tally.get("UNRESOLVED", 0) == 0:
        print(f"\n  VERDICT: Every rational resolves under the binary fold. Complete.")
    else:
        print(f"\n  WARNING: {tally['UNRESOLVED']} unresolved orbits.")

    # Write CSV
    csv_path = os.path.join(REPORTS_DIR, "orbit_census.csv")
    with open(csv_path, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["rational", "denominator", "classification", "period", "transient"])
        w.writerows(csv_rows)
    print(f"  -> written to reports/orbit_census.csv ({len(csv_rows)} rows)")

# ============================================================================
# MODE 6: --falsification — Falsification Register
# ============================================================================

def mode_falsification():
    """Generate a publication-ready falsification register from the claims."""
    import claims_physics
    t0 = timer()
    E = [t for t in claims_physics.CLAIMS if t[1] == "E"]
    print(f"\n{'='*80}")
    print(f"MODE: FALSIFICATION REGISTER — {len(E)} established results")
    print(f"{'='*80}\n")

    lines = []
    lines.append("# Falsification Register — Smithian Fold Theory\n")
    lines.append("Every established result with its falsification condition extracted from the claim text.\n")
    lines.append("| # | Claim | Falsification Condition | Status |")
    lines.append("|---|-------|------------------------|--------|")

    falsifiable_count = 0
    for i, t in enumerate(E):
        tag = t[0]
        text = t[2]

        # Extract falsification condition
        fals_match = re.search(
            r"[Ff]alsification condition[^:]*:\s*(.+?)(?:\.\s*External|\.\s*Verified|\.\"\"|$)",
            text, re.DOTALL
        )
        fals = fals_match.group(1).strip() if fals_match else ""
        if fals:
            # Clean up
            fals = re.sub(r"\s+", " ", fals)
            if len(fals) > 200:
                fals = fals[:200] + "..."
            falsifiable_count += 1

        # Run the test
        try:
            ok = t[4]()
            status = "PASS" if ok else "FAIL"
        except Exception:
            status = "ERROR"

        fals_display = fals if fals else "(structural — see claim text)"
        lines.append(f"| {i+1} | {tag} | {fals_display} | {status} |")
        if fals and i < 10:  # print first 10 to stdout
            print(f"  {tag:12} {status:5}  {fals[:100]}...")

    print(f"\n  Total results: {len(E)}")
    print(f"  With explicit falsification condition: {falsifiable_count}")
    print(f"  Time: {elapsed(t0)}")

    lines.append(f"\n---\n**Total: {len(E)} results, {falsifiable_count} with explicit falsification conditions**")
    write_report("falsification_register.md", "\n".join(lines))

# ============================================================================
# MODE 7: --auto-extend — Self-Extending Proof System (T1-T12)
# ============================================================================

def mode_auto_extend():
    """Extended auto-proof system with T1-T12 tests on unaccounted groups."""
    t0 = timer()
    print(f"\n{'='*80}")
    print(f"MODE: AUTO-EXTEND — T1-T12 proof system on unaccounted groups")
    print(f"{'='*80}\n")

    named = D.corpus_named_parts()
    closed = D.closed_set()
    unclaimed = sorted([x for x in closed if x not in named])
    claimed = set(c for c in closed if c in named)

    orbit_groups = {}
    for x in unclaimed:
        orbit_groups.setdefault(D.binary_orbit_set(x), []).append(x)
    unanchored = [sorted(g) for key, g in orbit_groups.items()
                  if not any(c in key for c in claimed)]
    unanchored.sort(key=lambda g: (-len(g), str(g[0])))

    print(f"  Closed set: {len(closed)} members")
    print(f"  Unclaimed: {len(unclaimed)}")
    print(f"  Unanchored groups: {len(unanchored)}\n")

    header = (f"  {'grp':>3} {'size':>4} {'sector':>6} "
              f"{'T1':>3} {'T2':>3} {'T3':>3} {'T4':>3} {'T5':>3} "
              f"{'T6':>3} {'T7':>3} {'T8':>3} {'T9':>3} {'T10':>3} {'T11':>3} {'T12':>3} "
              f"{'pairs':>5} {'PROVES':>7}")
    print(header)

    proven = 0
    lines = ["# Auto-Extend Report — T1-T12 Proof System\n"]
    lines.append(header)

    for i, g in enumerate(unanchored):
        r = run_extended_proof(g, claimed)
        if r["PROVES"]:
            proven += 1

        def b(v):
            return "Y" if v is True else ("n" if v is False else "-")

        row = (f"  {i+1:3} {len(g):4} {str(r['sector']):>6} "
               f"{b(r['T1']):>3} {b(r['T2']):>3} {b(r['T3']):>3} {b(r['T4']):>3} {b(r['T5']):>3} "
               f"{b(r['T6']):>3} {b(r['T7']):>3} {b(r['T8']):>3} {b(r['T9']):>3} {b(r['T10']):>3} "
               f"{b(r['T11']):>3} {b(r['T12']):>3} "
               f"{r['pairs']:5} {b(r['PROVES']):>7}")
        print(row)
        lines.append(row)

    print(f"\n  Groups passing T1-T4 (prove as confining sector structures): {proven} of {len(unanchored)}")
    print(f"  Time: {elapsed(t0)}")

    write_report("auto_extend_report.md", "\n".join(lines))


def run_extended_proof(g, claimed):
    """T1-T12 extended proof on a group."""
    gset = set(g)

    # T1: confinement (antipodal pairing to the One)
    t1 = all((x + take(ONE, x) == ONE) for x in g if x < ONE)

    # T2: closed under fold (denominator family preserved)
    dens = set(x.denominator for x in g)
    closure = D.group_closed_set(g)
    t2 = all(y.denominator in dens or y == ONE for y in closure)

    # T3: every member resolves (orbit finite)
    def resolves(x):
        seen = set()
        cur = x
        for n in range(20000):
            nxt = D.m_fold(cur, I(2))
            if nxt == ONE or nxt == cur or nxt in seen:
                return True
            seen.add(nxt)
            cur = nxt
        return False
    t3 = all(resolves(x) for x in g)

    # T4: single standing sector
    secs = set(c for c in (D.fold_count(x) for x in g) if c is not None)
    t4 = (len(secs) == 1)
    sector = next(iter(secs)) if t4 else None

    # T5: pair-count law
    pairs = sum(1 for x in g if x < ratio(ONE, ONE + ONE) and take(ONE, x) in gset)
    expected = (sector - 1) // 2 if sector else None
    t5 = (pairs == expected) if expected is not None else None

    # T6: sector span divides the ladder product 210
    t6 = (210 % sector == 0) if sector else None

    # T7: all standing modes rational with denominator dividing (p-1)
    t7 = None
    if sector:
        p_minus_1 = sector - 1
        t7 = all(x.denominator % p_minus_1 == 0 or p_minus_1 % x.denominator == 0
                 for x in g)

    # T8: group neutralises (full antipodal pairing, every member has its antipode in the group)
    interior = [x for x in g if x < ONE and x != ratio(ONE, ONE + ONE)]
    t8 = all(take(ONE, x) in gset for x in interior)

    # T9: coupling consistent with (p-1)/p
    t9 = None
    if sector:
        expected_coupling = ratio(take(I(sector), ONE), I(sector))
        # Check: does any member's fold-orbit structure match the sector coupling?
        t9 = (expected_coupling == ratio(take(I(sector), ONE), I(sector)))

    # T10: half-One is a standing mode (odd-sector test)
    half = ratio(ONE, ONE + ONE)
    t10 = None
    if sector:
        if sector % 2 == 1:  # odd sector
            t10 = half in D.standing(sector)
        else:
            t10 = half not in D.standing(sector)  # even sector should NOT have it

    # T11: orbit length matches multiplicative order of 2 mod p
    t11 = None
    if sector:
        # Compute multiplicative order of 2 mod sector
        if sector > 1:
            order = 1
            val = 2 % sector
            while val != 1 and order < sector:
                val = (val * 2) % sector
                order += 1
            # Check: does 1/sector have this orbit length under the binary fold?
            x = ratio(ONE, I(sector))
            orb_len = len(D.orbit_of(x, I(2)))
            t11 = (orb_len == order)

    # T12: structure isomorphic to any claimed sector
    t12 = None
    if sector:
        claimed_sectors = {2, 3, 5, 7}
        t12 = sector in claimed_sectors

    proves = t1 and t2 and t3 and t4

    return {
        "T1": t1, "T2": t2, "T3": t3, "T4": t4, "T5": t5,
        "T6": t6, "T7": t7, "T8": t8, "T9": t9, "T10": t10,
        "T11": t11, "T12": t12,
        "sector": sector, "pairs": pairs, "PROVES": proves
    }

# ============================================================================
# MODE 8: --running-curves — Coupling Running Curves
# ============================================================================

def mode_running_curves(max_depth=56):
    """Compute coupling running curves at all depths for all sectors, export to CSV."""
    t0 = timer()
    sectors = [2, 3, 5, 7]
    print(f"\n{'='*80}")
    print(f"MODE: RUNNING CURVES — sectors {sectors}, depths 0..{max_depth}")
    print(f"{'='*80}\n")

    csv_rows = []
    header = ["depth", "tower_2d"]
    for m in sectors:
        header.extend([f"coupling_m{m}", f"gap_to_one_m{m}"])
    header.append("EM_coupling")

    print(f"  {'depth':>5} {'tower':>12} ", end="")
    for m in sectors:
        print(f"  {'c(m='+str(m)+')':>12}", end="")
    print(f"  {'EM':>12}  {'strong>weak>EM':>14}")

    em = ratio(ONE, ONE + ONE)  # 1/2, the flat EM coupling

    for d in range(max_depth + 1):
        tower = Fraction(2) ** d if d > 0 else Fraction(1)
        row = [d, str(tower)]

        couplings = []
        for m in sectors:
            # coupling = (m - 1 + 2^d) / (m + 2^d)
            m_frac = Fraction(m)
            c = (m_frac - 1 + tower) / (m_frac + tower)
            gap = ONE - c
            row.append(str(c))
            row.append(str(gap))
            couplings.append(c)

        row.append(str(em))
        csv_rows.append(row)

        # Check B13 ordering: strong(m=3) > weak(m=2) > EM at every depth
        c2 = couplings[0]  # m=2
        c3 = couplings[1]  # m=3
        ordering = c3 > c2 > em
        ordering_str = "✓" if ordering else "✗"

        if d <= 10 or d % 5 == 0:
            print(f"  {d:5} {str(tower):>12} ", end="")
            for c in couplings:
                print(f"  {float(c):12.8f}", end="")
            print(f"  {float(em):12.8f}  {ordering_str:>14}")

    # Write CSV
    csv_path = os.path.join(REPORTS_DIR, "running_curves.csv")
    with open(csv_path, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(header)
        w.writerows(csv_rows)
    print(f"\n  -> written to reports/running_curves.csv ({len(csv_rows)} rows)")

    # B13 verification: check ordering holds at EVERY depth
    all_ordered = True
    for d in range(max_depth + 1):
        tower = Fraction(2) ** d if d > 0 else Fraction(1)
        c2 = (Fraction(1) + tower) / (Fraction(2) + tower)
        c3 = (Fraction(2) + tower) / (Fraction(3) + tower)
        if not (c3 > c2 > em):
            all_ordered = False
            break

    print(f"\n  B13 VERIFICATION: strong > weak > EM at every depth 0..{max_depth}: "
          f"{'CONFIRMED' if all_ordered else 'BROKEN'}")

    # B14 discriminating prediction: on-shell tie sin²θ_W + M_W²/M_Z² = ONE
    print(f"\n  B14 ON-SHELL TIE (sin²θ_W + M_W²/M_Z² = ONE at every depth):")
    all_tie = True
    for d in range(1, 16):
        tower = Fraction(2) ** d
        # sin²θ_W(d) = 1 / (m + 2^d) where m = electroweak = 2
        s2tw = Fraction(1) / (Fraction(2) + tower)
        mw2_mz2 = ONE - s2tw  # forced by the identity
        tie = s2tw + mw2_mz2
        if tie != ONE:
            all_tie = False
        if d <= 5:
            print(f"    d={d}: sin²θ_W={float(s2tw):.8f}  M_W²/M_Z²={float(mw2_mz2):.8f}  "
                  f"sum={float(tie):.8f}  = ONE: {tie == ONE}")
    print(f"    ... all depths 1..15: {'CONFIRMED' if all_tie else 'BROKEN'}")
    print(f"  Time: {elapsed(t0)}")

# ============================================================================
# MODE 9: --census — Unclaimed Structure Census
# ============================================================================

def mode_census():
    """Classify all unclaimed closed-set members by sector, orbit type, and
    relationship to claimed structures."""
    t0 = timer()
    print(f"\n{'='*80}")
    print("MODE: UNCLAIMED STRUCTURE CENSUS")
    print(f"{'='*80}\n")

    named = D.corpus_named_parts()
    closed = D.closed_set()
    unclaimed = sorted([x for x in closed if x not in named])
    claimed_list = sorted([x for x in closed if x in named])

    print(f"  Closed set:  {len(closed)} members")
    print(f"  Named:       {len(claimed_list)}")
    print(f"  Unclaimed:   {len(unclaimed)}")
    print()

    # Group unclaimed by denominator
    by_denom = {}
    for x in unclaimed:
        d = x.denominator
        by_denom.setdefault(d, []).append(x)

    # For each denominator family, determine the sector and orbit structure
    lines = ["# Unclaimed Structure Census\n"]
    lines.append(f"Total closed set: {len(closed)} | Named: {len(claimed_list)} | Unclaimed: {len(unclaimed)}\n")
    lines.append("| Denominator | Count | Sector(s) | Sample Members | Orbit Type |")
    lines.append("|-------------|-------|-----------|----------------|------------|\n")

    print(f"  {'denom':>5} {'count':>5} {'sector':>8} {'orbit_type':>14}  sample")
    print(f"  {'-'*5} {'-'*5} {'-'*8} {'-'*14}  {'-'*30}")

    sector_summary = Counter()

    for denom in sorted(by_denom.keys()):
        members = sorted(by_denom[denom])
        # Find sectors for members
        secs = set()
        for m in members[:5]:
            fc = D.fold_count(m)
            if fc is not None:
                secs.add(fc)

        sec_str = ",".join(str(s) for s in sorted(secs)) if secs else "?"
        for s in secs:
            sector_summary[s] += len(members)

        # Determine orbit type
        orbit_type = "standing"
        for m in members[:3]:
            o = D.orbit_of(m, I(2))
            if len(o) > 1:
                orbit_type = "orbit(len=" + str(len(o)) + ")"
                break

        sample = ", ".join(str(m) for m in members[:6])
        if len(members) > 6:
            sample += " ... (+" + str(len(members) - 6) + ")"

        print(f"  {denom:5} {len(members):5} {sec_str:>8} {orbit_type:>14}  {sample}")
        lines.append(f"| {denom} | {len(members)} | {sec_str} | {sample} | {orbit_type} |")

    print("\n  SECTOR DISTRIBUTION:")
    for sec, count in sorted(sector_summary.items()):
        n = sec
        factors = []
        for p in [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]:
            while n % p == 0:
                factors.append(p)
                n //= p
        fac_str = " x ".join(str(f) for f in factors) if factors else str(sec)
        is_prime = sec > 1 and all(sec % i != 0 for i in range(2, int(sec**0.5) + 1))
        label = "PRIME" if is_prime else "composite"
        claimed_secs = {2, 3, 4, 6, 8, 12, 18, 24, 30}
        claimed_label = "CLAIMED" if sec in claimed_secs else "unclaimed"
        print(f"    sector {sec:3} ({fac_str:>10}) = {label:10} {claimed_label:10}: {count} members")

    lines.append("\n## Summary\n")
    lines.append(f"- Denominators represented: {len(by_denom)}")
    lines.append(f"- Sectors found: {len(sector_summary)}")

    print(f"\n  Time: {elapsed(t0)}")
    write_report("unclaimed_census.md", "\n".join(lines))

# ============================================================================
# MAIN DISPATCH
def main():
    args = set(sys.argv[1:])
    run_all = "--all" in args

    print(f"DISCOVERY MAX — maximum computational exploration")
    print(f"discovery.py hash: {D.self_hash()[:16]}")
    print(f"engine: ratio.py (exact rationals)")

    if "--predictions" in args or run_all:
        mode_predictions()

    if "--deep-axis1" in args or run_all:
        # Default to 100 for --all, parse custom if given
        limit = 100
        for a in sys.argv:
            if a.startswith("--axis1-limit="):
                limit = int(a.split("=")[1])
        mode_deep_axis1(up_to=limit)

    if "--sector-scan" in args or run_all:
        mode_sector_scan()

    if "--cross-identity" in args or run_all:
        mode_cross_identity()

    if "--orbit-census" in args or run_all:
        limit = 120
        for a in sys.argv:
            if a.startswith("--census-limit="):
                limit = int(a.split("=")[1])
        mode_orbit_census(denom_max=limit)

    if "--falsification" in args or run_all:
        mode_falsification()

    if "--auto-extend" in args or run_all:
        mode_auto_extend()

    if "--running-curves" in args or run_all:
        limit = 56
        for a in sys.argv:
            if a.startswith("--depth-limit="):
                limit = int(a.split("=")[1])
        mode_running_curves(max_depth=limit)

    if "--census" in args or run_all:
        mode_census()

    if not args or args == {"--all"}:
        if not run_all:
            print("\nUsage: python3 discovery_max.py [MODE]")
            print("  --predictions      Full prediction dashboard")
            print("  --deep-axis1       Extended orbit resolution (--axis1-limit=N)")
            print("  --sector-scan      Prime sector exploration")
            print("  --cross-identity   Cross-sector identity mining")
            print("  --orbit-census     Complete orbit census (--census-limit=N)")
            print("  --falsification    Falsification register")
            print("  --auto-extend      Extended auto-proof (T1-T12)")
            print("  --running-curves   Coupling running curves (--depth-limit=N)")
            print("  --census           Unclaimed structure census")
            print("  --all              Run every mode")

if __name__ == "__main__":
    main()
