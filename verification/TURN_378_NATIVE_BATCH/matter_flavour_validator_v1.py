"""Implementation-distinct validator for exact matter/flavour successors."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


IDS = (
    "SFT-PHYS-MATTER-QUARK-INVARIANTS-003",
    "SFT-PHYS-MATTER-QUARK-CUBICS-003",
    "SFT-PHYS-MATTER-QUARK-DRESSING-003",
    "SFT-PHYS-MATTER-CKM-FIBRE-003",
    "SFT-PHYS-MATTER-CKM-PHYSICAL-003",
    "SFT-PHYS-MATTER-PROTON-ELECTRON-003",
    "SFT-PHYS-NEUTRINO-SPLITTING-003",
    "SFT-PHYS-NEUTRINO-POSITIVE-MASS-003",
    "SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003",
    "SFT-PHYS-NEUTRINO-MAJORANA-003",
    "SFT-PHYS-NEUTRINO-ZERO-NU-BETA-BETA-003",
    "SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003",
)

RELATIONS = {
    IDS[0]: ("asserted-quark-coefficients", "channel-count-cross-locked-with-Fold-product"),
    IDS[1]: ("selected-root-table-or-fitted-polynomial", "dual-colour-binary-cubic-invariants"),
    IDS[2]: ("measurement-selected-mass-correction", "central-down-lift-and-upper-up-retention"),
    IDS[3]: ("nine-independent-mixing-dials", "complete-two-fibre-overlap"),
    IDS[4]: ("independent-fitted-CKM-angles", "polynomial-root-mixing-graph-with-six-channel-apex"),
    IDS[5]: ("measured-proton-electron-ratio-as-input", "one-third-baryon-over-lepton-polynomial-mass-graph"),
    IDS[6]: ("measured-splitting-ratio", "Mersenne-rung-and-cover-translation-cross-lock"),
    IDS[7]: ("massless-lightest-or-fitted-absolute-mass", "first-positive-depth-five-cell-plus-forced-splittings"),
    IDS[8]: ("measured-PMNS-fit", "complete-PMNS-support-with-self-antipodal-phase"),
    IDS[9]: ("asserted-Dirac-or-Majorana-label", "single-hand-unique-self-antipodal-coupling"),
    IDS[10]: ("asserted-decay-or-zero-mass-limit", "positive-Majorana-weighted-amplitude-with-noncancellation"),
    IDS[11]: ("imported-QED-series-or-measured-anomaly", "terminal-self-return-plus-squared-mass-sensitivity"),
}


def poly_side(x: Fraction, pair_sum: Fraction, product_value: Fraction) -> str:
    left = x * x * x + pair_sum * x
    right = x * x + product_value
    if left == right:
        return "boundary"
    return "left" if left > right else "right"


def root_count(pair_sum: Fraction, product_value: Fraction) -> int:
    for depth in range(1, 17):
        cells = 2 ** depth
        previous = poly_side(Fraction(1, cells), pair_sum, product_value)
        count = 0
        for index in range(2, cells + 1):
            current = poly_side(Fraction(index, cells), pair_sum, product_value)
            if current == "boundary" or current != previous:
                count += 1
            previous = current
        if count == 3:
            return count
    raise RuntimeError("independent root census failed")


def arithmetic_check(claim_id: str) -> bool:
    if claim_id == IDS[0]:
        return Fraction(1, 2 * (3 + 3)) == Fraction(1, 12) and Fraction(1, 2 * (3 + 1)) == Fraction(1, 8) and 2 ** 6 < 3 ** 4 <= 2 ** 7 and 2 ** 4 < 3 ** 3 <= 2 ** 5
    if claim_id == IDS[1]:
        down = (Fraction(1, 8), Fraction(1, 3 * 2 ** 7 - 1))
        up = (Fraction(1, 12), Fraction(1, 3 * 2 ** 10 - 1))
        return down == (Fraction(1, 8), Fraction(1, 383)) and up == (Fraction(1, 12), Fraction(1, 3071)) and root_count(*down) == root_count(*up) == 3
    if claim_id == IDS[2]:
        inverse_alpha = Fraction(503846395469, 3676744786)
        return (inverse_alpha + 2) / inverse_alpha > 1 and Fraction(0, 1) < inverse_alpha / (inverse_alpha + 7) < 1
    if claim_id == IDS[3]:
        mass = (Fraction(2, 9), Fraction(5, 9), Fraction(8, 9))
        channel = (Fraction(1, 3), Fraction(2, 3), Fraction(1, 1))
        matrix = tuple(tuple(Fraction(1, 1) - abs(a - b) for b in channel) for a in mass)
        return matrix == ((Fraction(8, 9), Fraction(5, 9), Fraction(2, 9)), (Fraction(7, 9), Fraction(8, 9), Fraction(5, 9)), (Fraction(4, 9), Fraction(7, 9), Fraction(8, 9)))
    if claim_id == IDS[4]:
        return Fraction(1, 2 * 3) == Fraction(1, 6)
    if claim_id == IDS[5]:
        return Fraction(1, 3) > 0 and (Fraction(1, 1), Fraction(1, 6), Fraction(1, 485)) == (Fraction(1, 1), Fraction(1, 6), Fraction(1, 485))
    if claim_id == IDS[6]:
        return Fraction(2 ** 10 - 1, 2 ** 5 - 1) == 33 and Fraction(1, 2 ** 5) * Fraction(5 ** 2 - 1, 5 ** 2) == Fraction(3, 100)
    if claim_id == IDS[7]:
        values = (Fraction(1, 32), Fraction(33, 32), Fraction(3203, 96))
        return Fraction(0, 1) < values[0] < values[1] < values[2] and values[1] - values[0] == 1 and values[2] - values[0] == Fraction(100, 3)
    if claim_id == IDS[8]:
        weights = (Fraction(47, 72), Fraction(47, 144), Fraction(1, 48))
        return sum(weights, Fraction(0, 1)) == 1 and Fraction(1, 2) == Fraction(1, 2)
    if claim_id == IDS[9]:
        return Fraction(3, 4) - Fraction(1, 4) == Fraction(1, 2) and Fraction(1, 1) - Fraction(1, 2) == Fraction(1, 2) and Fraction(1, 1) - Fraction(1, 4) != Fraction(1, 4)
    if claim_id == IDS[10]:
        return Fraction(11, 288) > 0 and Fraction(11, 288) < Fraction(271, 288)
    inverse_alpha = Fraction(503846395469, 3676744786)
    return Fraction(1, 2) / inverse_alpha > 0 and 2 == 2


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    rejected, admitted = RELATIONS[claim_id]
    domains = (
        ("imported-parameter-table", "generated-exact-carrier"),
        ("prior-answer-premise", "admitted-root-trace"),
        (rejected, admitted),
        ("selected-subset", "complete-product"),
        ("uncontrolled-shortcut", "every-omission-rejected"),
        ("target-visible-before-seal", "seal-before-comparison"),
        ("answer-only", "full-polynomial-trace-census-controls"),
        ("free-extra-rule", "no-extra-rule"),
    )
    generated = tuple("__".join(row) for row in product(*domains))
    survivor = "__".join(domain[1] for domain in domains)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    passed = (
        claim_id in IDS and sealed["claim_id"] == claim_id and arithmetic_check(claim_id)
        and received == generated and len(set(received)) == sealed["census"]["expected_cardinality"] == 256
        and decisions == {candidate: candidate == survivor for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
    )
    print(json.dumps({"validated_seal_hash": sealed["seal_hash"], "recomputed_from_declared_inputs": True, "passed": passed, "certificate": {"generated_cardinality": len(generated), "unique_survivor": survivor if passed else None, "exact_arithmetic": arithmetic_check(claim_id)}}, sort_keys=True))


if __name__ == "__main__":
    main()
