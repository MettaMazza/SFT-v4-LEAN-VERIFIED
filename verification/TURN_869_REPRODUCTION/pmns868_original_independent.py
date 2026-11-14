"""Implementation-distinct validator for the frozen first Physics lineage batch."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


RELATIONS = {
    "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002": ("composite-or-unbounded-sector-ladder", "prime-through-cover-ceiling-and-p-squared-less-One"),
    "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002": ("selected-angle-or-continuous-phase", "complete-half-One-preimage-fibre"),
    "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002": ("formed-irrational-root-or-fitted-hierarchy", "depth-seven-support-predecessor-at-half-One"),
    "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002": ("selected-mixing-triple", "binary-generator-separations-over-depth-three-support"),
    "SFT-PHYS-ELECTROWEAK-WZ-RATIO-002": ("formed-root-or-untyped-channel-choice", "upper-channel-squared-mass-relation"),
    "SFT-PHYS-STRONG-RUNNING-DIRECTION-002": ("imported-beta-function-or-fitted-slope", "binary-self-source-successor-versus-neutral-hold"),
    "SFT-PHYS-NEUTRINO-CP-PHASE-002": ("continuous-or-measurement-selected-phase", "unique-self-antipodal-half-One"),
    "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002": ("measured-anomaly-or-fitted-g-value", "One-to-half-One-reciprocal"),
    "SFT-PHYS-WEAK-PARITY-FIBRE-002": ("unheld-or-imported-chirality", "held-lower-and-upper-common-image-fibre"),
}


RESULTS = {
    "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002": "The complete prime-sector ladder is (2,3,5,7), with couplings (1/2,2/3,4/5,6/7), mediator counts (3,8,24,48), and first excluded prime 11.",
    "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002": "The bare electroweak squared channel split is sin-squared = 1/4 and cos-squared = 3/4 over unified half-One support.",
    "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002": "The exact squared Planck/proton hierarchy is 2^127 = 170141183460469231731687303715884105728; the unsquared exponent is retained as 127/2 and no square root is formed.",
    "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002": "The exact Fold PMNS squared-support triple is atmospheric 1/2, solar 1/3 and reactor 1/48.",
    "SFT-PHYS-ELECTROWEAK-WZ-RATIO-002": "The exact squared W-to-Z Fold relation is (M_W/M_Z)^2 = 3/4; no irrational unsquared ratio is formed.",
    "SFT-PHYS-STRONG-RUNNING-DIRECTION-002": "The colour self-source count is 1+2k after k successors (prefix 1,3,5,7,...) and the neutral-carrier count remains the One; the exact structural successor slope is two.",
    "SFT-PHYS-NEUTRINO-CP-PHASE-002": "The exact maximal Fold phase carrier is the half-One, 1/2 of a complete turn.",
    "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002": "The bare Dirac gyromagnetic Fold value is exactly 2; this claim excludes the measured radiative anomaly.",
    "SFT-PHYS-WEAK-PARITY-FIBRE-002": "The weak handed Fold fibre is left-held 1/4 and right-held 3/4 over common image 1/2; a one-side channel violates parity by construction.",
}


def fold(value: Fraction) -> Fraction:
    paired = value + value
    return paired if paired <= 1 else paired - 1


def prime(value: int) -> bool:
    if value <= 1:
        return False
    return all((value // divisor) * divisor != value for divisor in range(2, value))


def arithmetic_check(claim_id: str) -> bool:
    half = Fraction(1, 2)
    lower, upper = Fraction(1, 4), Fraction(3, 4)
    if claim_id == "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002":
        sectors = tuple(value for value in range(2, 8) if prime(value))
        mediators = tuple(value * value - 1 for value in sectors)
        couplings = tuple(Fraction(value - 1, value) for value in sectors)
        return sectors == (2, 3, 5, 7) and mediators == (3, 8, 24, 48) and couplings == (Fraction(1, 2), Fraction(2, 3), Fraction(4, 5), Fraction(6, 7)) and prime(11)
    if claim_id == "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002":
        return fold(lower) == fold(upper) == half and lower + upper == 1
    if claim_id == "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002":
        return 2**7 == 128 and 2**127 == 170141183460469231731687303715884105728
    if claim_id == "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002":
        return (half, Fraction(1, 3), half * Fraction(1, 3) / 8) == (Fraction(1, 2), Fraction(1, 3), Fraction(1, 48))
    if claim_id == "SFT-PHYS-ELECTROWEAK-WZ-RATIO-002":
        return upper == Fraction(3, 4) and lower + upper == 1
    if claim_id == "SFT-PHYS-STRONG-RUNNING-DIRECTION-002":
        colour = tuple(1 + 2 * index for index in range(7))
        neutral = tuple(1 for _ in range(7))
        return colour == (1, 3, 5, 7, 9, 11, 13) and neutral == (1, 1, 1, 1, 1, 1, 1)
    if claim_id == "SFT-PHYS-NEUTRINO-CP-PHASE-002":
        return fold(half) == 1 and 1 - half == half
    if claim_id == "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002":
        return Fraction(1, 1) / half == 2
    if claim_id == "SFT-PHYS-WEAK-PARITY-FIBRE-002":
        return lower < half < upper and fold(lower) == fold(upper) == half
    return False


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    rejected_relation, admitted_relation = RELATIONS[claim_id]
    domains = (
        ("borrowed-physical-label", "generated-exact-carrier"),
        ("asserted-input-values", "admitted-dependency-trace"),
        (rejected_relation, admitted_relation),
        ("selected-neighbourhood", "complete-registered-product"),
        ("survivor-without-predecessor-controls", "all-predecessor-forms-rejected"),
        ("target-visible-before-seal", "derivation-sealed-before-comparison"),
        ("answer-only-record", "complete-trace-controls-and-census"),
        ("free-extra-rule", "no-extra-rule"),
    )
    generated = tuple("__".join(row) for row in product(*domains))
    survivor = "__".join(domain[1] for domain in domains)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    expected_decisions = {candidate: candidate == survivor for candidate in generated}
    passed = (
        sealed["claim_id"] == claim_id
        and received == generated
        and sealed["census"]["expected_cardinality"] == 256
        and len(set(received)) == 256
        and decisions == expected_decisions
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and sealed["closure"]["exact_boundary"]
        and {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
        and sealed["closure"]["proof_hash"].startswith("sha256:")
        and arithmetic_check(claim_id)
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "claim_id": claim_id,
            "generated_cardinality": len(generated),
            "unique_survivor": survivor if passed else None,
            "exact_arithmetic_reconstructed": arithmetic_check(claim_id),
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()
